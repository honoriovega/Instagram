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
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshControlAction(_:)), for: UIControlEvents.valueChanged)

        tableView.insertSubview(refreshControl, at: 0)

        if PFUser.current() != nil {
            let username = PFUser.current()?.username as! String
            
        }
        
        
        getPosts()

        
    }
    
    func getPosts() {
        // construct PFQuery
        let query = Post.query()
        query?.order(byDescending: "createdAt")
        query?.includeKey("author")
        query?.includeKey("timestamp")

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
        
        print(posts[indexPath.row])
        cell.instagramPost = posts[indexPath.row]
        
        print(cell)
        
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
    {
        return 500;//Choose your custom row height
    }
    // Makes a network request to get updated data
    // Updates the tableView with the new data
    // Hides the RefreshControl
    @objc func refreshControlAction(_ refreshControl: UIRefreshControl) {
        
        // ... Create the URLRequest `myRequest` ...
        
  
            
            // ... Use the new data to update the data source ...
            getPosts()


            // Tell the refreshControl to stop spinning
            refreshControl.endRefreshing()
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // noice
        
        if(sender != nil) {
        
            let cell = sender as! UITableViewCell
            if let indexPath = tableView.indexPath(for: cell) {
                let post = posts[indexPath.row]
                let detailViewController = segue.destination as! DetailViewController
                detailViewController.post = post
                
                let postCell = sender as! PostCell
                detailViewController.postImage = postCell.postImageView.image
            }
        }
        
    }
    
    
  
    
    
    

}


