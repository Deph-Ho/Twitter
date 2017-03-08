//
//  ComposeViewController.swift
//  BlueJayChirp
//
//  Created by Dephanie Ho on 2/28/17.
//  Copyright © 2017 Dephanie Ho. All rights reserved.
//

import UIKit

class ComposeViewController: UIViewController {
    
    @IBOutlet weak var composeImageView: UIImageView!
    @IBOutlet weak var composeUserLabel: UILabel!
    @IBOutlet weak var composeTextView: UITextView!
    
    var user = User.currentUser
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        composeUserLabel.text = user?.name
        composeImageView.setImageWith((user?.profileURL)!)
        
        composeTextView.sizeToFit()
        composeTextView.becomeFirstResponder()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
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
