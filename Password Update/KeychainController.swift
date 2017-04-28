//
//  KeychainController.swift
//  Password Update
//
//  Created by Roberto Mauro on 4/24/17.
//  Copyright © 2017 roberto mauro. All rights reserved.
//

import Foundation
import Security

struct AccountType {
    static let generic = kSecClassGenericPassword
    static let internet = kSecClassInternetPassword
}

class KeychainController {
    private let accountTypes = [AccountType.generic, AccountType.internet]
    
    func add(account:String, password: String, for accountType: CFString) -> Bool {
        let keychainQuery: NSDictionary = [
            kSecClass: accountType,
            kSecAttrLabel: account,
            kSecAttrAccount: account,
            kSecValueData: password.data(using: String.Encoding.utf8)!
        ]
        var dataStatusRef: AnyObject?
        let status = SecItemAdd(keychainQuery, &dataStatusRef)
        
        return status == errSecSuccess
    }
    
    func delete(account: String) -> Bool {
        var success = true
        for accountType in accountTypes {
            if exists(account, for: accountType) {
                let deleted = delete(account, for: accountType)
                if !deleted { success = false }
            }
        }
        return success
    }
    
    func delete(_ account: String, for accountType: CFString) -> Bool {
        let keychainQuery: NSDictionary = [
            kSecClass: accountType,
            kSecAttrAccount: account,
            kSecMatchLimit: kSecMatchLimitAll
        ]
        let status = SecItemDelete(keychainQuery)
        return status == errSecSuccess
    }
    
    func changePassword(account: String, password: String) -> Bool {
        var success = true
        for accountType in accountTypes {
            if exists(account, for: accountType) {
                let updated = update(account, with: password, for: accountType)
                if !updated && success {
                    success = false
                }
            }
        }
        
        return success
    }
    
    func exists(_ account: String) -> Bool {
        var success = false
        for accountType in accountTypes {
            let hasAccount = exists(account, for: accountType)
            if hasAccount && !success {
                success = true
            }
        }
        return success
    }
    
    func exists(_ account: String, for accountType: CFString) -> Bool {
        let keychainQuery: NSDictionary = [
            kSecClass: accountType,
            kSecAttrAccount: account,
            kSecMatchLimit : kSecMatchLimitOne
        ]
        var dataTypeRef: AnyObject?
        let status = SecItemCopyMatching(keychainQuery, &dataTypeRef)
        return status == errSecSuccess
    }
    
    func update(_ account: String, with password: String, for accountType: CFString) -> Bool {
        let keychainQueryGeneric: NSDictionary = [
            kSecClass: accountType,
            kSecAttrAccount: account,
            kSecMatchLimit : kSecMatchLimitAll
        ]
        let updateDict: NSDictionary = [
            kSecValueData: password.data(using: String.Encoding.utf8)!
        ]
        let status = SecItemUpdate(keychainQueryGeneric, updateDict)
        return status == errSecSuccess
    }
}
