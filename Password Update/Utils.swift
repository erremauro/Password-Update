//
//  Utils.swift
//  Password Update
//
//  Created by Roberto Mauro on 4/23/17.
//  Copyright © 2017 roberto mauro. All rights reserved.
//

import Cocoa
import Foundation

class Utils {
    static func getAppName() -> String {
        let kBundleName = kCFBundleNameKey as String
        let appTitle = Bundle.main.infoDictionary![kBundleName] as! String
        return appTitle.capitalized
    }
    
    static func getBundleId() -> String {
        return Bundle.main.bundleIdentifier!
    }
    
    static func dialogWith(title: String, text: String, isOK: Bool = true) {
        let popUp = NSAlert()
        popUp.messageText = title
        popUp.informativeText = text
        popUp.alertStyle = isOK
            ? NSAlertStyle.informational
            : NSAlertStyle.warning
        popUp.addButton(withTitle: "OK")
        popUp.runModal()
    }
    
    static func shakeWindow(_ window: NSWindow) {
        let numberOfShakes:Int = 4
        let durationOfShake:Float = 0.6
        let vigourOfShake:Float = 0.01
        
        let frame:CGRect = (window.frame)
        let shakeAnimation = CAKeyframeAnimation()
        
        let shakePath = CGMutablePath()
        shakePath.move(to: CGPoint(x: NSMinX(frame), y: NSMinY(frame)))
        
        for _ in 1...numberOfShakes {
            shakePath.addLine(to: CGPoint(
                x:NSMinX(frame) - frame.size.width * CGFloat(vigourOfShake),
                y: NSMinY(frame)
            ))
            shakePath.addLine(to: CGPoint(
                x:NSMinX(frame) + frame.size.width * CGFloat(vigourOfShake),
                y: NSMinY(frame)
            ))
        }
        
        shakePath.closeSubpath()
        shakeAnimation.path = shakePath
        shakeAnimation.duration = CFTimeInterval(durationOfShake)
        window.animations = ["frameOrigin":shakeAnimation]
        window.animator().setFrameOrigin((window.frame.origin))
    }
}
