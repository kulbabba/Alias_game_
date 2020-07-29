//
//  TitleSmallLabel.swift
//  Alias
//
//  Created by Kapitan Kanapka on 16.06.2020.
//  Copyright © 2020 hippo. All rights reserved.
//

import UIKit

class TitleSmallLabel: TitleLabel {
    
    override init() {
        super.init()
        self.font = UIFont(name: "Chalkduster", size: 26)
    }
    
    required init?(coder: NSCoder) {
        fatalError("no init")
    }
}

