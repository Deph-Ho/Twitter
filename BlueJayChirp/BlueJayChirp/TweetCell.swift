//
//  TweetCell.swift
//  BlueJayChirp
//
//  Created by Dephanie Ho on 2/27/17.
//  Copyright © 2017 Dephanie Ho. All rights reserved.
//

import UIKit

class TweetCell: UITableViewCell {

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var tweetLabel: UILabel!
    @IBOutlet weak var timeStampLabel: UILabel!
    @IBOutlet weak var tweetCountLabel: UILabel!
    @IBOutlet weak var favoriteCountLabel: UILabel!
    
    var tweet: Tweet!{
        didSet{
            
            if let profileURL = tweet.user!.profileURL{
                profileImage.setImageWith(profileURL)
            }
            
            profileImage.layer.cornerRadius = 5
            nameLabel.text = tweet.user?.name
            tweetLabel.text = tweet.text
            tweetCountLabel.text = String(tweet.favoriteCount)
            favoriteCountLabel.text = String(tweet.retweetCount)
            
            let formatter = DateFormatter()
            formatter.dateFormat = "EEE MMM d HH:mm"
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

}
