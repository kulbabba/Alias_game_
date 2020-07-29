//
//  title1Label.swift
//  Alias
//
//  Created by Kapitan Kanapka on 16.06.2020.
//  Copyright © 2020 hippo. All rights reserved.
//

import UIKit

class TitleLabel: UILabel {
    
    init() {
        let maxSize = CGSize(width: 120, height: 40)
        let frameValue = CGRect(origin: CGPoint(x: 0, y: 0), size: maxSize)
        super.init(frame: frameValue)
        
        self.textColor = .systemGray2
        self.font = UIFont(name: "Chalkduster", size: 32)
        self.layer.cornerRadius = 10
    }
    
    required init?(coder: NSCoder) {
        fatalError("no init")
    }
}
