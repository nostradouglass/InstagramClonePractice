//
//  SignUpViewController.swift
//  InstragramClonePractice
//
//  Created by Kelly Douglass on 6/5/18.
//  Copyright © 2018 Kelly Douglass. All rights reserved.
//

import UIKit
import Parse

class SignUpViewController: UIViewController {

	@IBOutlet weak var emailText: UITextField!
	@IBOutlet weak var passwordText: UITextField!
	@IBOutlet weak var ageText: UITextField!
	
	override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

	@IBAction func signupPressed(_ sender: UIButton) {
		
		let user = PFUser()
		
		user.username = emailText.text
		user.password = passwordText.text
		user.email = emailText.text
		user["age"] = ageText.text
		
		user.signUpInBackground { (success, error) in
			if error != nil {
				print("error")
			} else {
				self.dismiss(animated: true, completion: nil)
			}
		}
		
		
		
	}
	
	@IBAction func cancelPressed(_ sender: Any) {
		self.dismiss(animated: true, completion: nil)
	}
	
}
