//
//  LoginViewController.swift
//  Instagram
//
//  Created by Honorio Vega on 2/19/18.
//  Copyright © 2018 Honorio Vega. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    
    @IBOutlet weak var usernameField: UITextField!
    
    @IBOutlet weak var passwordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.usernameField.delegate = self
        self.passwordField.delegate = self

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onSignIn(_ sender: Any) {
        PFUser.logInWithUsername(inBackground: usernameField.text!, password: passwordField.text!) { (user : PFUser?, error: Error?) in
            
            if user != nil {
                print("you're logged in ")
                self.performSegue(withIdentifier: "loginSegue", sender: nil)
            }
        }
    }
    @IBAction func onSignUp(_ sender: Any) {
        
        let newUser = PFUser()
        newUser.username = usernameField.text
        newUser.password = passwordField.text
    
        newUser.signUpInBackground { (success :Bool,error :  Error?) in
            
            if success {
                print("Yay created a new user")
                self.performSegue(withIdentifier: "loginSegue", sender: nil)

            } else {
                print(error?.localizedDescription)
                if(error?._code == 202) {
                    print("username is taken")
                }
            }
        }

    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        usernameField.resignFirstResponder()
        passwordField.resignFirstResponder()
        return(true)
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
