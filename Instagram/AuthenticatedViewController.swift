//
//  AuthenticatedViewController.swift
//  Instagram
//
//  Created by Honorio Vega on 2/21/18.
//  Copyright © 2018 Honorio Vega. All rights reserved.
//

import UIKit
import Parse

class AuthenticatedViewController: UIViewController {

    @IBOutlet weak var greetingMessageView: UILabel!
    override func viewDidLoad() {
        
        if PFUser.current() != nil {
            let username = PFUser.current()?.username as! String
            greetingMessageView.text = username
        }
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func onLogout(_ sender: Any) {
         NotificationCenter.default.post(name: NSNotification.Name("didLogout"), object: nil)
    }
    

}
