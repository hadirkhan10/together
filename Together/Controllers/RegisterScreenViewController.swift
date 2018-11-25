//
//  RegisterScreenViewController.swift
//  Together
//
//  Created by Hadir khan on 13/02/2018.
//  Copyright © 2018 Hadir khan. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class RegisterScreenViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var errorTextField: UILabel!
    
    @IBOutlet weak var registerButton: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        usernameTextField.delegate = self
        passwordTextField.delegate = self
        // Do any additional setup after loading the view.
    
    }

    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
    
    
    ////////////////////////////////////////////////////
    
     //MARK: - Dismiss to Welcome Screen when Back Pressed
    
    @IBAction func backButtonPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
     //MARK: - Register User to the Firebase
    
    @IBAction func registerButtonTapped(_ sender: UIButton) {
        guard let username = usernameTextField.text else {return}
        guard let password = passwordTextField.text else {return}
        guard let emailAddress = emailTextField.text else {return}
        
        let parameters = ["username":username,"email": emailAddress, "password": password]
        Alamofire.request(Story.url + "/user/create",method: .post, parameters: parameters).responseJSON { (response) in
            if response.result.isSuccess {
                let serverResponse = JSON(response.result.value!)
                let status = serverResponse["status"].stringValue
                guard status == "success" else {
                    let error = serverResponse["message"].stringValue
                    return self.errorTextField.text = error
                }
                self.performSegue(withIdentifier: "goToStoryBoard", sender: self)
            } else {
                self.errorTextField.text = "Unable to connect to server"
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
