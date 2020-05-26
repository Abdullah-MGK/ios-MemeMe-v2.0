//
//  MemeTableViewController.swift
//  ios-MemeMe-v2.0
//
//  Created by Abdullah Khayat on 5/24/20.
//  Copyright © 2020 Team IOS. All rights reserved.
//

import UIKit

class MemeTableVC: UITableViewController {
    
    private let reuseIdentifier = "MemeCell"
    
    var memes: [Meme]! {
        print("meme")
        return (UIApplication.shared.delegate as! AppDelegate).memes
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("willAppear")
        tableView.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("didAppear")
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("didLoad")
        tableView.reloadData()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("count")
        return memes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("cell")

        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)
        
        cell.textLabel?.text = memes[indexPath.row].topTxt
        cell.detailTextLabel?.text = "details"
        cell.imageView?.image = UIImage(named: "HighPitch")
        
        return cell
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
