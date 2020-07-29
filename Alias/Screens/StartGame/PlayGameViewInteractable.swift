//
//  StartGameViewInteractable.swift
//  Alias
//
//  Created by Kapitan Kanapka on 17.06.2020.
//  Copyright © 2020 Crazy Hippo. All rights reserved.
//

import UIKit

typealias PlayGameViewInteractable = UIView & PlayGameViewInteractor

protocol PlayGameViewInteractor {
    var delegate: PlayGameViewDelegate? { get set }
    
    /// Required initializer of the view
    /// - Parameter config: pass any needed values to view via config
    init(with config: PlayGameViewConfig)
    
    func update(with config: PlayGameViewConfig)
    
    func updatetimerLabel(seconds: Int)
    
    func updateScoreLabelValue(score: Int)
    
    func updateCurrentTeamName(teamName: String)
    
    func updateGameValuesBeforeGame()
}

protocol PlayGameViewDelegate: class {
    
    /// Nofity view controller that user has pressed ok button
    func okButtonPressed(word: String)
    
    /// Nofity view controller that user has pressed skip button
    func skipPressed(word: String)
    
    /// Nofity view controller that user has pressed start game button
    func startGameButtonPressed()
    
    /// Nofity view controller that user has pressed end game button
    func endGame()

}
