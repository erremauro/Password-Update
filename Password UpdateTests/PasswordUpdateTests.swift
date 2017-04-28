//
//  PasswordUpdateTests.swift
//  Password Update
//
//  Created by Roberto Mauro on 4/23/17.
//  Copyright © 2017 roberto mauro. All rights reserved.
//

import XCTest

class PasswordUpdateTests: XCTestCase {
    
    func testValidation() {
        let validator = PasswordUpdate()
        var validationItems = [ValidationItem]()
        let usernameItem = ValidationItem(
            fieldName: "username", value: "test", minLength: 8, required: true)
        let passwordItem = ValidationItem(
            fieldName: "password", value: "test", minLength: 8, required: true)
        let confirmItem = ValidationItem(
            fieldName: "confirm", value: "test", minLength: 8, required: true)

        validationItems.append(contentsOf: [usernameItem, passwordItem, confirmItem])
        let result = validator.validate(items: validationItems)
        
        assert(result.isOK == false)
    }

}
