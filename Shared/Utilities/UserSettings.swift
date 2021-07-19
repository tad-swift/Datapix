//
//  UserSettings.swift
//  Datapix
//
//  Created by Tadreik Campbell on 9/29/20.
//

import Foundation
import Combine

class UserSettings: ObservableObject {
    
    @Published var firstUse: Bool {
        didSet {
            UserDefaults.standard.set(firstUse, forKey: "First Use")
        }
    }
    
    @Published var cameraModelChecked: Bool {
        didSet {
            UserDefaults.standard.set(cameraModelChecked, forKey: "Camera Model")
            NotificationCenter.default.post(name: Notification.Name("refreshText"), object: nil)
        }
    }
    
    @Published var cameraSoftwareChecked: Bool {
        didSet {
            UserDefaults.standard.set(cameraSoftwareChecked, forKey: "Camera Software")
            NotificationCenter.default.post(name: Notification.Name("refreshText"), object: nil)
        }
    }
    
    @Published var apertureChecked: Bool {
        didSet {
            UserDefaults.standard.set(apertureChecked, forKey: "Aperture")
            NotificationCenter.default.post(name: Notification.Name("refreshText"), object: nil)
        }
    }
    
    @Published var focalChecked: Bool {
        didSet {
            UserDefaults.standard.set(focalChecked, forKey: "Focal Length")
            NotificationCenter.default.post(name: Notification.Name("refreshText"), object: nil)
        }
    }
    
    @Published var isoChecked: Bool {
        didSet {
            UserDefaults.standard.set(isoChecked, forKey: "ISO")
            NotificationCenter.default.post(name: Notification.Name("refreshText"), object: nil)
        }
    }
    
    @Published var lensModelChecked: Bool {
        didSet {
            UserDefaults.standard.set(lensModelChecked, forKey: "Lens Model")
            NotificationCenter.default.post(name: Notification.Name("refreshText"), object: nil)
        }
    }
    
    @Published var shutterSpeedChecked: Bool {
        didSet {
            UserDefaults.standard.set(shutterSpeedChecked, forKey: "Shutter Speed")
            NotificationCenter.default.post(name: Notification.Name("refreshText"), object: nil)
        }
    }
    
    @Published var copyrightText: String {
        didSet {
            UserDefaults.standard.set(copyrightText, forKey: "Copyright Text")
            NotificationCenter.default.post(name: Notification.Name("refreshText"), object: nil)
        }
    }
    
    @Published var instagramText: String {
        didSet {
            UserDefaults.standard.set(instagramText, forKey: "Instagram Text")
            NotificationCenter.default.post(name: Notification.Name("refreshText"), object: nil)
        }
    }
    
    @Published var additionalText: String {
        didSet {
            UserDefaults.standard.set(additionalText, forKey: "Notes")
            NotificationCenter.default.post(name: Notification.Name("refreshText"), object: nil)
        }
    }
    
    @Published var blurStyle: String {
        didSet {
            UserDefaults.standard.set(blurStyle, forKey: "Blur Style")
            NotificationCenter.default.post(name: Notification.Name("refresh"), object: nil)
        }
    }
    
    @Published var lowBlur: Bool {
        didSet {
            UserDefaults.standard.set(lowBlur, forKey: "Low Blur")
            NotificationCenter.default.post(name: Notification.Name("refresh"), object: nil)
        }
    }
    
    init() {
        firstUse = UserDefaults.standard.object(forKey: "First Use") as? Bool ?? true
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
