//
//  WordsTableViewCell.swift
//  Alias
//
//  Created by Kapitan Kanapka on 09.06.2020.
//  Copyright © 2020 hippo. All rights reserved.
//

import UIKit

class WordsTableViewCell: UITableViewCell {

    
    @IBOutlet weak var wordNameValue: UILabel!

    @IBOutlet weak var wordResultValue: UILabel!
    
    static let reuseIdentifier = String(describing: WordsTableViewCell.self)
        //    override func awakeFromNib() {
    //        super.awakeFromNib()
//        // Initialization code
//    }


}
