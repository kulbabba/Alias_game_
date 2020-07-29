//
//  EndResultsViewInteractable.swift
//  Alias
//
//  Created by Kapitan Kanapka on 17.06.2020.
//  Copyright © 2020 Crazy Hippo. All rights reserved.
//

import UIKit

typealias EndResultsViewInteractable = UIView & EndResultsViewInteractor

protocol EndResultsViewInteractor {
    var delegate: EndResultsViewDelegate? { get set }
    
    /// Required initializer of the view
    /// - Parameter config: pass any needed values to view via config
    init(with config: EndResultsViewConfig)
    
    func update(with config: EndResultsViewConfig)
}

protocol EndResultsViewDelegate: class {
    
    /// Nofity view controller that user has pressed start new game button
    func startNewGameButtonPressed()

}
