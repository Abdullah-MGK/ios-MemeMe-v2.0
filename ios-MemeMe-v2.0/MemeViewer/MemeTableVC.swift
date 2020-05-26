//
//  MemeTableViewController.swift
//  ios-MemeMe-v2.0
//
//  Created by Abdullah Khayat on 5/24/20.
//  Copyright © 2020 Team IOS. All rights reserved.
//

import UIKit

class MemeTableVC: UITableViewController, MemeEditorDelegate {
    
    let memeCellId = "MemeCell"
    let memeEditorId = "MemeEditorVC"
    let memeDetailId = "MemeDetailVC"
    
    var memes: [Meme]! {
        print("meme")
        return (UIApplication.shared.delegate as! AppDelegate).memes
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateTable()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
        
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return memes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: memeCellId, for: indexPath)
        
        let meme = memes[indexPath.row]
        cell.textLabel?.text = "\(meme.topTxt), \(meme.bottomTxt)"
        // cell.detailTextLabel?.text = meme.bottomTxt
        cell.imageView?.image = meme.memedImg
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let detailController = storyboard!.instantiateViewController(withIdentifier: memeDetailId) as! MemeDetailVC
        
        detailController.meme = memes[indexPath.row]
        
        navigationController?.pushViewController(detailController, animated: true)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        // assign self as delgate for MemeEditorVC in order to update the tableView when MemeEditorVC is dismissed
        let memeEditorController = (segue.destination as! UINavigationController).topViewController as! MemeEditorVC
        
        memeEditorController.delegate = self
        
    }
    
    func updateTable() {
        tableView.reloadData()
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
