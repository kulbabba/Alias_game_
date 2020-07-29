//
//  SparklesViewView.swift
//  Alias
//
//  Created by Kapitan Kanapka on 16.06.2020.
//  Copyright © 2020 hippo. All rights reserved.
//

import UIKit

class BackgroundView: UIView {
    
    let screenSize = UIScreen.main.bounds
    var isMainViewValue = false
    
    
    init(frame: CGRect, isMainView: Bool = false) {
        super.init(frame: frame)
        
        isMainViewValue = isMainView
        let imageName = isMainViewValue ? "mavka_02" : "noMavka"
        
        let blinkingStarOne = UIImageView()
        let blinkingStarTwo = UIImageView()
        let blinkingStarThree = UIImageView()
        let blinkingStarFour = UIImageView()
        let blinkingStarFive = UIImageView()
        
        blinkingStarOne.image = UIImage(named: "starNew1")
        blinkingStarTwo.image = UIImage(named: "starNew2")
        blinkingStarThree.image = UIImage(named: "starNew3")
        blinkingStarFour.image = UIImage(named: "starNew4")
        blinkingStarFive.image = UIImage(named: "starNew5")
        
        blinkingStarTwo.frame.size = CGSize(width: 82, height: 85)
        blinkingStarThree.frame.size = CGSize(width: 100, height: 100)
        blinkingStarFive.frame.size = CGSize(width: 130, height: 130)
        blinkingStarFour.frame.size = CGSize(width: 75, height: 75)
        blinkingStarOne.frame.size = CGSize(width: 115, height: 115)
        
        
//        blinkingStarTwo.frame.origin.x = 15
//                blinkingStarThree.frame.origin.x = 70
//                blinkingStarFive.frame.origin.x = 250
//                blinkingStarFour.frame.origin.x = 60
//                blinkingStarOne.frame.origin.x = 40
//
//        blinkingStarTwo.frame.origin.y = 15
//                blinkingStarThree.frame.origin.y = 70
//                blinkingStarFive.frame.origin.y = 250
//                blinkingStarFour.frame.origin.y = 700
//                blinkingStarOne.frame.origin.y = 400
//
//        blinkingStarOne.snp.updateConstraints { make in
//            make.left.equalToSuperview().offset(15)
//            make.top.equalToSuperview().offset(70)
//        }
//
//            blinkingStarTwo.snp.updateConstraints { make in
//                make.left.equalToSuperview().offset(60)
//                make.top.equalTo(blinkingStarOne.snp.bottom).offset(15)
//        }
//
//                blinkingStarThree.snp.updateConstraints { make in
//                make.left.equalToSuperview().offset(-25)
//                make.top.equalToSuperview().offset(10)
//        }
                    
//                    blinkingStarFour.snp.updateConstraints { make in
//                    make.left.equalToSuperview().offset(90)
//                    make.top.equalToSuperview().offset(600)
//        }
//                        
//                        blinkingStarFive.snp.updateConstraints { make in
//                        make.left.equalToSuperview().offset(70)
//                        make.top.equalToSuperview().offset(100)
//        }
//        
        
        
        let backgroundView = UIImageView()
        
        backgroundView.image = UIImage(named: imageName)
        backgroundView.contentMode = .scaleAspectFill
        backgroundView.frame = screenSize
        backgroundView.clipsToBounds = true
        
        let arrayOftimeIntervales = [2.0, 7.0, 5.0, 8.0, 9.0]
               let arrayOfStarsToBlink = [blinkingStarOne, blinkingStarTwo, blinkingStarThree, blinkingStarFour, blinkingStarFive]
               
        
        self.addSubview(backgroundView)
        for starView in arrayOfStarsToBlink {
            self.addSubview(starView)
        }
        
        for star in arrayOfStarsToBlink {
            star.alpha = 0.0
            UIView.animate(withDuration: arrayOftimeIntervales.randomElement()!, delay: arrayOftimeIntervales.randomElement()!, options: [.curveLinear, .repeat, .autoreverse], animations: {
                
                star.alpha = 0.6
                
            }, completion: nil)
            
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
