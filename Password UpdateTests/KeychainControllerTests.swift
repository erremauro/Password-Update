//
//  KeychainControllerTests.swift
//  Password Update
//
//  Created by Roberto Mauro on 4/24/17.
//  Copyright © 2017 roberto mauro. All rights reserved.
//

import XCTest

class KeychainControllerTests: XCTestCase {
    
    let keychain = KeychainController()
    
    let kTestAccount = "kTestAccount"
    let kTestPassword = "kT35tP4$$w0rd"
    let kNewTestPassword = "kN3wT35tP4$$w0rd"
    let kNonExistentAccount = "non-esistent@account.test"
    
    override func setUp() {
        let created = keychain.add(account: kTestAccount,
                                   password: kTestPassword,
                                   for: AccountType.generic)
        assert(created == true)
    }
    
    override func tearDown() {
        let deleted = keychain.delete(account: kTestAccount)
        assert(deleted == true)
    }
    
    func testAccountExists() {
        let exists = keychain.exists(kTestAccount)
        assert(exists == true)
    }
    
    func testAccountDoesNotExists() {
        let exists = keychain.exists(kNonExistentAccount)
        assert(exists == false)
    }
    
    func testPasswordUpdateExists() {
        assert(keychain.changePassword(account: kTestAccount,
                                       password: kNewTestPassword) == true)
    }
}
