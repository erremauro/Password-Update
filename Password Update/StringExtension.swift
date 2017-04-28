//
//  StringExtension.swift
//  Password Update
//
//  Created by Roberto Mauro on 4/27/17.
//  Copyright © 2017 roberto mauro. All rights reserved.
//

import Foundation

public extension String {
    public var localized: String {
        return NSLocalizedString(self, comment: "")
    }
}
