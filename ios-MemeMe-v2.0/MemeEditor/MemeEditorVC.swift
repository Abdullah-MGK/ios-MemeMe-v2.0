//
//  ViewController.swift
//  ios-MemeMe-v2.0
//
//  Created by Abdullah Khayat on 5/14/20.
//  Copyright © 2020 Team IOS. All rights reserved.
//

import UIKit

protocol MemeEditorDelegate {
    func updateView()
}

class MemeEditorVC: UIViewController, UITextFieldDelegate {
    
    // IBoutlets
    @IBOutlet weak var memeImgView: UIImageView!
    @IBOutlet weak var topTF: UITextField!
    @IBOutlet weak var bottomTF: UITextField!
    @IBOutlet weak var pickFromCamBTN: UIBarButtonItem!
    @IBOutlet weak var pickFromAlbumBTN: UIBarButtonItem!
    @IBOutlet weak var shareBTN: UIBarButtonItem!
    
    // buttons type based in tag
    enum ButtonType: Int {
        case camera = 0, album
    }
    
    // current meme
    var meme: Meme?
    
    // delegates
    var delegate: MemeEditorDelegate?
    
    // defaultTextAttributes
    let memeTextAttributes: [NSAttributedString.Key: Any] = [
        .strokeColor: UIColor.black,
        .foregroundColor: UIColor.white,
        .font: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
        // negative so that it makes stroke and fill
        .strokeWidth: -3
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // viewWillAppear() or viewDidAppear(), in viewWillAppear() every time the screen appears, the button is disabled, but in viewDidLoad() it will be disabled at the first time
        
        pickFromCamBTN.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
        
        // sets text fields style
        setTextFieldStyle(textField: topTF, placeHolder: "TOP")
        setTextFieldStyle(textField: bottomTF, placeHolder: "BOTTOM")
        
        // sets meme default details for text & image & share button
        resetMeme()
        
        subscribeToKeyboardNotification()
        
        // hide Tabbar when using same navigation controller with push
        // tabBarController?.tabBar.isHidden = true
        // navigationController?.toolbar.isHidden = false
        // and in previous controller add this
        // hidesBottomBarWhenPushed
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        unsubscribeFromKeyboardNotification()
    }
    
    func setTextFieldStyle(textField: UITextField, placeHolder: String) {
        textField.defaultTextAttributes = memeTextAttributes
        textField.attributedPlaceholder = NSAttributedString(string: placeHolder, attributes: memeTextAttributes)
        textField.autocapitalizationType = .allCharacters
        textField.textAlignment = .center
        textField.borderStyle = .none
        textField.minimumFontSize = 28
        textField.delegate = self
    }
    
    @IBAction func discardTapped(_ sender: Any) {
        
        // shows an alert when discard is tapped
        // defines alert
        let controller = UIAlertController(title: "Discard", message: "Are you sure you want to discard your changes", preferredStyle: .actionSheet)
        
        // defines discard action
        let discardAction = UIAlertAction(title: "Discard Changes", style: .destructive) { action in
            self.resetMeme()
        }
        
        // defines leave action
        let leaveAction = UIAlertAction(title: "Discard & Leave", style: .default) { action in
            self.dismiss(animated: true, completion: nil)
        }
        
        // defines cancel action
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { action in
        }
        
        // adds actions to the alert
        controller.addAction(discardAction)
        controller.addAction(cancelAction)
        controller.addAction(leaveAction)
        
        // presents alert
        present(controller, animated: true, completion: nil)
    }
    
    func resetMeme() {
        memeImgView.image = meme?.originalImg ?? nil
        topTF.text = meme?.topTxt ?? ""
        bottomTF.text = meme?.bottomTxt ?? ""
        shareBTN.isEnabled = false
    }
    
    /*
       func resetMeme() {
           
           if let meme = meme {
               memeImgView.image = meme.originalImg
               topTF.text = meme.topTxt
               bottomTF.text = meme.bottomTxt
               //shareBTN.isEnabled = meme.originalImg != memeImgView.image && meme.topTxt != topTF.text && meme.bottomTxt != bottomTF.text
           }
           else {
               memeImgView.image = nil
               topTF.text = ""
               bottomTF.text = ""
               //shareBTN.isEnabled = memeImgView.image != nil && topTF.text != nil && bottomTF.text != nil
           }
           shareBTN.isEnabled = false
       }
    */
    
    // reset the field when it's clicked
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.text = ""
    }
    
    // the user tapped return on keyboard
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return textField.resignFirstResponder() // returns true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        shareBTN.isEnabled = memeImgView.image != nil
    }

}
