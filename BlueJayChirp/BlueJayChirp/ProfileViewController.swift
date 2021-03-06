//
//  ProfileViewController.swift
//  BlueJayChirp
//
//  Created by Dephanie Ho on 3/7/17.
//  Copyright © 2017 Dephanie Ho. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var tweetCountLabel: UILabel!
    @IBOutlet weak var followingCountLabel: UILabel!
    @IBOutlet weak var followerCountLabel: UILabel!
    @IBOutlet weak var profileUserBgImageView: UIImageView!
    
    var user : User!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        profileImageView.setImageWith((user?.profileURL)!)
        profileUserBgImageView.setImageWith((user?.profileBgURL)!)
        followerCountLabel.text = String(user.followersCount)
        followingCountLabel.text = String(user.followingCount)
        tweetCountLabel.text = String(user.tweetCount)
        self.title = user.name
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func goBack(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
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
