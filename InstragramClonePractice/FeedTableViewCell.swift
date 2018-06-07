//
//  FeedTableViewCell.swift
//  InstragramClonePractice
//
//  Created by Kelly Douglass on 6/7/18.
//  Copyright © 2018 Kelly Douglass. All rights reserved.
//

import UIKit

class FeedTableViewCell: UITableViewCell {

	@IBOutlet weak var postedImage: UIImageView!
	@IBOutlet weak var usernameLabel: UILabel!
	@IBOutlet weak var messageLabel: UILabel!
	
	override func awakeFromNib() {
		super.awakeFromNib()
		// Initialization code
	}
	
	override func setSelected(_ selected: Bool, animated: Bool) {
		super.setSelected(selected, animated: animated)
		
		// Configure the view for the selected state
	}

}
