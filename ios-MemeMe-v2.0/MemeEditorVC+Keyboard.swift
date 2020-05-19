//
//  ViewController+Keyboard.swift
//  ios-MemeMe-v1.0
//
//  Created by Abdullah Khayat on 5/17/20.
//  Copyright © 2020 Team IOS. All rights reserved.
//

import Foundation
import UIKit

extension MemeEditorVC {
    
    // when touch outside the keyboard area
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
        super.touchesBegan(touches, with: event)
    }
    
    // subscribe to notifications (that are posted by observers)
    func subscribeToKeyboardNotification() {
        
        // create observer to keyboardWillShowNotification
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        // create observer to keyboardWillHideNotification
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        // finally the keyboard will post the notification
    }
    
    // delete observers
    func unsubscribeFromKeyboardNotification() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    // moves the view by the keyboard height
    @objc func keyboardWillShow(_ notification: Notification) {
        if bottomTF.isFirstResponder {
            view.frame.origin.y = -getKeyboardHeight(notification)
        }
    }
    
    // set the view height back by the keyboard height
    @objc func keyboardWillHide(_ notification: Notification) {
        if bottomTF.isFirstResponder {
            view.frame.origin.y = 0
        }
    }
    
    // gets the keyboard height
    func getKeyboardHeight(_ notification: Notification) -> CGFloat {
        
        // notification info
        let userInfo = notification.userInfo
        
        let keyboardSize = userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue
        
        let keyboardFrame = keyboardSize.cgRectValue.height
        
        return keyboardFrame
        
    }
    
}
