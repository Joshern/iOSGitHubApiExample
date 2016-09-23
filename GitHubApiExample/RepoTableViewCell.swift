//
//  RepoTableViewCell.swift
//  GitHubApi
//
//  Created by Josh on 9/23/16.
//  Copyright © 2016 Josh. All rights reserved.
//

import UIKit

class RepoTableViewCell: UITableViewCell {

    
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var lblCreatedAt: UILabel!
    @IBOutlet weak var lblOwner: UILabel!
    @IBOutlet weak var lblLanguage: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
