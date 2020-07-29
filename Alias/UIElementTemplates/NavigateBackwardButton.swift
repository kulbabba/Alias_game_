//
//  NavigateBackwardButton.swift
//  Alias
//
//  Created by Kapitan Kanapka on 16.06.2020.
//  Copyright © 2020 hippo. All rights reserved.
//

import UIKit

class NavigateBackwardButton: UIButton {
    
    init() {
        let size = CGSize(width: 132, height: 50)
        let frameValue = CGRect(origin: CGPoint(x: 0, y: 0), size: size)
        super.init(frame: frameValue)
        
        self.setTitleColor(.black, for: .normal)
        self.setTitleShadowColor(.systemGray2, for: .normal)
        self.backgroundColor = #colorLiteral(red: 0.8278574486, green: 0.1261896587, blue: 0.3487559545, alpha: 0.467572774).withAlphaComponent(0.47)
        self.titleLabel!.font = UIFont(name: "Chalkduster" , size: 17.0)
        self.layer.cornerRadius = 9
        self.layer.borderWidth = 2
        self.titleLabel?.shadowOffset = CGSize(width: 3.0, height: -1.0)
        self.titleLabel?.shadowColor = UIColor.systemGray2
    }
    
    required init?(coder: NSCoder) {
        fatalError("no init")
    }
}
