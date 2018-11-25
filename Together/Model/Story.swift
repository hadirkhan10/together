//
//  Story.swift
//  Together
//
//  Created by Hadir khan on 13/02/2018.
//  Copyright © 2018 Hadir khan. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class Story {
    
    var username: String
    var storyText: String
    var storyId: Int
    
    static var url = "http://192.168.0.104:8888/together/index.php"
    static var UserStories: [Story] = []
    static var specificUserStories: [Story] = []
    
    init(for username: String, storyText: String, storyId: Int) {
        self.username = username
        self.storyText = storyText
        self.storyId = storyId
    }
    
    

    
//    static func getStories(_ userData: JSON) {
//            var stories = [[String:AnyObject]]()
//                let userStories = userData["response"].arrayObject
//                stories = userStories as! [[String:AnyObject]]
//                
//                print(stories[0]["username"] as! String)
//                print(stories[0]["story_text"] as! String)
//                
//                for story in stories {
//                    let storyId = story["sid"] as! NSString
//                    let newStory = Story(for: story["username"] as! String, storyText: story["story_text"] as! String, storyId: storyId.integerValue)
//                    UserStories.append(newStory)
//                    
//                }
//        
//            }
    
//    static func getSpecificUserStories(_ userData: JSON) {
//        var stories = [[String:AnyObject]]()
//        let userStories = userData["response"].arrayObject
//        stories = userStories as! [[String:AnyObject]]
//        
//        for story in stories {
//            let newStory = Story(for: story["username"] as! String, storyText: story["story_text"] as! String)
//            specificUserStories.append(newStory)
//            
//        }
//        
//    }
    
            
}
        

























