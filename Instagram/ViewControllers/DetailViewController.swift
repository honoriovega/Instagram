//
//  DetailViewController.swift
//  Instagram
//
//  Created by Honorio Vega on 2/25/18.
//  Copyright © 2018 Honorio Vega. All rights reserved.
//

import UIKit
import Parse

class DetailViewController: UIViewController {
    var post: PFObject!

    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var captionLabel: UILabel!
    @IBOutlet weak var timeStampLabel: UILabel!
    var postImage : UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        postImageView.image = postImage
        self.captionLabel.text = post["caption"] as? String
        self.timeStampLabel.text = post["timestamp"] as? String

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
