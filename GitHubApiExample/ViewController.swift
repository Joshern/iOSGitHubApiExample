//
//  ViewController.swift
//  GitHubApi
//
//  Created by Josh on 9/23/16.
//  Copyright © 2016 Josh. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource {

    var repositories = [Repository]()
    var user: User?
    var userInput: String?
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblLocation: UILabel!
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var imgAvatar: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setInitUI()
    }
    
    func setInitUI(){
        self.lblEmail.text = ""
        self.lblLocation.text = "No User Data!"
        self.lblName.text = ""
        self.imgAvatar.image = nil
        self.repositories.removeAll()
        self.tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar){
        self.userInput = searchBar.text
        self.setInitUI()
        NetworkingManager.sharedInstance.downloadUserData(self.userInput!, completion: {(user) in
            self.user = user
            self.user!.downloadImage({(img) in
                NSOperationQueue.mainQueue().addOperationWithBlock({
                    self.user!.avatarImage = img
                    self.setUserData()
                })
            })
        })
        
        NetworkingManager.sharedInstance.downloadRepositories(self.userInput!, completion:{(repos) in
            if repos != nil {
                self.repositories.append(repos!)
                NSOperationQueue.mainQueue().addOperationWithBlock({
                    self.tableView.reloadData()
                })
            } else{
                NSOperationQueue.mainQueue().addOperationWithBlock({
                    self.setInitUI()
                    self.tableView.reloadData()
                })
            }
        })
    }
    
    func setUserData(){
        self.lblName.text = self.user?.name
        self.lblLocation.text = self.user?.location
        self.lblEmail.text = self.user?.email
        self.imgAvatar.image = self.user?.avatarImage
        
        let radius = self.imgAvatar.frame.width / 2
        self.imgAvatar.layer.cornerRadius = radius
        self.imgAvatar.layer.masksToBounds = true
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repositories.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! RepoTableViewCell
        
        let currentItem = repositories[indexPath.row]
        
        cell.lblName.text = currentItem.name
        cell.lblLanguage.text = currentItem.language
        cell.lblDescription.text = currentItem.repoDescription
        cell.lblCreatedAt.text = currentItem.createdAt
        cell.lblOwner.text = currentItem.owner
        
        return cell
    }

}

