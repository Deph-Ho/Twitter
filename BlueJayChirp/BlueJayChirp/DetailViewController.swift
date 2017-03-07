//
//  DetailViewController.swift
//  BlueJayChirp
//
//  Created by Dephanie Ho on 2/28/17.
//  Copyright © 2017 Dephanie Ho. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet weak var detailImage: UIImageView!
    @IBOutlet weak var detailUserLabel: UILabel!
    @IBOutlet weak var detailTweetLabel: UILabel!
    @IBOutlet weak var detailTimeLabel: UILabel!
    @IBOutlet weak var retweetCountLabel: UILabel!
    @IBOutlet weak var favoriteCountLabel: UILabel!
    
    var detailTweet: Tweet!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //Set up the variables 
        //detailImage.setImageWith((tweet.user?.profileURL)!)
        //self.detailUserLabel.text = detailTweet.user?.name
        //detailTweetLabel.text = tweet.text
        //retweetCountLabel.text = String(tweet.retweetCount)
        //favoriteCountLabel.text = String(tweet.favoriteCount)
        
        //Set up the date
        //let formatter = DateFormatter()
        //formatter.dateFormat = "MMM dd hh:mm a"
        //detailTimeLabel.text = formatter.string(from: tweet.timestamp!)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onRetweet(_ sender: Any) {
    }

    @IBAction func onReply(_ sender: Any) {
    }
    
    @IBAction func onFavorite(_ sender: Any) {
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
