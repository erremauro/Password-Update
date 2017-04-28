//
//  PasswordUpdate.swift
//  Password Update
//
//  Created by Roberto Mauro on 4/23/17.
//  Copyright © 2017 roberto mauro. All rights reserved.
//

import Foundation

public struct Localizable {
    static let accountNotFound = "ACCOUNT_NOT_FOUND"
    static let characters = "CHARACTERS"
    static let fieldRequired = "FIELD_REQUIRED"
    static let fielMinLenRequired = "FIELD_MIN_LEN_REQUIRED"
    static let passwordUpdateSuccess = "PASSWORD_UPDATE_SUCCESS"
    static let passwordUpdateFailure = "PASSWORD_UPDATE_FAILURE"
    static let passwordDontMatchTitle = "PASSWORDS_DONT_MATCH_TITLE"
    static let passwordDontMatchDescription = "PASSWORDS_DONT_MATCH_DESCRIPTION"
}

struct ValidationError {
    var fieldName: String
    var message: String
    var key: String
}

struct ValidationItem {
    var fieldName: String
    var value: String
    var minLength: Int
    var required: Bool
}

struct ValidationResult {
    var isOK: Bool
    var errors: [ValidationError]
}

struct UpdateResult {
    var isOk: Bool
    var message: String
}

class PasswordUpdate {
    let keychain = KeychainController()
    
    func updateWith(username: String, password: String) -> UpdateResult {
        if !keychain.exists(username) {
            return UpdateResult(
                isOk: false,
                message: "\(Localizable.accountNotFound.localized): \(username)"
            )
        }
        
        let success = keychain.changePassword(account: username, password: password)
        let message = success
            ? Localizable.passwordUpdateSuccess.localized
            : Localizable.passwordUpdateFailure.localized
        return UpdateResult(isOk: success, message: message)
    }
    
    func validate(items: [ValidationItem]) -> ValidationResult {
        var isValid = true
        var errors = [ValidationError]()
        
        for item in items {
            let requiredError = validateRequired(item)
            let lenError = validateLength(item)
            
            if requiredError != nil || lenError != nil {
                isValid = false
            }
            
            if requiredError != nil {
                errors.append(requiredError!)
            }
            
            if lenError != nil {
                errors.append(lenError!)
            }
        }
        
        return ValidationResult(isOK: isValid, errors: errors)
    }
    
    // MARK: - Validation Methods
    
    private func validateRequired(_ item: ValidationItem) -> ValidationError? {
        if (item.required && item.value == "") {
            let validationError = ValidationError(
                fieldName: item.fieldName,
                message: Localizable.fieldRequired.localized,
                key: Localizable.fieldRequired
            )
            return validationError
        }
        
        return nil
    }
    
    private func validateLength(_ item: ValidationItem) -> ValidationError? {
        let valueLen = item.value.characters.count
        
        if (item.value != "" && valueLen > item.minLength) {
            return nil
        }
        
        let validationErrorMessage = "\(Localizable.fielMinLenRequired.localized)" +
            "\(item.minLength) \(Localizable.characters.localized)"
        
        let validationError = ValidationError(
            fieldName: item.fieldName,
            message: validationErrorMessage,
            key: Localizable.fielMinLenRequired
        )
        
        return validationError
    }
}
