//
//  ViewController.swift
//  InstragramClonePractice
//
//  Created by Kelly Douglass on 6/5/18.
//  Copyright © 2018 Kelly Douglass. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController, UITextFieldDelegate {

	
	@IBOutlet weak var emailTextField: UITextField!
	@IBOutlet weak var passwordTextField: UITextField!
	
	
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		emailTextField.delegate = self
		passwordTextField.delegate = self
		
			self.navigationController?.navigationBar.isHidden = true
		// Do any additional setup after loading the view, typically from a nib.
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}

	  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
		self.view.endEditing(true)
	}
	
	func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		emailTextField.resignFirstResponder()
		passwordTextField.resignFirstResponder()
		return true
	}
	
	
	@IBAction func loginPressed(_ sender: UIButton) {
		
		PFUser.logInWithUsername(inBackground: emailTextField.text!, password: passwordTextField.text!) { (user, error) in
			if error != nil {
				print("error")
			} else {
				self.performSegue(withIdentifier: "toNavController", sender: self)
			}
		}
		
		
		
		
	}
	

}

