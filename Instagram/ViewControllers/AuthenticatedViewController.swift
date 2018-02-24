//
//  AuthenticatedViewController.swift
//  Instagram
//
//  Created by Honorio Vega on 2/21/18.
//  Copyright © 2018 Honorio Vega. All rights reserved.
//

import UIKit
import Parse
import AlamofireImage

class AuthenticatedViewController: UIViewController,UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var posts : [PFObject] = []

    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self

        
        if PFUser.current() != nil {
            let username = PFUser.current()?.username as! String
            
        }
        
        
        // construct PFQuery
        let query = Post.query()
        query?.order(byDescending: "createdAt")
        query?.includeKey("author")
        query?.limit = 20
        
        // fetch data asynchronously
        query?.findObjectsInBackground { (posts: [PFObject]?, error: Error?) -> Void in
            if let posts = posts {
                self.posts = posts
                self.tableView.reloadData()

                // do something with the data fetched
            } else {
                // handle error
            }
        }

        
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
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath) as! PostCell
        
        cell.instagramPost = posts[indexPath.row]
        print(posts[indexPath.row])
        
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
    {
        return 500;//Choose your custom row height
    }
    

    
}
