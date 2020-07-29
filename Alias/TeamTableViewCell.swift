//
//  TeamTableViewCell.swift
//  Alias
//
//  Created by Kapitan Kanapka on 09.06.2020.
//  Copyright © 2020 hippo. All rights reserved.
//

import UIKit

class TeamTableViewCell: UITableViewCell {

    @IBOutlet weak var teamNameTableViewCell: UILabel!
    
    @IBOutlet weak var teamScoreTableViewCell: UILabel!
    
     static let reuseIdentifier = String(describing: TeamTableViewCell.self)
    
}
