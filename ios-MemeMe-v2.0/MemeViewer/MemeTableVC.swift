//
//  MemeTableViewController.swift
//  ios-MemeMe-v2.0
//
//  Created by Abdullah Khayat on 5/24/20.
//  Copyright © 2020 Team IOS. All rights reserved.
//
import UIKit

class MemeTableVC: UITableViewController, MemeEditorDelegate {
    
    // identifiers
    let memeCellId = "MemeCell"
    let memeDetailId = "MemeDetailVC"
    
    // table row height and spacing
    let rowHeight: CGFloat = 100.0
    let spacing: CGFloat = 15.0
    
    // datasource
    var memes: [Meme]! {
        return (UIApplication.shared.delegate as! AppDelegate).memes
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // makes table separators edge-to-edge
        tableView.separatorInset = UIEdgeInsets.zero
        
        // hides/removes extra table rows
        tableView.tableFooterView = UIView()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return memes.count
    }
        
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 1
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return spacing
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        // makes the spacing to be transparant
        let view = UIView()
        view.backgroundColor = .clear
        
        return view
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        
        return 1
    }
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
        // makes the spacing to be transparant
        let view = UIView()
        view.backgroundColor = .clear
        
        return view
    }
    
    /*
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        
        return 1
        // return spacing
    }
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
        let v = UIView(frame: CGRect(x: 0, y:0, width: tableView.frame.width, height: 1))
        v.backgroundColor = .darkGray
        return v
        
        // let view = UIView()
        // view.backgroundColor = .clear
        // return view
    }
    */
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: memeCellId, for: indexPath)
        
        let meme = memes[indexPath.section]
        
        // assigns meme details to cell properties
        cell.textLabel?.numberOfLines = 2
        cell.textLabel?.text = "\(meme.topTxt)\n\(meme.bottomTxt)"
        cell.imageView?.image = meme.memedImg
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // shows memeDetailController with the selected meme
        let detailController = storyboard!.instantiateViewController(withIdentifier: memeDetailId) as! MemeDetailVC
        
        detailController.meme = memes[indexPath.section]
        
        navigationController?.pushViewController(detailController, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return rowHeight
    }
    
    // default swipes
    /*
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
         
         switch editingStyle {
         case .delete:
             (UIApplication.shared.delegate as! AppDelegate).memes.remove(at: indexPath.row)
             updateView()
         default: ()
         }
     }
     */
    
    // custom swipe to left action
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        // adds swipe left to delete action
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete", handler: { (deleteAction, view, completion) in
            
            // updates datasource & table
            (UIApplication.shared.delegate as! AppDelegate).memes.remove(at: indexPath.section)
            tableView.deleteSections([indexPath.section], with: .automatic)
            
        })
        
        let swipeActions = UISwipeActionsConfiguration(actions: [deleteAction])
        
        return swipeActions
    }
    
    // custom swipe to right action
    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        // adds swipe right to share action
        let shareAction = UIContextualAction(style: .normal, title: "Share", handler: { (shareAction, view, completion) in
                        
            let image = self.memes[indexPath.section].memedImg
            
            // shows share actvityViewController
            let controller = UIActivityViewController(activityItems: [image], applicationActivities: nil)
            
            self.present(controller, animated: true, completion: nil)
        })
        
        let swipeActions = UISwipeActionsConfiguration(actions: [shareAction])
        
        return swipeActions
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        // assigns self as delgate for MemeEditorVC in order to update the tableView when MemeEditorVC is dismissed
        let memeEditorController = (segue.destination as! UINavigationController).topViewController as! MemeEditorVC
        
        memeEditorController.delegate = self
    }
    
    func updateView() {
        tableView.reloadData()
    }
    
}
