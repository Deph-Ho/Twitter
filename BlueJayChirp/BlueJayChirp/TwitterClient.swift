//
//  TwitterClient.swift
//  BlueJayChirp
//
//  Created by Dephanie Ho on 2/21/17.
//  Copyright © 2017 Dephanie Ho. All rights reserved.
//

import UIKit
import BDBOAuth1Manager

class TwitterClient: BDBOAuth1SessionManager {
        
    //static == class, cannot be overwritten
    static let sharedInstance = TwitterClient(baseURL: URL(string:"https://api.twitter.com")!, consumerKey: "CXrLx7Ni7ROw3LzHQJTGsU0c1", consumerSecret: "3iN9oZOMLb7tZKOoo9lId4BWGfhmwT3bQ5ZfqHJcxQuv3P62Jz")
    
    var loginSuccess: (()->())?
    var loginFailure: ((Error) -> ())?
    
    func login(success: @escaping()->(), failure: @escaping(Error)->()) {
        loginSuccess = success
        loginFailure = failure
        TwitterClient.sharedInstance?.deauthorize()
        TwitterClient.sharedInstance?.fetchRequestToken(withPath: "oauth/request_token", method: "GET", callbackURL: URL(string: "bluejaychirp://oauth"), scope: nil, success: {(requestToken:BDBOAuth1Credential?) in
            
            let url = URL(string: "https://api.twitter.com/oauth/authorize?oauth_token=\(requestToken!.token!)")!
            UIApplication.shared.openURL(url)
            
        }, failure: { (error:Error?) in
            print("error: \(error?.localizedDescription)")
            self.loginFailure!(error!)
        })
    }
    
    func logout(){
        User.currentUser = nil
        deauthorize()
        NotificationCenter.default.post(name: NSNotification.Name(User.userDidLogoutNotification), object: nil)
       
    }
    
    
    func handleOpenUrl(url: URL){
        let requestToken = BDBOAuth1Credential(queryString: url.query)
        fetchAccessToken(withPath: "oauth/access_token", method: "POST", requestToken: requestToken, success: { (accessToken:BDBOAuth1Credential?) in
            
            self.currentAccount(success: { (user: User) in
                //call setter and save user as currentUser
                User.currentUser = user
                self.loginSuccess!()
            }, failure: { (error: Error) in
                self.loginFailure!(error)
            })
            self.loginSuccess?()
            
        }, failure: { (error:Error?) in
            print("error: \(error?.localizedDescription)")
            self.loginFailure!(error!)
        })
    }
    
    //fetch the hometimeline
    func homeTimeline(success: @escaping ([Tweet]) -> (), failure: @escaping (Error) -> ()) {
        
        get("1.1/statuses/home_timeline.json", parameters: nil, progress: nil, success: { (task: URLSessionDataTask, response: Any?) in
            let dictionaries = response as! [NSDictionary]
            let tweets = Tweet.tweetsWithArray(dictionaries: dictionaries)
            
            success(tweets)
            
        }, failure: { (task: URLSessionDataTask?, error: Error) -> Void in
            failure(error)
        })
    }
    
    //Create account
    func currentAccount(success: @escaping(User) ->(), failure: @escaping(Error) -> ()){
        get("1.1/account/verify_credentials.json", parameters: nil, progress: nil, success: { (task: URLSessionDataTask, response: Any?) in
            
            let userDictionary = response as! NSDictionary
            let user = User(dictionary: userDictionary)
            
            success(user)
            
        }, failure: { (task: URLSessionDataTask?, error: Error)-> Void in
            failure(error)
        })

    }
    
    func favorite(tweetID: String?, favorite: Bool, completion: @escaping (_ error: Error?) -> Void) {
        let endpoint = favorite ? "create" : "destroy"
        post("1.1/favorites/\(endpoint).json", parameters: ["id": tweetID], progress: nil, success: { (operation: URLSessionDataTask, response: Any?) -> Void in
            //let tweet = Tweet(dictionary: response as! NSDictionary)
            completion(nil)
        }, failure: { (operation: URLSessionDataTask?, error: Error) -> Void in
            completion(error)
        })
    }
    
    func retweet(tweetID: String?, completion: @escaping (_ error: Error?) -> Void) {
        self.post("1.1/statuses/retweet/\(tweetID).json", parameters: nil, progress: nil, success: { (operation, response) -> Void in
            completion(nil)
        }, failure: { (operation, error) -> Void in
            completion(error)
        })
    }
}
