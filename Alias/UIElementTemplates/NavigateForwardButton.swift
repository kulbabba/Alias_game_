//
//  NavigateForwardButton.swift
//  Alias
//
//  Created by Kapitan Kanapka on 16.06.2020.
//  Copyright © 2020 hippo. All rights reserved.
//


import UIKit

class NavigateForwardButton: UIButton {
    
    private(set) var height: CGFloat = Constants.height
    private(set) var width: CGFloat = Constants.width
    
    init() {
        super.init(frame: .zero)
        
        applyDefaultStyle()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        if frame != .zero {
            width = frame.width
            height = frame.height
        }
        
        applyDefaultStyle()
    }
    
    private func applyDefaultStyle() {
        backgroundColor = #colorLiteral(red: 0.1466449058, green: 0.8278574486, blue: 0.5678510274, alpha: 0.467572774).withAlphaComponent(0.38)
        
        setTitleColor(.black, for: .normal)
        setTitleShadowColor(.systemGray2, for: .normal)
        
        titleLabel?.font = UIFont(name: "Chalkduster" , size: 17.0)
        layer.cornerRadius = 9
        layer.borderWidth = 2
        
        titleLabel?.shadowOffset = CGSize(width: 3.0, height: -1.0)
        titleLabel?.shadowColor = UIColor.systemGray2
//        titleLabel?.shadowOpacity = 1.0
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Private constants

private struct Constants {
    static let width: CGFloat = 132
    static let height: CGFloat = 50
}

