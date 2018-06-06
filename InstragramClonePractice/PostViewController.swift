//
//  PostViewController.swift
//  InstragramClonePractice
//
//  Created by Kelly Douglass on 6/6/18.
//  Copyright © 2018 Kelly Douglass. All rights reserved.
//

import UIKit
import Parse
import SVProgressHUD

class PostViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

	@IBOutlet weak var postImage: UIImageView!
	@IBOutlet weak var postMessage: UITextField!
	
	
    override func viewDidLoad() {
        super.viewDidLoad()

		postImage.image = UIImage(named: "personIcon.png")
	
		
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
	
	func createAlert(title: String, message: String) {
		let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
	
		alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
			alert.dismiss(animated: true, completion: nil)
		}))
		
		alert.present(alert, animated: true, completion: nil)
		
	}
	
	
	@IBAction func chooseImage(_ sender: UIButton) {
		let imagePicker = UIImagePickerController()
		imagePicker.delegate = self
		imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary
		imagePicker.allowsEditing = false
		self.present(imagePicker, animated: true)
		
	}
	
	// available function for UIImagePickerControllerDelegate
	func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
		if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
			postImage.image = image
		}
		self.dismiss(animated: true, completion: nil)
	}
	
	
	@IBAction func submitPost(_ sender: UIButton) {
		
		//SVProgressHUD.show()
		
		let post = PFObject(className: "Posts")
		
		post["message"] = postMessage.text
		post["userId"] = PFUser.current()?.objectId
		let imageData = UIImagePNGRepresentation(postImage.image!) // convert image to saveable format
		let imageFile = PFFile(name: "image.png", data: imageData!) // create file to save
		post["imageFile"] = imageFile
		post.saveInBackground { (success, error) in
			
			//SVProgressHUD.dismiss()
			
			if error != nil {
				print(error as Any)
				//self.createAlert(title: "Error", message: "There was an error posting your image")
			} else {
				//self.createAlert(title: "Success", message: "Your image was posted")
				self.postImage.image = UIImage(named: "personIcon.png")
				self.postMessage.text = ""
			}
		}
		
		
		
	}
	
}
