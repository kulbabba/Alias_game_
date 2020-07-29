//
//  RoundResultsViewInteractable.swift
//  Alias
//
//  Created by Kapitan Kanapka on 17.06.2020.
//  Copyright © 2020 Crazy Hippo. All rights reserved.
//

import UIKit

typealias RoundResultsViewInteractable = UIView & RoundResultsViewInteractor

protocol RoundResultsViewInteractor {
    var delegate: RoundResultsViewDelegate? { get set }
    
    /// Required initializer of the view
    /// - Parameter config: pass any needed values to view via config
    init(with config: RoundResultsViewConfig)
    
    func update(with config: RoundResultsViewConfig)
}

protocol RoundResultsViewDelegate: class {
    
    /// Nofity view controller that user has pressed Next Team button
    func startNextTeamButtonPressed()
    
    /// Nofity view controller that user has pressed End Game button
    func endGamePressed()
    
}
