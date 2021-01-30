//
//  ImagePicker.swift
//  Datapix
//
//  Created by Tadreik Campbell on 1/28/21.
//

import SwiftUI
import PhotosUI

struct ImagePicker: UIViewControllerRepresentable {
    @Binding var selectedImage: CIImage
    @Binding var errorList: [String]
    @Binding var dataDict: Dictionary<String, String>
    @Environment(\.presentationMode) private var presentationMode
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> PHPickerViewController {
        var configuration = PHPickerConfiguration(photoLibrary: PHPhotoLibrary.shared())
        configuration.selectionLimit = 1
        configuration.filter = .images
        let controller = PHPickerViewController(configuration: configuration)
        controller.delegate = context.coordinator
        return controller
    }
    
    func updateUIViewController(_ uiViewController: PHPickerViewController, context: UIViewControllerRepresentableContext<ImagePicker>) {
        
    }
    
    final class Coordinator: NSObject, PHPickerViewControllerDelegate, UINavigationControllerDelegate {
        var parent: ImagePicker
        let settings = UserSettings()
        
        init(_ parent: ImagePicker) {
            self.parent = parent
        }
        
        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            parent.errorList.removeAll()
            var exifData: NSDictionary!
            var tiffData: NSDictionary!
            let identifiers = results.compactMap(\.assetIdentifier)
            let fetchResult = PHAsset.fetchAssets(withLocalIdentifiers: identifiers, options: nil)
            guard let imageAsset = fetchResult.firstObject else {
                parent.presentationMode.wrappedValue.dismiss()
                return
            }
            
            let manager = PHImageManager.default()
            let requestOptions = PHImageRequestOptions()
            requestOptions.isSynchronous = true
            requestOptions.deliveryMode = .highQualityFormat
            requestOptions.isNetworkAccessAllowed = true
            manager.requestImageDataAndOrientation(for: imageAsset, options: requestOptions) { [self] (data, fileName, orientation, info) in
                if let data = data,
                   let cImage = CIImage(data: data) {
                    exifData = cImage.properties["{Exif}"] as? NSDictionary
                    tiffData = cImage.properties["{TIFF}"] as? NSDictionary
                    self.parent.selectedImage = cImage
                    var cameraModel: String?
                    
                    if tiffData != nil {
                        if let cameraModelD = tiffData["Model"] {
                            cameraModel = cameraModelD as? String
                            parent.dataDict["Camera Model"] = cameraModelD as? String
                        } else {
                            parent.errorList.append("Camera model not found")
                        }
                        if let cameraSoftware = tiffData["Software"] as? String {
                            let make = tiffData["Make"] as? String
                            if make == "Apple" {
                                parent.dataDict["Camera Software"] = "iOS \(cameraSoftware)"
                            } else {
                                parent.dataDict["Camera Software"] = ""
                            }
                        } else {
                            parent.errorList.append("Camera software not found")
                        }
                    } else {
                        parent.errorList.append("No TIFF data available")
                    }
                    if exifData != nil {
                        if let aperture = exifData["FNumber"] {
                            parent.dataDict["Aperture"] = "ƒ/\(aperture)"
                        } else {
                            parent.errorList.append("Aperture not found")
                        }
                        if let focalLength = exifData["FocalLenIn35mmFilm"] {
                            parent.dataDict["Focal Length"] = "\(focalLength)mm"
                        } else {
                            parent.errorList.append("Focal length not found")
                        }
                        if let isoValue = exifData["ISOSpeedRatings"] {
                            let isoArray = (isoValue as! Array<Any>)
                            let isoInt = isoArray.first as! Int
                            parent.dataDict["ISO"] = "ISO \(isoInt)"
                        } else {
                            parent.errorList.append("ISO not found")
                        }
                        if let lensModel = exifData["LensModel"] {
                            let lensString = lensModel as! String
                            if lensString.contains("iPhone") && lensString.contains("back") {
                                parent.dataDict["Lens Model"] = "\(cameraModel ?? "iPhone") rear camera"
                            } else {
                                parent.dataDict["Lens Model"] = lensString
                            }
                        } else {
                            parent.errorList.append("Lens model not found")
                        }
                        if let shutterSpeedValue = exifData["ShutterSpeedValue"] {
                            let shutterSpeed = ceil(pow(2.0, Double(truncating: shutterSpeedValue as! NSNumber)))
                            parent.dataDict["Shutter Speed"] = "1/\(Int(shutterSpeed)) sec"
                        } else {
                            parent.errorList.append("Shutter speed not found")
                        }
                    } else {
                        parent.errorList.append("No Exif data available")
                    }
                    parent.dataDict["Instagram Text"] = settings.instagramText
                    parent.dataDict["Notes"] = settings.additionalText
                    parent.dataDict["Copyright Text"] = settings.copyrightText
                }
            }
            NotificationCenter.default.post(name: Notification.Name("refresh"), object: nil)
            parent.presentationMode.wrappedValue.dismiss()
        }
        
    }
}
