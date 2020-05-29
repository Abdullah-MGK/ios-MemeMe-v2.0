//
//  ViewController.swift
//  ios-MemeMe-v1.0
//
//  Created by Abdullah Khayat on 5/14/20.
//  Copyright © 2020 Team IOS. All rights reserved.
//

import UIKit

protocol MemeEditorDelegate {
    func updateView()
}

class MemeEditorVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {
    
    @IBOutlet weak var memeImgView: UIImageView!
    @IBOutlet weak var topTF: UITextField!
    @IBOutlet weak var bottomTF: UITextField!
    @IBOutlet weak var pickFromCamBTN: UIBarButtonItem!
    @IBOutlet weak var pickFromAlbumBTN: UIBarButtonItem!
    @IBOutlet weak var shareBTN: UIBarButtonItem!
    
    enum ButtonType: Int {
        case camera = 0, album
    }
    
    var meme: Meme?
    var delegate: MemeEditorDelegate?
    
    // set defaultTextAttributes
    let memeTextAttributes: [NSAttributedString.Key: Any] = [
        .strokeColor: UIColor.black,
        .foregroundColor: UIColor.white,
        .font: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
        // negative so that it makes stroke and fill
        .strokeWidth: -3
    ]
        
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // TODO: Fix That Here & at Will Appear
        
        // set text fields
        setTextFieldStyle(textField: topTF, placeHolder: "TOP")
        setTextFieldStyle(textField: bottomTF, placeHolder: "BOTTOM")
        
        // set meme details
        // resetMeme()
        
        
        
        
        if let meme = meme {
            memeImgView.image = meme.originalImg
            topTF.text = meme.topTxt
            bottomTF.text = meme.bottomTxt
        }
        
        // set meme details
        // resetMeme()
        
        // if in viewWillAppear() or viewDidAppear(), every time the screen appears, the button is disabled, but if in viewDidLoad() it will  be disabled at the first time
        pickFromCamBTN.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
        
        shareBTN.isEnabled = memeImgView.image != nil
        subscribeToKeyboardNotification()
        
        // hide Tabbar when using same navigation controller with push
        // tabBarController?.tabBar.isHidden = true
        // navigationController?.toolbar.isHidden = false
        // and in previous controller add this
        // hidesBottomBarWhenPushed
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // TODO: update tableview when dismissing this viewcontroller
        // delegate?.updateView()
        
        // unsubscribe from keyboard notification
        unsubscribeFromKeyboardNotification()
    }
    
    func setTextFieldStyle(textField: UITextField, placeHolder: String) {
        textField.defaultTextAttributes = memeTextAttributes
        textField.attributedPlaceholder = NSAttributedString(string: placeHolder, attributes: memeTextAttributes)
        // intitially created with empty text
        textField.text = ""
        
        textField.autocapitalizationType = .allCharacters
        textField.textAlignment = .center
        textField.borderStyle = .none
        textField.minimumFontSize = 28
        textField.delegate = self
    }
    
    @IBAction func pickImgTapped(_ sender: UIBarButtonItem) {
        
        // present image picker based on the button clicked
        switch(ButtonType(rawValue: sender.tag)!) {
        case .camera : setImgPicker(.camera)
        case .album : setImgPicker(.photoLibrary)
        }
        
    }
    
    @IBAction func cancelTapped(_ sender: Any) {
        
        // define alert
        let controller = UIAlertController(title: "Reset", message: "Are you sure you want to discard your changes", preferredStyle: .actionSheet)
        
        // define discard action
        let discardAction = UIAlertAction(title: "Discard Changes", style: .destructive) { action in
            self.resetMeme()
            // self.dismiss(animated: true, completion: nil)
        }
        
         // define cancel action
         let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default) { action in
         }
        
        // add actions to the alert
        controller.addAction(discardAction)
        controller.addAction(cancelAction)
        
        // present alert
        present(controller, animated: true, completion: nil)
        
    }
    
    // TODO: fix reset
    func reset() {
        memeImgView.image = nil
        setTextFieldStyle(textField: topTF, placeHolder: "TOP")
        setTextFieldStyle(textField: bottomTF, placeHolder: "BOTTOM")
        shareBTN.isEnabled = false
    }
    
    func resetMeme() {
        if let meme = meme {
            memeImgView.image = meme.originalImg
            topTF.text = meme.topTxt
            bottomTF.text = meme.bottomTxt
        }
        else {
            memeImgView.image = nil
            topTF.text = ""
            bottomTF.text = ""
            shareBTN.isEnabled = false
        }
    }
    
    func resetMemes() {
        memeImgView.image = meme?.originalImg ?? nil
        topTF.text = meme?.topTxt ?? ""
        bottomTF.text = meme?.bottomTxt ?? ""
        shareBTN.isEnabled = memeImgView.image != nil
    }
    
    // reset the field when it's clicked
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.text = ""
    }
    
    // the user tapped return on keyboard
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return textField.resignFirstResponder() // returns true
    }
    
}
