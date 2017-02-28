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
    var retweetCount: Int = 0
    var favoriteCount: Int = 0
    
    //Initialize from data in API
    init(dictionary: NSDictionary){
        text = dictionary["text"] as? String
        user = User(dictionary: dictionary["user"] as! NSDictionary)
        
        retweetCount = (dictionary["retweet_count"] as? Int) ?? 0
        favoriteCount = (dictionary["favourites_count"] as? Int) ?? 0
        
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
