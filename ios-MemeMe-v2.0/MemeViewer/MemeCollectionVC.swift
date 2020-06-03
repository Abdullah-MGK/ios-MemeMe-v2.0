//
//  MemeCollectionViewController.swift
//  ios-MemeMe-v2.0
//
//  Created by Abdullah Khayat on 5/24/20.
//  Copyright © 2020 Team IOS. All rights reserved.
//

import UIKit

class MemeCollectionVC: UICollectionViewController, MemeEditorDelegate, UICollectionViewDelegateFlowLayout {
    
    // datasource
    var memes: [Meme]! {
        return (UIApplication.shared.delegate as! AppDelegate).memes
    }
    
    // stores identifiers
    let memeItemId = "MemeItem"
    let memeDetailId = "MemeDetailVC"
    
    // stores spacing
    let spacing: CGFloat = 5.0
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return memes.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let item = collectionView.dequeueReusableCell(withReuseIdentifier: memeItemId, for: indexPath) as! MemeCollectionViewCell
        
        let meme = memes[indexPath.row]
        item.imageView!.image = meme.memedImg
        
        return item
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        // shows memeDetailController with the selected meme
        let detailController = storyboard!.instantiateViewController(withIdentifier: memeDetailId) as! MemeDetailVC
        
        detailController.meme = memes[indexPath.row]
        
        navigationController?.pushViewController(detailController, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        
        return spacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return spacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        // gets the current orientation
        let interfaceOrientation = UIApplication.shared.windows.first?.windowScene?.interfaceOrientation
        
        // gets the safeArea size
        let viewArea = view.safeAreaLayoutGuide.layoutFrame
        let dimension: CGFloat!
        
        if interfaceOrientation!.isPortrait {
            // [(screen width) - (2 spaces in between)] / [3 image columns]
            dimension = (viewArea.size.width - (2 * spacing)) / 3.0
        } else {
            // [(screen width) - (4 spaces in between)] / [5 image columns]
            dimension = (viewArea.size.width - (4 * spacing)) / 5.0
        }
        
        return CGSize(width: dimension, height: dimension)
    }
    
    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        collectionViewLayout.invalidateLayout()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        // assigns self as delgate for MemeEditorVC in order to update the colletionView when MemeEditorVC is dismissed
        let memeEditorController = (segue.destination as! UINavigationController).topViewController as! MemeEditorVC
        
        memeEditorController.delegate = self
    }
    
    func updateView() {
        collectionView.reloadData()
    }
    
}

