//
//  UsersTableViewController.swift
//  InstragramClonePractice
//
//  Created by Kelly Douglass on 6/5/18.
//  Copyright © 2018 Kelly Douglass. All rights reserved.
//

import UIKit
import Parse

class UsersTableViewController: UITableViewController {

	var usernames = [""]
	var userIDs = [""]
	var isFollowing = ["": false]
	
	var refresher = UIRefreshControl()
	
    override func viewDidLoad() {
        super.viewDidLoad()
		
		let query = PFUser.query()
		
		query?.findObjectsInBackground(block: { (objects, error) in
			
			if error != nil {
				print(error as Any)
			} else {
				
				if let users = objects {
					self.usernames.removeAll()
					self.userIDs.removeAll()
					self.isFollowing.removeAll()
					
					for object in users {
						if let user = object as? PFUser {
							if user.objectId != PFUser.current()?.objectId {
								let usernameArray = user.username!.components(separatedBy: "@")
								
								self.usernames.append(usernameArray[0])
								self.userIDs.append(user.objectId!)
								
								let query = PFQuery(className: "Followers")
								query.whereKey("follower", equalTo: (PFUser.current()?.objectId)!)
								query.whereKey("following", equalTo: user.objectId!)
								
								query.findObjectsInBackground(block: { (objects, error) in
									if let objects = objects {
										if objects.count > 0 {
											self.isFollowing[user.objectId!] = true
										} else {
											self.isFollowing[user.objectId!] = false
										}
										if self.isFollowing.count == self.usernames.count {
											self.tableView.reloadData()
											self.refresher.endRefreshing()
										}
									}
								})
							}
						}
					}
				}
			}
		})
		
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return usernames.count
    }

	
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        cell.textLabel?.text = usernames[indexPath.row]

		if isFollowing[userIDs[indexPath.row]]! {
			cell.accessoryType = UITableViewCellAccessoryType.checkmark
		}
		
		
        return cell
    }

	@IBAction func logoutPressed(_ sender: Any) {
		PFUser.logOutInBackground { (error) in
			if error != nil {
				print("error")
			} else {
				self.performSegue(withIdentifier: "toLoginScreen", sender: self)
			}
		}
		
	}
	
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		
		let cell = tableView.cellForRow(at: indexPath)
		
		if isFollowing[userIDs[indexPath.row]]! {
			
			isFollowing[userIDs[indexPath.row]] = false
			
			cell?.accessoryType = UITableViewCellAccessoryType.none
			let query = PFQuery(className: "Followers")
			query.whereKey("follower", equalTo: (PFUser.current()?.objectId!)!)
			query.whereKey("Following", equalTo: userIDs[indexPath.row])
			
			query.findObjectsInBackground { (objects, error) in
				if let objects = objects {
					for object in objects {
						object.deleteInBackground()
					}
				}
			}
			
		} else {
			
			isFollowing[userIDs[indexPath.row]] = true
			
			cell?.accessoryType = UITableViewCellAccessoryType.checkmark
			let following = PFObject(className: "Followers")
			
			following["follower"] = PFUser.current()?.objectId
			following["following"] = userIDs[indexPath.row]
			
			following.saveInBackground()
			
		}
		
	}
	
	

}
