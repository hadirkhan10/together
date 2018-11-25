//
//  StoryBoardScreenViewController.swift
//  Together
//
//  Created by Hadir khan on 13/02/2018.
//  Copyright © 2018 Hadir khan. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON



class StoryBoardScreenViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    @IBOutlet weak var tableView: UITableView!
    var userStories: [Story] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "StoryTableViewCell", bundle: nil), forCellReuseIdentifier: "storyCell")
        
        //TODO: Bring data from server
        let url = Story.url
        Alamofire.request( url + "/stories").responseJSON { (response) in
            if response.result.isSuccess {
                print("Success! We got the data")
                let userData = JSON(response.result.value!)
                self.userStories = self.getStories(userData)
                
                       self.updateTableRowHeight()
                self.tableView.reloadData()
                
            }
        }
        
         //MARK: - Listen for notification when user edited the story from edit screen
        
        NotificationCenter.default.addObserver(self,selector: #selector(StoryBoardScreenViewController.requestData),name: Notification.Name(rawValue: userEditedStoryNotification), object: nil)
        
         //MARK: - Listen for notification when user deleted the story from the story screen
        
        NotificationCenter.default.addObserver(self,selector: #selector(StoryBoardScreenViewController.refreshDataDueToDeletedStory),name: Notification.Name(rawValue: userDeletedStoryNotification), object: nil)
 
    }
    
    @objc func requestData(){
        let url = Story.url
        Alamofire.request( url + "/stories").responseJSON { (response) in
            if response.result.isSuccess {
                print("Success! We got the data")
                let userData = JSON(response.result.value!)
                
                self.userStories = self.getStories(userData)
                self.updateTableRowHeight()
                self.tableView.reloadData()
                
            }
        }
    }
    
    @objc func refreshDataDueToDeletedStory() {
        let url = Story.url
        Alamofire.request( url + "/stories").responseJSON { (response) in
            if response.result.isSuccess {
                print("Success! We got the data")
                let userData = JSON(response.result.value!)
                
                self.userStories = self.getStories(userData)
                self.updateTableRowHeight()
                self.tableView.reloadData()
                
            }
        }
    }
    
     func getStories(_ userData: JSON) -> [Story] {
        var myStoryArray: [Story] = []
        var stories = [[String:AnyObject]]()
        if let userStories = userData["response"].arrayObject {
            stories = userStories as! [[String:AnyObject]]
            
            
            
            for story in stories {
                let storyId = story["sid"] as! NSString
                let newStory = Story(for: story["username"] as! String, storyText: story["story_text"] as! String, storyId: storyId.integerValue)
                myStoryArray.append(newStory)
                
            }
            return myStoryArray
        }
        
        return myStoryArray
    }

     //MARK: - Table View delegate methods
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "storyCell", for: indexPath) as! StoryTableViewCell
        
        cell.storyTextLabel.text = userStories[indexPath.row].storyText
        cell.usernameLabel.text = userStories[indexPath.row].username
        cell.userImage.image = UIImage(named:"user")
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userStories.count
    }
    
    //TODO: Remove the Grey color animation that happens by default when the user presses the cell.
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
   
    
    //TODO: Update the cell height to match the data in the cell.
    
    func updateTableRowHeight(){
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 308.0
    }
    
    @IBAction func unwindToStoryBoardScreen(segue: UIStoryboardSegue){
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
