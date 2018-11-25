//
//  LoginScreenViewController.swift
//  Together
//
//  Created by Hadir khan on 13/02/2018.
//  Copyright © 2018 Hadir khan. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON


class LoginScreenViewController: UIViewController {

    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var errorTextField: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }

    
    
     /////////////////////////////////////////////////////
    
     //MARK: - Dismiss to Welcome Screen when Back Pressed

    @IBAction func backButtonPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func loginButtonPressed(_ sender: UIButton) {
        guard let username = userNameTextField.text else {return}
        guard let password = passwordTextField.text else {return}
        let parameters = ["username":username,"password":password]
        Alamofire.request(Story.url + "/user/login",method: .post, parameters: parameters).responseJSON { (response) in
            if response.result.isSuccess {
                
                let serverResponse = JSON(response.result.value!)
                let status = serverResponse["status"].stringValue
                guard status == "success" else {
                    return self.errorTextField.text = "You are not registered! Kindly register first."
                }
                
                self.performSegue(withIdentifier: "goToStoryBoardFromLogin", sender: self)
                
                
            }else {
               self.errorTextField.text = "Oops! Sorry, cannot connect to the server."
            }
        }
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
