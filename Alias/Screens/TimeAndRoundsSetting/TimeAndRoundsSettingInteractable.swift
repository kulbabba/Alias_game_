//
//  TimeAndRoundsInteractable.swift
//  Alias
//
//  Created by Kapitan Kanapka on 17.06.2020.
//  Copyright © 2020 Crazy Hippo. All rights reserved.
//


import UIKit

typealias TimeAndRoundsSettingViewInteractable = UIView & TimeAndRoundsSettingsViewInteractor

protocol TimeAndRoundsSettingsViewInteractor {
    var delegate: TimeAndRoundsSettingsViewDelegate? { get set }
    
    /// Required initializer of the view
    /// - Parameter config: pass any needed values to view via config
    init(with config: TimeAndRoundsSettingViewConfig)
    
    func update(with config: TimeAndRoundsSettingViewConfig)
}

protocol TimeAndRoundsSettingsViewDelegate: class {
    
    /// Nofity view controller that user has pressed ok button
    func okButtonPressed(userPickedValue: Int)
    
    /// Nofity view controller that user has pressed cancel button
    func cancelButtonPressed()
    
}
