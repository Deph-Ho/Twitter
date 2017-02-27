//
//  User.swift
//  BlueJayChirp
//
//  Created by Dephanit Ho on 2/21/17.
//  Copyright © 2017 Dephanie Ho. All rights reserved.
//

import UIKit

class User: NSObject {
    
    //Name all properties (stored property)
    var name: String?
    var screenname: String?
    var profileURL: URL?
    var tagline: String?
    var dictionary: NSDictionary?
    
    static let userDidLogoutNotification = "UserDidLogout"
    
    //Initialize from data from API
    init(dictionary: NSDictionary){
        self.dictionary = dictionary
        name = dictionary["name"] as? String
        screenname = dictionary["screen_name"] as? String
        
        let profileURLString = dictionary["profile_image_url_https"] as? String
        if let profileURLString = profileURLString{
            profileURL = URL(string: profileURLString as String)
        }
        tagline = dictionary["description"] as? String
    }
    
    static var _currentUser: User?
    
    //Computed property
    class var currentUser: User? {
        get{
            if _currentUser == nil{
                let defaults = UserDefaults.standard
                let userData = defaults.object(forKey: "currentUserData") as? Data
                
                if userData != nil{
                    //let dictionary = try! JSONSerialization.jsonObject(with: userData, options: []) as! NSDictionary
                    //_currentUser = User(dictionary: dictionary)
                }
            }
            return _currentUser
        }
        set(user){
            _currentUser = user
            
            //saves user
            let defaults = UserDefaults.standard
            
            if let user = user{
                let data = try! JSONSerialization.data(withJSONObject: user.dictionary!, options: [])
                defaults.set(user, forKey: "currentUserData")
                
            } else {
                defaults.removeObject(forKey: "currentUserData")
            }
            
            defaults.synchronize()
        }
    }
}
