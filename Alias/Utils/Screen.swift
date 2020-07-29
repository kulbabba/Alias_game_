//
//  Screen.swift
//  Alias
//
//  Created by Oleg Ivaniv on 17.06.2020.
//  Copyright © 2020 Crazy Hippo. All rights reserved.
//

import UIKit

final class Screen {
    static var height: CGFloat {
        if let keyWindow = UIApplication.shared.keyWindow {
            return keyWindow.bounds.size.height
        }
        
        return UIScreen.main.bounds.size.height
    }
    
    static var width: CGFloat {
        if let keyWindow = UIApplication.shared.keyWindow {
            return keyWindow.bounds.size.width
        }
        
        return UIScreen.main.bounds.size.width
    }
}
