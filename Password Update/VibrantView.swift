//
//  VibrantView.swift
//  Password Update
//
//  Created by Roberto Mauro on 4/28/17.
//  Copyright © 2017 roberto mauro. All rights reserved.
//

import Cocoa

class VibrantView: NSVisualEffectView {
    override var allowsVibrancy: Bool { get { return true } }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.blendingMode = NSVisualEffectBlendingMode.behindWindow
        self.material = NSVisualEffectMaterial.light
        self.appearance = NSAppearance(named: NSAppearanceNameVibrantLight)
    }
}
