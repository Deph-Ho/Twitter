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
    @IBOutlet weak var retweetButton: UIButton!
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var replyButton: UIButton!
    @IBOutlet weak var detailScreenName: UILabel!
    
    var detailTweet: Tweet!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //Set up the variables 
        detailImage.setImageWith((detailTweet.user?.profileURL)!)
        self.detailUserLabel.text = detailTweet.user?.name
        detailTweetLabel.text = detailTweet.text
        retweetCountLabel.text = String(detailTweet.retweetCount)
        favoriteCountLabel.text = String(detailTweet.favoriteCount)
        detailScreenName.text = "@" + "\(detailTweet.user!.screenname!)"
        
        //Set up the date
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM dd hh:mm a"
        detailTimeLabel.text = formatter.string(from: detailTweet.timestamp!)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onRetweet(_ sender: UIButton) {
        if(sender.isSelected){
            //deselect button
            sender.isSelected = false
            detailTweet.retweeted = false
            retweetCountLabel.text = String(detailTweet.retweetCount)
            self.retweetButton.setImage(UIImage(named: "retweet-icon"), for: UIControlState())
            print("Retweet deselected")
        } else {
            //selected button
            sender.isSelected = true
            detailTweet.retweeted = true
            retweetCountLabel.text = String(detailTweet.retweetCount)
            self.retweetButton.setImage(UIImage(named: "retweet-icon-green"), for: UIControlState())
            print("Retweet Selected")
        }
    }
    
    @IBAction func onFavorite(_ sender: UIButton) {
        if(sender.isSelected){
            sender.isSelected = false
            detailTweet.favorited = false
            favoriteCountLabel.text = String(detailTweet.favoriteCount)
            self.favoriteButton.setImage(UIImage(named: "favor-icon.png"), for: UIControlState())
            print("Favorite Deselected")
        } else {
            sender.isSelected = true
            detailTweet.favorited = true
            favoriteCountLabel.text = String(detailTweet.favoriteCount)
            self.favoriteButton.setImage(UIImage(named: "favor-icon-red.png"), for: UIControlState())
            print("Favorite Selected")
        }
    }
    @IBAction func goBack(_ sender: Any) {
        _ = navigationController?.popViewController(animated: true)
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
