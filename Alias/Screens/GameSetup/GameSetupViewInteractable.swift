//
//  GameSetupViewInteractable.swift
//  Alias
//
//  Created by Oleg Ivaniv on 17.06.2020.
//  Copyright © 2020 Crazy Hippo. All rights reserved.
//

import Foundation
import UIKit

typealias GameSetupViewInteractable = UIView & GameSetupViewInteractor

protocol GameSetupViewInteractor {
    var delegate: GameSetupViewDelegate? { get set }
    
    /// Required initializer of the view
    /// - Parameter config: pass any needed values to view via config
    init(with config: GameSetupViewConfig)
    
    func update(with config: GameSetupViewConfig)
    
    func updateTimeAndRoundsValue(with config: GameSetupViewConfig)
}

protocol GameSetupViewDelegate: class {
    
    /// Nofity view controller that user has pressed start game button
    func startGameButtonPressed()
    
    /// Nofity view controller that user has clicked on Time item
    func timeButtonPressed()
    
    /// Nofity view controller that user has clicked on Rounds item
    func roundsButtonPressed()
}
