//
//  ComposeViewController.swift
//  Instagram
//
//  Created by Honorio Vega on 2/21/18.
//  Copyright © 2018 Honorio Vega. All rights reserved.
//

import UIKit
import AlamofireImage

class ComposeViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    @IBOutlet weak var postImageView: UIImageView!
    
    @IBOutlet weak var postCaption: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
     

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onCancel(_ sender: UIBarButtonItem) {
        
        // Dismiss controller to go back to your original view controller
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [String : Any]) {
        // Get the image captured by the UIImagePickerController
        let originalImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        let editedImage = info[UIImagePickerControllerEditedImage] as! UIImage
        
        let resizedImage = resize(image: originalImage,newSize: CGSize(width: 400, height: 400))
        
        postImageView.image = resizedImage
        // Do something with the images (based on your use case)
        // Dismiss UIImagePickerController to go back to your original view controller
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onShare(_ sender: UIBarButtonItem) {
        Post.postUserImage(image: postImageView.image, withCaption: postCaption.text) { (succes : Bool, error : Error?) in
            
        }
        dismiss(animated: true, completion: nil)

    }
    @IBAction func onAddPicture(_ sender: UITapGestureRecognizer) {
        
        let vc = UIImagePickerController()
        vc.delegate = self
        vc.allowsEditing = true
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            print("Camera is available 📸")
            vc.sourceType = .camera
        } else {
            print("Camera 🚫 available so we will use photo library instead")
            vc.sourceType = .photoLibrary
        }
        self.present(vc, animated: true, completion: nil)
    }
    
    func resize(image: UIImage, newSize: CGSize) -> UIImage {
        let rect = CGRect(origin: CGPoint(x: 0,y :0), size: CGSize(width: newSize.width, height: newSize.height))
        
        let resizeImageView = UIImageView(frame: rect)
        
        resizeImageView.contentMode = UIViewContentMode.scaleAspectFill
        resizeImageView.image = image
        
        UIGraphicsBeginImageContext(resizeImageView.frame.size)
        resizeImageView.layer.render(in: UIGraphicsGetCurrentContext()!)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
    }
}
