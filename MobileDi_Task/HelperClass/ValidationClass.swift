//
//  ValidationClass.swift
//  Notificationapp
//
//  Created by JBIT services on 12/09/16.
//  Copyright © 2016 JBIT services. All rights reserved.
//

import UIKit

class ValidationClass: NSObject {
    
    static let shared : ValidationClass = {
        let instance = ValidationClass()
        return instance
    }()
    
    func isBlank (textfield:UITextField) -> Bool {
        let thetext = textfield.text
        let trimmedString = thetext!.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines)
        if trimmedString.isEmpty {
            return true
        }
        return false
    }
    
    func validateEmailAddress(yourEmail:NSString)->Bool {
        let emailRegex:String = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
        let email:NSPredicate = NSPredicate(format: "SELF MATCHES %@",emailRegex);
        return email.evaluate(with: yourEmail);
    }
    
    func validPassword(passwordText:String) -> Bool {
        let result = passwordText.characters.count > 5 ? false : true
        return result
    }
    
    func isValidPhoneNumber(value: String) -> Bool {
        let PHONE_REGEX = "[235689][0-9]{6}([0-9]{3})?"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", PHONE_REGEX)
        let result =  phoneTest.evaluate(with: value)
        return result
    }
    
    func ValidateLoginForm(loginObj:LoginVC) -> Bool {
        if isBlank(textfield: loginObj.txtfldEmail) {
            SwAlert.showNoActionAlert(title: Validation_Msg_Title, message: "Email is required.", buttonTitle: "OK")
            return false
        }else if !validateEmailAddress(yourEmail: loginObj.txtfldEmail.text! as NSString) {
            SwAlert.showNoActionAlert(title: Validation_Msg_Title, message: "Please enter a Valid Email Address.", buttonTitle: "OK")
            return false
        }else if isBlank(textfield: loginObj.txtfldPassword) {
            SwAlert.showNoActionAlert(title: Validation_Msg_Title, message: "Password is required.", buttonTitle: "OK")
            return false
        } else {
            return true
        }
    }
    
}
