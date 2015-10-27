//
//  SwiftLoginTests.swift
//  RUF City Campus
//
//  Created by Brenton Durkee on 10/15/15.
//  Copyright (c) 2015 Brenton Durkee. All rights reserved.
//

import Foundation

class SwiftLoginTests: KIFTestCase{
    func testLogin() {
        login()
    }
}

private extension SwiftLoginTests {
    enum ButtonLabel: String {
        case Login = "LogIn Button"
        case Switch = "Need An Account"
        case Back = "Back"
    }
    
    enum TextFieldLabel: String {
        case Email = "Email"
        case Password = "Password"
    }
    
    enum LabelsInView: String {
        case Welcome = "Welcome Message"
        case Events = "Events"
        case Signups = "Signups"
    }
    
    enum TextInputs: String {
        case Email = "admin@brentondurkee.com"
        case Password = "123"
    }
}

private extension SwiftLoginTests {
    func login() {
        tester.waitForViewWithAccessibilityLabel(LabelsInView.Welcome.rawValue)
        
        tester.clearTextFromAndThenEnterText(TextInputs.Email.rawValue, intoViewWithAccessibilityLabel: TextFieldLabel.Email.rawValue)
        tester.clearTextFromAndThenEnterText(TextInputs.Password.rawValue, intoViewWithAccessibilityLabel: TextFieldLabel.Password.rawValue)
        tester.tapViewWithAccessibilityLabel(ButtonLabel.Login.rawValue)
        
        tester.waitForTappableViewWithAccessibilityLabel(LabelsInView.Events.rawValue)
    }
}