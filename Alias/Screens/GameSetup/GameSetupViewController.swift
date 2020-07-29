//
//  GameSetupViewController.swift
//  Alias
//
//  Created by Kapitan Kanapka on 16.06.2020.
//  Copyright © 2020 hippo. All rights reserved.
//

import UIKit

class GameSetupViewController: UIViewController {
    var mainView: GameSetupViewInteractable!
    let viewModel = GameSetupViewModel()
    var teamList = TeamData()
    var totalRoundsCount = 0
    var secondsForRound = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupMainView()
    }
    
    private func setupMainView() {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
        self.navigationItem.leftItemsSupplementBackButton = false
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title:"", style:.plain, target:nil, action:nil)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title:"", style:.plain, target:nil, action:nil)
        
       // let team1 = TeamCollectionViewConfig(teamName: "first")
     //   let team2 = TeamCollectionViewConfig(teamName: "second")
     //   let team3 = TeamCollectionViewConfig(teamName: "third")
        
        
        totalRoundsCount = teamList.roundTotal
        secondsForRound = teamList.secondsForRound
        
        let config = GameSetupViewConfig(rounds: totalRoundsCount,
                                         duration: secondsForRound,
                                         teams: teamList.teams)
        
        mainView = GameSetupView(with: config)
        mainView.delegate = self
        
        view.addFullyExtended(mainView)
    }
}

extension GameSetupViewController: GameSetupViewDelegate {
    func startGameButtonPressed() {
        let startGameViewController = PlayGameViewController()
        startGameViewController.teamList = teamList
        startGameViewController.seconds = teamList.secondsForRound
        startGameViewController.delegate = self
        navigationController?.pushViewController(startGameViewController, animated: true)
    }
    
    func timeButtonPressed() {
        let timeAndRoundsSettingViewController = TimeAndRoundsSettingViewController()
        timeAndRoundsSettingViewController.teamList = teamList
        timeAndRoundsSettingViewController.isTimePicker = true
        timeAndRoundsSettingViewController.timeAndRoundsViewControllerDelegate = self
        navigationController?.pushViewController(timeAndRoundsSettingViewController, animated: true)
    }
    
    func roundsButtonPressed() {
        let timeAndRoundsSettingViewController = TimeAndRoundsSettingViewController()
        timeAndRoundsSettingViewController.teamList = teamList
        timeAndRoundsSettingViewController.isTimePicker = false
        timeAndRoundsSettingViewController.timeAndRoundsViewControllerDelegate = self
        navigationController?.pushViewController(timeAndRoundsSettingViewController, animated: true)
    }
}

extension GameSetupViewController: PlayGameViewControllerDelegate {
    func endGame() {
        teamList = TeamData()
        totalRoundsCount = teamList.roundTotalDefault
        secondsForRound = teamList.secondsForRoundDefault
        
        let config = GameSetupViewConfig(rounds: totalRoundsCount,
                                         duration: secondsForRound,
                                         teams: teamList.teams)
        
        mainView = GameSetupView(with: config)
        mainView.delegate = self
        
        view.addFullyExtended(mainView)
    }
    
}

extension GameSetupViewController: TimeAndRoundsSettingViewControllerDelegate {
    func updateUserPickedValue() {
        let config = GameSetupViewConfig(rounds: teamList.roundTotal,
                                         duration: teamList.secondsForRound,
                                         teams: teamList.teams)
        mainView.updateTimeAndRoundsValue(with: config)
    }
}
