//
//  ViewController.swift
//  Together
//
//  Created by Hadir khan on 12/02/2018.
//  Copyright © 2018 Hadir khan. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class WelcomeScreenViewController: UIViewController {

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Alamofire.request(Story.url + "/user").responseJSON { (response) in
            if response.result.isSuccess {
                let serverResponse = JSON(response.result.value!)
                let user = serverResponse["user"]
                guard user == true else {return}
                self.performSegue(withIdentifier: "goToStoryBoardFromWelcomeScreen", sender: self)
            }
        }

    }

    

    @IBAction func unwindToWelcomeScreen(segue: UIStoryboardSegue) {
        
    }

}

