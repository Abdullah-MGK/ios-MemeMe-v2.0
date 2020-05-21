//
//  MemesTableVC.swift
//  ios-MemeMe-v2.0
//
//  Created by Abdullah Khayat on 5/21/20.
//  Copyright © 2020 Team IOS. All rights reserved.
//

import UIKit

class MemesTableVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var memes: [Meme]! {
        return (UIApplication.shared.delegate as! AppDelegate).memes
    }
    
    @IBOutlet weak var memesTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        memesTableView.delegate = self
        memesTableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return memes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let reuseId = "simpleCell"
        
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseId)!
        
        cell.textLabel?.text = memes[indexPath.row].topTxt
        cell.detailTextLabel?.text = "details"
        cell.imageView?.image = UIImage(named: "HighPitch")
        
        return cell
    }
    
}
