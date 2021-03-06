//
//  TweetCell.swift
//  BlueJayChirp
//
//  Created by Dephanie Ho on 2/27/17.
//  Copyright © 2017 Dephanie Ho. All rights reserved.
//

import UIKit

protocol TweetCellDelegate : class {
    func profileImageViewTapped(cell: TweetCell, user: User)
}

class TweetCell: UITableViewCell {
    //weak var to retain cycle
    weak var delegate: TweetCellDelegate?

    @IBOutlet weak var profileImage: UIImageView! {
        didSet{
            self.profileImage.isUserInteractionEnabled = true
            //tap for profileImage
            let userProfileTap = UITapGestureRecognizer(target: self, action: #selector(userProfileTapped(_gesture:)))
            self.profileImage.addGestureRecognizer(userProfileTap)
        }
    }
    //Create corresponding selector method in the cell
    func userProfileTapped(_gesture: UITapGestureRecognizer) {
        if let delegate = delegate {
            delegate.profileImageViewTapped(cell: self, user: self.tweet.user!)
        }
    }
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var tweetLabel: UILabel!
    @IBOutlet weak var timeStampLabel: UILabel!
    @IBOutlet weak var tweetCountLabel: UILabel!
    @IBOutlet weak var favoriteCountLabel: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var retweetButton: UIButton!
    
    var tweet: Tweet!{
        didSet{
            
            if let profileURL = tweet.user!.profileURL{
                profileImage.setImageWith(profileURL)
            }
            
            profileImage.layer.cornerRadius = 5
            nameLabel.text = tweet.user?.name
            tweetLabel.text = tweet.text
            tweetCountLabel.text = String(self.tweet.retweetCount)
            favoriteCountLabel.text = String(self.tweet.favoriteCount)
            
            let formatter = DateFormatter()
            formatter.dateFormat = "EEE MMM dd hh:mm a"
            self.timeStampLabel.text = formatter.string(from: tweet.timestamp!)
            
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func onFavorite(_ sender: UIButton) {
        
        if(sender.isSelected){
            //deselect button
            sender.isSelected = false
            tweet.favorited = false
            favoriteCountLabel.text = String(tweet.favoriteCount)
            self.favoriteButton.setImage(UIImage(named: "favor-icon.png"), for: UIControlState())
            print("Favorite Deselected")
        } else {
            //selected button
            sender.isSelected = true
            tweet.favorited = true
            favoriteCountLabel.text = String(tweet.favoriteCount)
            self.favoriteButton.setImage(UIImage(named: "favor-icon-red.png"), for: UIControlState())
            print("Favorite Selected")
        }
    }
    
    @IBAction func onRetweet(_ sender: UIButton) {
        
        if(sender.isSelected){
            //deselect button
            sender.isSelected = false
            tweet.retweeted = false
            tweetCountLabel.text = String(tweet.retweetCount)
            self.retweetButton.setImage(UIImage(named: "retweet-icon"), for: UIControlState())
            print("Retweet deselected")
        } else {
            //selected button
            sender.isSelected = true
            tweet.retweeted = true
            tweetCountLabel.text = String(tweet.retweetCount)
            self.retweetButton.setImage(UIImage(named: "retweet-icon-green"), for: UIControlState())
            print("Retweet Selected")
        }
        
    }
    
    
}
