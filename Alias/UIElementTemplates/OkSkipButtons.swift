//
//  OkSkipButtons.swift
//  Alias
//
//  Created by Kapitan Kanapka on 16.06.2020.
//  Copyright © 2020 hippo. All rights reserved.
//

import UIKit

class OkSkipButton: UIButton {
    
    private(set) var height: CGFloat = Constants.height
    private(set) var width: CGFloat = Constants.width
    
    var isOkButton = false
    
    init(isOkButton: Bool) {
        let size = CGSize(width: 110, height: 50)
        let frameValue = CGRect(origin: CGPoint(x: 0, y: 0), size: size)
        super.init(frame: frameValue)
        
        self.setTitleColor(.black, for: .normal)
        self.setTitleShadowColor(.systemGray2, for: .normal)
        self.backgroundColor = isOkButton ? #colorLiteral(red: 0.1466449058, green: 0.8278574486, blue: 0.5678510274, alpha: 0.3815550086).withAlphaComponent(0.38) : #colorLiteral(red: 0.722067637, green: 0.3487264555, blue: 0.5678510274, alpha: 0.3815550086).withAlphaComponent(0.38)
        var buttonTitle = isOkButton ? "Ok" : "Skip"
        self.setTitle(buttonTitle, for: .normal)
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


// MARK: - Private constants

private struct Constants {
    static let width: CGFloat = 110
    static let height: CGFloat = 50
}
