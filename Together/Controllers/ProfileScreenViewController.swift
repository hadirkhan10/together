//
//  ProfileScreenViewController.swift
//  Together
//
//  Created by Hadir khan on 13/02/2018.
//  Copyright © 2018 Hadir khan. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ProfileScreenViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{

    var userStories: [Story] = []
    
    @IBOutlet weak var tableView: UITableView!
    
        
        
        
//        Alamofire.request(Story.url + "/user/stories").responseJSON { (response) in
//            if response.result.isSuccess {
//
//                let specificUserStories = JSON(response.result.value!)
//                Story.getSpecificUserStories(specificUserStories)
//                self.userStories = Story.specificUserStories
//                self.tableView.reloadData()
//
//            }else {
//                print("Unavailable to get data from the server")
//            }
//        }
        
        
        
 
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Alamofire.request(Story.url + "/user/stories").responseJSON { (response) in
                        if response.result.isSuccess {
            
                            let specificUserStories = JSON(response.result.value!)
                            self.userStories = self.getSpecificUserStories(specificUserStories)
                            self.tableView.reloadData()
            
                        }else {
                            print("Unavailable to get data from the server")
                        }
                    }
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "StoryTableViewCell", bundle: nil), forCellReuseIdentifier: "storyCell")
        
        updateRowHeight()
        
        NotificationCenter.default.addObserver(self,selector: #selector(ProfileScreenViewController.requestData),name: Notification.Name(rawValue: notificationKey), object: nil)
    }
    
    @objc func requestData(){
        Alamofire.request(Story.url + "/user/stories").responseJSON { (response) in
            if response.result.isSuccess {
                
                let specificUserStories = JSON(response.result.value!)
                self.userStories = self.getSpecificUserStories(specificUserStories)
                self.tableView.reloadData()
                
            }else {
                print("Unavailable to get data from the server")
            }
        }
    }
    
        func getSpecificUserStories(_ userData: JSON) -> [Story] {
            var myStoryArray: [Story] = []
            var stories = [[String:AnyObject]]()
            let userStories = userData["response"].arrayObject
            stories = userStories as! [[String:AnyObject]]
            
            for story in stories {
                let storyId = story["sid"] as! NSString
                let newStory = Story(for: story["username"] as! String, storyText: story["story_text"] as! String, storyId: storyId.integerValue)
                myStoryArray.append(newStory)
                
            }
            return myStoryArray
        
    }

    

     //MARK: - Conforming to table view protocols
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "storyCell") as! StoryTableViewCell
        
        cell.storyTextLabel.text = userStories[indexPath.row].storyText
        cell.usernameLabel.text = userStories[indexPath.row].username
        cell.userImage.image = UIImage(named: "user")
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userStories.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
            self.performSegue(withIdentifier: "goToEditStory", sender: self)
        
    }
   
    
    func updateRowHeight(){
        tableView.estimatedRowHeight = 120.0
        tableView.rowHeight = UITableViewAutomaticDimension
    }
    
    
    
 
    // MARK: - Navigation
    
    @IBAction func unwindToProfileScreen(segue: UIStoryboardSegue) {
        
        //guard segue.identifier == "saveSegue" else {return}
        if segue.identifier == "saveSegue" {
        let addStoryScreenController = segue.source as! EditStoryTableViewController
        
        if let userStory = addStoryScreenController.userStory {
            self.userStories[tableView.indexPathForSelectedRow!.row] = userStory
            tableView.reloadRows(at: [tableView.indexPathForSelectedRow!], with: .automatic)
        }
        } else if segue.identifier == "deleteSegue" {
            userStories.remove(at: tableView.indexPathForSelectedRow!.row)
            tableView.reloadData()
        }
}

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "unwindToWelcomeScreen" {
            
            Alamofire.request(Story.url + "/user/logout").responseJSON(completionHandler: { (response) in
                if response.result.isSuccess {
                    print("User logged out")
                } else {
                    print("Unable to communicate with the server")
                }
            })
            
        }
        
        else if segue.identifier == "goToEditStory" {
            let editStoryTableViewController = segue.destination as! EditStoryTableViewController
            
            let indexPathForSelectedRow = tableView.indexPathForSelectedRow!
            
            
            
            editStoryTableViewController.userStory = userStories[indexPathForSelectedRow.row]
        }
        
    }
 

}






















