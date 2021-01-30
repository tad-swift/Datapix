//
//  PreviewScreen.swift
//  Datapix
//
//  Created by Tadreik Campbell on 9/23/20.
//

import SwiftUI
import PhotosUI

struct PreviewScreen: View {
    let refresh = NotificationCenter.default.publisher(for: NSNotification.Name("refresh"))
    @State private var bottomSheetShown = false
    @State private var tempImg = CIImage()
    @State private var original = CIImage(image: UIImage(named: "datapixbg")!)!
    @State private var showingAlert = false
    @State private var showSettings = false
    @State private var isShowPhotoLibrary = false
    @State private var didSelectImage = false
    @State private var image = UIImage(named: "datapixbg")!
    @State private var errors = [String]()
    private var stringRep: String { return errors.joined(separator:"\n") }
    @State private var dict: [String: String] = [
        "Camera Model":"",
        "Camera Software":"",
        "Focal Length":"",
        "Aperture":"",
        "ISO":"",
        "Lens Model":"",
        "Shutter Speed":"",
        "Notes":"",
        "Instagram":"",
        "Copyright":""]
    
    var body: some View {
        VStack {
            
            MyShadowImageView.init(image: $image)
                .frame(width: 400, height: 400)
            
            HStack {
                Button(action: {
                    isShowPhotoLibrary.toggle()
                }) {
                    Image(systemName: "photo.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .foregroundColor(.accentColor)
                }
                .frame(width: 26, height: 26)
                .padding(.all, 6)
                .sheet(isPresented: $isShowPhotoLibrary) {
                    ImagePicker(selectedImage: $original, errorList: $errors, dataDict: $dict)
                }
                Spacer()
                Button(action: {
                    ImageSaver().writeToPhotoAlbum(image: image)
                    showingAlert = true
                }) {
                    Image(systemName: "square.and.arrow.down")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .foregroundColor(.accentColor)
                }
                .frame(width: 26, height: 26)
                .padding(.all, 6)
                .alert(isPresented: $showingAlert) {
                            Alert(title: Text("Photo saved to your library"), dismissButton: .default(Text("Got it!")))
                        }
                
            }
            .padding(.bottom, 8)
            .padding(.horizontal, 12)
            Spacer()
            GeometryReader { geometry in
                BottomSheetView(isOpen: $bottomSheetShown, maxHeight: geometry.size.height * 1.7) {
                    SettingsScreen()
                }
            }.ignoresSafeArea()
        }
        .padding(.top, 10)
        .navigationBarTitleDisplayMode(.inline)
        .onReceive(refresh, perform: { _ in
            createImage()
        })
    }
    
    func resetDict() {
        dict = [
            "Camera Model":"",
            "Camera Software":"",
            "Focal Length":"",
            "Aperture":"",
            "ISO":"",
            "Lens Model":"",
            "Shutter Speed":"",
            "Notes":"",
            "Instagram":"",
            "Copyright":""]
    }
    
    func createImage() {
        tempImg = original
        if UserSettings().lowBlur == true {
            let newImg = blurredImage(input: darkenImage(input: tempImg), strength: 10, style: UserSettings().blurStyle)
            addTextToImage(item: newImg, atPoint: .zero)
        } else {
            let newImg = blurredImage(input: darkenImage(input: tempImg), strength: 25, style: UserSettings().blurStyle)
            addTextToImage(item: newImg, atPoint: .zero)
        }
    }
    
    func darkenImage(input: CIImage) -> CIImage {
        let filter = CIFilter(name: "CIExposureAdjust")
        
        // The inputEV value on the CIFilter adjusts exposure (negative values darken, positive values brighten)
        filter?.setValue(input, forKey: "inputImage")
        filter?.setValue(-2.0, forKey: "inputEV")
        
        // Break early if the filter was not a success (.outputImage is optional in Swift)
        guard let filteredImage = filter?.outputImage else { return input }
        
        let context = CIContext(options: nil)
        let outputImage = CIImage(cgImage: context.createCGImage(filteredImage, from: filteredImage.extent)!)
        
        return outputImage
    }
    
    func setupDict() -> [String] {
        var cameraModel: String
        var cameraSoftware: String
        var focalLength: String
        var aperture: String
        var iso: String
        var lensModel: String
        var shutterSpeed: String
        var insta: String
        var notes: String
        var copyright: String
        var dataList = [String]()
        
        if UserSettings().cameraModelChecked {
            if dict["Camera Model"] != nil {
                cameraModel = dict["Camera Model"]!
                dataList.append(cameraModel)
            }
        }
        if UserSettings().cameraSoftwareChecked {
            if dict["Camera Software"] != nil {
                cameraSoftware = dict["Camera Software"]!
                dataList.append(cameraSoftware)
            }
        }
        if UserSettings().focalChecked {
            if dict["Focal Length"] != nil {
                focalLength = dict["Focal Length"]!
                dataList.append(focalLength)
            }
        }
        if UserSettings().apertureChecked {
            if dict["Aperture"] != nil {
                aperture = dict["Aperture"]!
                dataList.append(aperture)
            }
        }
        if UserSettings().isoChecked {
            if dict["iso"] != nil {
                iso = dict["iso"]!
                dataList.append(iso)
            }
        }
        if UserSettings().lensModelChecked {
            if dict["Lens Model"] != nil {
                lensModel = dict["Lens Model"]!
                dataList.append(lensModel)
            }
        }
        if UserSettings().shutterSpeedChecked {
            if dict["Shutter Speed"] != nil {
                shutterSpeed = dict["Shutter Speed"]!
                dataList.append(shutterSpeed)
            }
        }
        
        if dict["Instagram Text"] != nil {
            insta = dict["Instagram Text"]!
            dataList.append(insta)
        }
        if dict["Copyright Text"] != nil {
            if dict["Copyright Text"]!.count > 0 {
                copyright = dict["Copyright Text"]!
                dataList.append("© \(copyright)")
            }
        }
        if dict["Notes"] != nil {
            notes = dict["Notes"]!
            dataList.append(notes)
        }
        
        dataList = dataList.filter { (!$0.isEmpty) }
        return dataList
    }
    
    func blurredImage(input: CIImage, strength: Int, style: String) -> UIImage {
        let context = CIContext(options: nil)
        let clampFilter = CIFilter(name: "CIAffineClamp")
        clampFilter?.setDefaults()
        clampFilter?.setValue(input, forKey: kCIInputImageKey)
        
        let blurFilter = CIFilter(name: style)
        blurFilter?.setValue(clampFilter?.outputImage, forKey: kCIInputImageKey)
        blurFilter?.setValue(strength, forKey: kCIInputRadiusKey)
        
        let result = blurFilter?.value(forKey: kCIOutputImageKey) as? CIImage
        let cgImage = context.createCGImage(result!, from: input.extent )
        
        let processedImage = UIImage(cgImage: cgImage!, scale: UIImage(ciImage: input).scale, orientation: .up)
        
        return processedImage
    }
    
    func addTextToImage(item: UIImage, atPoint: CGPoint) {
        // Setup the font specific variables
        let textColor = UIColor.white
        let textFont = UIFont.systemFont(ofSize: item.size.width / 17)
        
        // Setup the font attributes that will be later used to dictate how the text should be drawn
        let textFontAttributes = [
            NSAttributedString.Key.font: textFont,
            NSAttributedString.Key.foregroundColor: textColor
        ]
        
        // Create bitmap based graphics context
        UIGraphicsBeginImageContextWithOptions(item.size, false, 0.0)
        
        // Put the image into a rectangle as large as the original image.
        item.draw(in: CGRect(x: 0, y: 0, width: item.size.width, height: item.size.height))
        
        // Our drawing bounds
        // let drawingBounds = CGRect(x: 0.0, y: 0.0, width: inImage.size.width, height: inImage.size.height)
        
        // let textSize = text.size(withAttributes: [NSAttributedString.Key.font:textFont])
        let textRect = CGRect(x: item.size.width / 20, y: item.size.height / 20, width: item.size.width, height: item.size.height)
        let dataString = setupDict().joined(separator: "\n") as NSString
        dataString.draw(in: textRect, withAttributes: textFontAttributes)
        // Get the image from the graphics context
        image = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
    }
    
}
