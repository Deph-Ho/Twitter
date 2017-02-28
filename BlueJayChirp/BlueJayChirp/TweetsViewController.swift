//
//  TweetsViewController.swift
//  BlueJayChirp
//
//  Created by Dephanie Ho on 2/26/17.
//  Copyright © 2017 Dephanie Ho. All rights reserved.
//

import UIKit

class TweetsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    
    @IBOutlet weak var tableView: UITableView!
    
    var tweets = [Tweet]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 150
        
        //pull to refresh
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshControlAction(_refreshControl:)), for: UIControlEvents.valueChanged)
        tableView.insertSubview(refreshControl, at: 0)
        
        TwitterClient.sharedInstance?.homeTimeline(success: { (tweets: [Tweet]) -> () in
            self.tweets = tweets
            self.tableView.reloadData()
            
        }, failure: { (error: Error) in
            print(error.localizedDescription)
        })
        
        navigationController?.navigationBar.barTintColor = UIColor(colorLiteralRed: 0.1, green: 0.5, blue:1.0, alpha: 1.0)
        navigationController?.navigationBar.tintColor = UIColor.init(white:0.5, alpha:1.0)
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onLogoutButton(_ sender: Any) {
        TwitterClient.sharedInstance?.logout()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tweets.count 
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TweetCell", for: indexPath) as! TweetCell
        
        let tweet = tweets[indexPath.row]
        cell.tweet = tweet
        
        return cell
    }
    
    func refreshControlAction(_refreshControl: UIRefreshControl){
        
        TwitterClient.sharedInstance?.homeTimeline(success: { (tweets: [Tweet]) -> () in
            self.tweets = tweets
            self.tableView.reloadData()
            
        }, failure: { (error: Error) in
            print(error.localizedDescription)
        })

        tableView.reloadData()
        _refreshControl.endRefreshing()
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
