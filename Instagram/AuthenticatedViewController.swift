//
//  AuthenticatedViewController.swift
//  Instagram
//
//  Created by Honorio Vega on 2/21/18.
//  Copyright © 2018 Honorio Vega. All rights reserved.
//

import UIKit
import Parse

class AuthenticatedViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    

    @IBOutlet weak var greetingMessageView: UILabel!
    override func viewDidLoad() {
        
        
        if PFUser.current() != nil {
            let username = PFUser.current()?.username as! String
            greetingMessageView.text = username
        }
        super.viewDidLoad()
        


        
    }
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [String : Any]) {
        // Get the image captured by the UIImagePickerController
        let originalImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        let editedImage = info[UIImagePickerControllerEditedImage] as! UIImage
        
        // Do something with the images (based on your use case)
        
        // Dismiss UIImagePickerController to go back to your original view controller
        dismiss(animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func onLogout(_ sender: Any) {
         NotificationCenter.default.post(name: NSNotification.Name("didLogout"), object: nil)
    }
    @IBAction func onCompose(_ sender: UIBarButtonItem) {
        self.performSegue(withIdentifier: "composeSegue", sender: nil)

    }
    
//    @IBAction func onAddImage(_ sender: UIBarButtonItem) {
//        
//        // Instantiate a UIImagePickerController
//        let vc = UIImagePickerController()
//        vc.delegate = self as! UIImagePickerControllerDelegate & UINavigationControllerDelegate
//        vc.allowsEditing = true
//        
//        if UIImagePickerController.isSourceTypeAvailable(.camera) {
//            print("Camera is available 📸")
//            vc.sourceType = .camera
//        } else {
//            print("Camera 🚫 available so we will use photo library instead")
//            vc.sourceType = .photoLibrary
//        }
//        self.present(vc, animated: true, completion: nil)
//    }
    
}
