//
//  Tweet.swift
//  BlueJayChirp
//
//  Created by Dephanie Ho on 2/21/17.
//  Copyright © 2017 Dephanie Ho. All rights reserved.
//

import UIKit

class Tweet: NSObject {

    //Name all properties
    var user: User?
    var text: String?
    var timestamp: Date?
    var retweetCount: Int
    var favoriteCount: Int
    var tweetID: String?
    
    var favorited: Bool {
        didSet{
            if favorited{
                //print(favoriteCount)
                self.favoriteCount += 1
                TwitterClient.sharedInstance?.favorite(tweetID: tweetID, favorite: true, completion : { (error: Error?) in})
            } else {
                self.favoriteCount -= 1
                TwitterClient.sharedInstance?.favorite(tweetID: tweetID, favorite: false, completion : {(error: Error?) in})
            }
        }
    }
    
    var retweeted: Bool {
        didSet {
            if retweeted {
                retweetCount += 1
                TwitterClient.sharedInstance?.retweet(tweetID: tweetID, completion: { (error: Error?) in
                })
            } else {
                retweetCount -= 1
                TwitterClient.sharedInstance?.retweet(tweetID: tweetID, completion: { (error: Error?) in
                })
            }
        }
    }
    
    //Initialize from data in API
    init(dictionary: NSDictionary){
        text = dictionary["text"] as? String
        user = User(dictionary: dictionary["user"] as! NSDictionary)
        tweetID = dictionary["id str"] as? String
        retweetCount = (dictionary["retweet_count"] as? Int) ?? 0
        favoriteCount = (dictionary["favourites_count"] as? Int) ?? 0
        
        retweeted = (dictionary["retweeted"] as? Bool) ?? false
        favorited = (dictionary["favorited"] as? Bool) ?? false
        
        let timestampString = dictionary["created_at"] as? String
        
        if let timestampString = timestampString{
            let formatter = DateFormatter()
            formatter.dateFormat = "EEE MMM d HH:mm:ss Z y"
            timestamp = formatter.date(from: timestampString)
        }
    }
    
    class func tweetsWithArray(dictionaries: [NSDictionary]) -> [Tweet] {
        //array of Tweets
        var tweets = [Tweet]()
        
        for dictionary in dictionaries{
            //create tweet based on dictionary
            let tweet = Tweet(dictionary: dictionary)
            //add tweet into dictionary
            tweets.append(tweet)
        }
        
        return tweets
    }
}
