//
//  StartGameViewController.swift
//  Alias
//
//  Created by Kapitan Kanapka on 17.06.2020.
//  Copyright © 2020 Crazy Hippo. All rights reserved.
//

import UIKit

typealias PlayItem = (word: String, isCorrect: Bool)

class PlayGameViewController: UIViewController {
    var mainView: PlayGameViewInteractable!
    let viewModel = PlayGameViewModel()
    var teamList = TeamData()
    var timer = Timer()
    var seconds: Int = 0
    var currentWordsInRound: [PlayItem] = []
    var currentRoundScore = 0
    var currentRound = 1
    var currentTeam = Team()
    var delegate: PlayGameViewControllerDelegate?

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
        currentTeam = teamList.teams.first!
        
        let config = PlayGameViewConfig(rounds: teamList.roundTotal,
                                        duration: teamList.secondsForRound, currentTeam: currentTeam)
        
        mainView = PlayGameView(with: config)
        mainView.delegate = self
        
        view.addFullyExtended(mainView)
    }
}

extension PlayGameViewController: PlayGameViewDelegate {
    
    func skipPressed(word: String) {
        let newElement = PlayItem(word: word, isCorrect: false)
        
        currentWordsInRound.append(newElement)
        
        currentRoundScore -= 1
        mainView.updateScoreLabelValue(score: currentRoundScore)
        
    }
    
    
    func okButtonPressed(word: String) {
        let newElement = PlayItem(word: word, isCorrect: true)
        
        currentWordsInRound.append(newElement)
        
        currentRoundScore += 1
        mainView.updateScoreLabelValue(score: currentRoundScore)
        
    }
    
    func startGameButtonPressed() {
        runTimer()
        
    }
    
    func endGame() {
        navigationController?.popToRootViewController(animated: true)
        delegate?.endGame()
    }
}

extension PlayGameViewController: RoundResultsViewControllerDelegate {
    func updateValuesForNewRound() {
        chooseNextTeamInRound()
        prepareViewBeforePlay()
    }
    func endGameOnRoundResults() {
        self.endGame()
    }
}

extension PlayGameViewController {
    func runTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self,   selector: (#selector(self.updateTimer)), userInfo: nil, repeats: true)
    }
    
    @objc func updateTimer() {
        if seconds < 1 {
            timer.invalidate()
           /// showResults()
            let currentTeamIndex = teamList.teams.firstIndex(of: currentTeam)!
            teamList.teams[currentTeamIndex].teamScore += currentRoundScore
            
            
            let roundResultsViewController = RoundResultsViewController()
            if currentRound == teamList.roundTotal,
                currentTeam == teamList.teams.last {
                roundResultsViewController.isLastRound = true
            }
            roundResultsViewController.configForView = RoundResultsViewConfig( curentTeam: currentTeam, teamList: teamList, wordList: currentWordsInRound, scoreForCurrentRound: currentRoundScore, isLastRound: roundResultsViewController.isLastRound)
            roundResultsViewController.delegateRoundResults = self
            navigationController?.pushViewController(roundResultsViewController, animated: true)

        } else {
            seconds -= 1
            mainView.updatetimerLabel(seconds: seconds)
        }
        
    }
    
    func chooseNextTeamInRound() {
        let currentTeamIndex = teamList.teams.firstIndex(of: currentTeam)!
        if currentTeam == teamList.teams.last {
            currentRound += 1
            currentTeam = teamList.teams.first!
        }
        else {
            currentTeam = teamList.teams[currentTeamIndex + 1]
        }
    }
    
    func prepareViewBeforePlay() {
        currentRoundScore = 0
        currentWordsInRound = []
        seconds = teamList.secondsForRound
        mainView.updateCurrentTeamName(teamName: currentTeam.teamName)
        mainView.updateGameValuesBeforeGame()
    }

}

protocol PlayGameViewControllerDelegate {
    func endGame()
}
