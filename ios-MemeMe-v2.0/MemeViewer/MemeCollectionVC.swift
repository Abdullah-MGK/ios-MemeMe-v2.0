//
//  MemeCollectionViewController.swift
//  ios-MemeMe-v2.0
//
//  Created by Abdullah Khayat on 5/24/20.
//  Copyright © 2020 Team IOS. All rights reserved.
//

import UIKit

class MemeCollectionVC: UICollectionViewController, MemeEditorDelegate, UICollectionViewDelegateFlowLayout {
    
    //@IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    
    // datasource
    var memes: [Meme]! {
        return (UIApplication.shared.delegate as! AppDelegate).memes
    }
    
    // identifiers
    let memeItemId = "MemeItem"
    let memeDetailId = "MemeDetailVC"
    
    // spacing
    let spacing: CGFloat = 5.0
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateView()
        
        // Done in Delegate
        /*
        let interfaceOrientation = UIApplication.shared.windows.first?.windowScene?.interfaceOrientation
        
        // can be accessed via storyboard
        let space: CGFloat = 5.0
        let dimension: CGFloat!
        
        // when the view has loaded
        if interfaceOrientation!.isPortrait {
            // [(screen width) - (2 spaces in between)] / [3 image columns]
            dimension = (view.frame.size.width - (2 * space)) / 3.0
            print("interface is portrait in willappear")
        } else {
            dimension = (view.frame.size.width - (5 * space)) / 1.0
            print("interface is landscape in willappear")
        }
        
        // governs the space between items within a row or column (margin)
        flowLayout.minimumInteritemSpacing = space
        
        // governs the space between rows or columns (padding)
        flowLayout.minimumLineSpacing = space
        
        // governs cell size
        flowLayout.itemSize = CGSize(width: dimension, height: dimension)
        */
        
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
    
    /*
       override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
           
           let interfaceOrientation = UIApplication.shared.windows.first?.windowScene?.interfaceOrientation
           
           // can be accessed via storyboard
           let space: CGFloat = 5.0
           let dimension: CGFloat!
           
           if !(interfaceOrientation!.isPortrait) {
               // [(screen width) - (2 spaces in between)] / [3 image columns]
               dimension = (view.frame.size.width - (2 * space)) / 3.0
           } else {
               dimension = (view.frame.size.width - (5 * space)) / 1.0
           }
           
           // governs the space between items within a row or column (margin)
           flowLayout.minimumInteritemSpacing = space
           
           // governs the space between rows or columns (padding)
           flowLayout.minimumLineSpacing = space
           
           // governs cell size
           flowLayout.itemSize = CGSize(width: dimension, height: dimension)
           
           collectionView?.collectionViewLayout.invalidateLayout()
           collectionView?.reloadData()
           
       }
    */
       
       /*
       override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
           
           let interfaceOrientation = UIApplication.shared.windows.first?.windowScene?.interfaceOrientation
           
           // can be accessed via storyboard
           let space: CGFloat = 5.0
           let dimension: CGFloat!
           
           if !(interfaceOrientation!.isPortrait) {
               // [(screen width) - (2 spaces in between)] / [3 image columns]
               dimension = (view.frame.size.width - (2 * space)) / 3.0
           } else {
               dimension = (view.frame.size.width - (5 * space)) / 1.0
           }
           
           // governs the space between items within a row or column (margin)
           flowLayout.minimumInteritemSpacing = space
           
           // governs the space between rows or columns (padding)
           flowLayout.minimumLineSpacing = space
           
           // governs cell size
           flowLayout.itemSize = CGSize(width: dimension, height: dimension)
           
           collectionView?.collectionViewLayout.invalidateLayout()
           collectionView?.reloadData()
           
       }
    */
       
       /*
        override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        
        let landscape =
        (traitCollection.horizontalSizeClass == .regular || traitCollection.horizontalSizeClass == .compact) && traitCollection.verticalSizeClass == .compact
        
        // can be accessed via storyboard
        let space: CGFloat = 5.0
        let dimension: CGFloat!
        
        if !landscape {
        print("interface is portrait in trait")
        // [(screen width) - (2 spaces in between)] / [3 image columns]
        dimension = (view.frame.size.width - (2 * space)) / 3.0
        } else {
        print("interface is landscape in trait")
        dimension = (view.frame.size.width - (5 * space)) / 2.0
        }
        
        // governs the space between items within a row or column (margin)
        flowLayout.minimumInteritemSpacing = space
        
        // governs the space between rows or columns (padding)
        flowLayout.minimumLineSpacing = space
        
        // governs cell size
        flowLayout.itemSize = CGSize(width: dimension, height: dimension)
        
        collectionView?.collectionViewLayout.invalidateLayout()
        collectionView?.reloadData()
        
        }
        */
    
    /*
     override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        if traitCollection.horizontalSizeClass == .regular && traitCollection.verticalSizeClass == .regular {
            mainLabel.font = UIFont(name: "Futura-Bold", size: 75)
        } else {
            mainLabel.font = UIFont(name: "Futura-Bold", size: 35)
        }
    }
 */
    
    /*
       override func viewWillLayoutSubviews() {
       /*
        In viewWillLayoutSubviews, we are guaranteed that our view's size, traits, etc. are up to date.
        It's a good place to update anything that affects the layout of our subviews.
        However, be careful, because this method is called frequently!
        Do as little work as possible, and don't invalidate the layout of any superviews.
        */
    */
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        // assigns self as delgate for MemeEditorVC in order to update the colletionView when MemeEditorVC is dismissed
        let memeEditorController = (segue.destination as! UINavigationController).topViewController as! MemeEditorVC
        
        memeEditorController.delegate = self
    }
    
    func updateView() {
        collectionView.reloadData()
    }
    
}

