//
//  UserSettings.swift
//  Datapix
//
//  Created by Tadreik Campbell on 9/29/20.
//

import Foundation
import Combine

class UserSettings: ObservableObject {
    
    @Published var cameraModelChecked: Bool {
        didSet {
            UserDefaults.standard.set(cameraModelChecked, forKey: "Camera Model")
            DispatchQueue.main.async {
                NotificationCenter.default.post(name: Notification.Name("refresh"), object: nil)
            }
        }
    }
    
    @Published var cameraSoftwareChecked: Bool {
        didSet {
            UserDefaults.standard.set(cameraSoftwareChecked, forKey: "Camera Software")
            DispatchQueue.main.async {
                NotificationCenter.default.post(name: Notification.Name("refresh"), object: nil)
            }
        }
    }
    
    @Published var apertureChecked: Bool {
        didSet {
            UserDefaults.standard.set(apertureChecked, forKey: "Aperture")
            DispatchQueue.main.async {
                NotificationCenter.default.post(name: Notification.Name("refresh"), object: nil)
            }
        }
    }
    
    @Published var focalChecked: Bool {
        didSet {
            UserDefaults.standard.set(focalChecked, forKey: "Focal Length")
            DispatchQueue.main.async {
                NotificationCenter.default.post(name: Notification.Name("refresh"), object: nil)
            }
        }
    }
    
    @Published var isoChecked: Bool {
        didSet {
            UserDefaults.standard.set(isoChecked, forKey: "ISO")
            DispatchQueue.main.async {
                NotificationCenter.default.post(name: Notification.Name("refresh"), object: nil)
            }
        }
    }
    
    @Published var lensModelChecked: Bool {
        didSet {
            UserDefaults.standard.set(lensModelChecked, forKey: "Lens Model")
            DispatchQueue.main.async {
                NotificationCenter.default.post(name: Notification.Name("refresh"), object: nil)
            }
        }
    }
    
    @Published var shutterSpeedChecked: Bool {
        didSet {
            UserDefaults.standard.set(shutterSpeedChecked, forKey: "Shutter Speed")
            DispatchQueue.main.async {
                NotificationCenter.default.post(name: Notification.Name("refresh"), object: nil)
            }
        }
    }
    
    @Published var copyrightText: String {
        didSet {
            UserDefaults.standard.set(copyrightText, forKey: "Copyright Text")
        }
    }
    
    @Published var instagramText: String {
        didSet {
            UserDefaults.standard.set(instagramText, forKey: "Instagram Text")
        }
    }
    
    @Published var additionalText: String {
        didSet {
            UserDefaults.standard.set(additionalText, forKey: "Notes")
        }
    }
    
    @Published var blurStyle: String {
        didSet {
            UserDefaults.standard.set(blurStyle, forKey: "Blur Style")
            print("blur changed")
            DispatchQueue.main.async {
                NotificationCenter.default.post(name: Notification.Name("refresh"), object: nil)
            }
        }
    }
    
    @Published var lowBlur: Bool {
        didSet {
            UserDefaults.standard.set(lowBlur, forKey: "Low Blur")
            DispatchQueue.main.async {
                NotificationCenter.default.post(name: Notification.Name("refresh"), object: nil)
            }
        }
    }
    
    init() {
        cameraModelChecked = UserDefaults.standard.object(forKey: "Camera Model") as? Bool ?? true
        cameraSoftwareChecked = UserDefaults.standard.object(forKey: "Camera Software") as? Bool ?? true
        apertureChecked = UserDefaults.standard.object(forKey: "Aperture") as? Bool ?? true
        focalChecked = UserDefaults.standard.object(forKey: "Focal Length") as? Bool ?? true
        isoChecked = UserDefaults.standard.object(forKey: "ISO") as? Bool ?? true
        lensModelChecked = UserDefaults.standard.object(forKey: "Lens Model") as? Bool ?? true
        shutterSpeedChecked = UserDefaults.standard.object(forKey: "Shutter Speed") as? Bool ?? true
        copyrightText = UserDefaults.standard.object(forKey: "Copyright Text") as? String ?? ""
        instagramText = UserDefaults.standard.object(forKey: "Instagram Text") as? String ?? ""
        additionalText = UserDefaults.standard.object(forKey: "Notes") as? String ?? ""
        blurStyle = UserDefaults.standard.object(forKey: "Blur Style") as? String ?? "CIGaussianBlur"
        lowBlur = UserDefaults.standard.object(forKey: "Low Blur") as? Bool ?? true
    }
}
