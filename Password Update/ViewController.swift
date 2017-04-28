//
//  ViewController.swift
//  Password Update
//
//  Created by Roberto Mauro on 4/23/17.
//  Copyright © 2017 roberto mauro. All rights reserved.
//

import Cocoa

class ViewController: NSViewController, NSTextFieldDelegate {
    
    @IBOutlet weak var usernameTextField: NSTextField!
    @IBOutlet weak var passwordTextField: NSSecureTextField!
    @IBOutlet weak var confirmTextField: NSSecureTextField!
    @IBOutlet weak var updateButton: NSButton!
    
    let passwordUpdate = PasswordUpdate()

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear() {
        super.viewDidAppear()
        self.view.window!.title = Utils.getAppName()
        updateButton.isEnabled = false
        
        let username = UserDefaults.standard.string(forKey: "username")
        if username != nil {
            usernameTextField.stringValue = username!
        }
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }

    @IBAction func updatePassword(_ sender: Any) {
        if (passwordTextField.stringValue != confirmTextField.stringValue) {
            Utils.dialogWith(
                title: Localizable.passwordDontMatchTitle.localized,
                text: Localizable.passwordDontMatchDescription.localized,
                isOK: false
            )
            return
        }
        
        // udpate password
        let updateResult = passwordUpdate.updateWith(
            username: usernameTextField.stringValue,
            password: passwordTextField.stringValue
        )
        
        if (updateResult.isOk == false) {
            // show error
            Utils.dialogWith(
                title: Localizable.passwordUpdateFailure.localized,
                text: updateResult.message,
                isOK: updateResult.isOk
            )
            return
        }
        
        UserDefaults.standard.set(usernameTextField.stringValue,
                                  forKey: "username")
        Utils.dialogWith(title: Localizable.passwordUpdateSuccess.localized,
                         text: updateResult.message)
    }
    
    private func inputIsValid() -> Bool {
        let usernameItem = ValidationItem(
            fieldName: "username",
            value: usernameTextField.stringValue,
            minLength: 3,
            required: true)
        let passwordItem = ValidationItem(
            fieldName: "password",
            value: passwordTextField.stringValue,
            minLength: 8,
            required: true)
        let confirmItem = ValidationItem(
            fieldName: "confirm",
            value: confirmTextField.stringValue, minLength: 8,
            required: true)
        
        let validateResult = passwordUpdate.validate(
            items: [usernameItem, passwordItem, confirmItem])
        
        return validateResult.isOK
    }

    // MARK: - Text Field Delegate
    
    override func controlTextDidChange(_ obj: Notification) {
        updateButton.isEnabled = inputIsValid()
    }
    
    func control(_ control: NSControl, textView: NSTextView,
                 doCommandBy commandSelector: Selector) -> Bool {
        let enterPressed = commandSelector == #selector(NSResponder.insertNewline(_:))
        if updateButton.isEnabled && enterPressed {
            self.updatePassword(control)
            return true
        }
        
        return false
    }
}

