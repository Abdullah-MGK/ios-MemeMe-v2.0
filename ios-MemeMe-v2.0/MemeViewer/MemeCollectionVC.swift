//
//  MemeCollectionViewController.swift
//  ios-MemeMe-v2.0
//
//  Created by Abdullah Khayat on 5/24/20.
//  Copyright © 2020 Team IOS. All rights reserved.
//

import UIKit

class MemeCollectionVC: UICollectionViewController, MemeEditorDelegate {
    
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    
    var memes: [Meme]! {
        return (UIApplication.shared.delegate as! AppDelegate).memes
    }
    
    let memeItemId = "MemeItem"
    let memeDetailId = "MemeDetailVC"
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
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
        
        updateView()
        
        // Preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
    }
    
    // TODO: choose one of those for rotating device
    // didn't work
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
    // didn't work with interface orientation nor traits
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
    
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
     // didn't work with traits nor with interface orientation
    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        
        
        let interfaceOrientation = UIApplication.shared.windows.first?.windowScene?.interfaceOrientation
        
        // can be accessed via storyboard
        let space: CGFloat = 5.0
        let dimension: CGFloat!
        
        if interfaceOrientation!.isPortrait {
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
    
    // MARK: UICollectionViewDataSource
    
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
        
        let detailController = storyboard!.instantiateViewController(withIdentifier: memeDetailId) as! MemeDetailVC
        
        detailController.meme = memes[indexPath.row]
        
        navigationController?.pushViewController(detailController, animated: true)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        // assign self as delgate for MemeEditorVC in order to update the tableView when MemeEditorVC is dismissed
        let memeEditorController = (segue.destination as! UINavigationController).topViewController as! MemeEditorVC
        
        memeEditorController.delegate = self
        
    }
    
    func updateView() {
        collectionView.reloadData()
    }
    
}

