//
//  StartGameViewController.swift
//  Alias
//
//  Created by Kapitan Kanapka on 05.06.2020.
//  Copyright © 2020 hippo. All rights reserved.
//

import UIKit

//typealias PlayItem = (word: String, isCorrect: Bool)

class StartGameViewController: UIViewController {
    
    @IBOutlet weak var blinkingStartOne: UIImageView!
    @IBOutlet weak var blinkingStarTwo: UIImageView!
    @IBOutlet weak var blinkingStarThree: UIImageView!
    @IBOutlet weak var blinkingStarFour: UIImageView!
    @IBOutlet weak var blinkingStarFive: UIImageView!
    @IBOutlet weak var startButton: UIButton!
    
    @IBOutlet weak var currentScore: UILabel!
    @IBOutlet weak var currentTeamName: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var wordLabel: UILabel!
    
    @IBOutlet weak var OkButton: UIButton!
    @IBOutlet weak var SkipButton: UIButton!
    
    var currentTeam: Team!
    var teamList: TeamData!
    var roundTotal: Int!
    var currentWordsInRound: [PlayItem] = []
    var currentRoundScore = 0
    var currentRound: Int = 1
    var secondsForTimer: Int = 4
    var seconds: Int = 10
    var timer = Timer()
    var isTimerRunning = false
    var startOfGamedelegate: StartGameViewControllerDelegate?

    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title:"", style:.plain, target:nil, action:nil)
        
        
        
        let arrayOftimeIntervales = [1.0, 3.0, 5.0, 8.0, 9.0]
        let arrayOfStarsToBlink = [blinkingStartOne, blinkingStarTwo, blinkingStarThree, blinkingStarFour, blinkingStarFive]
        
        for star in arrayOfStarsToBlink {
            star!.alpha = 0.0
            UIView.animate(withDuration: arrayOftimeIntervales.randomElement()!, delay: arrayOftimeIntervales.randomElement()!, options: [.curveLinear, .repeat, .autoreverse], animations: {
                
                star!.alpha = 1.0
                
            }, completion: nil)
            
        }
        
        prepareViewBeforePlay()

        

    }
    @IBAction func OkButtonAction(_ sender: Any) {
        let newElement = PlayItem(word: wordLabel.text!, isCorrect: true)
        
        currentWordsInRound.append(newElement)
        
        //wordLabel.text = Words.randomWord(notIncluding: currentWordsInRound.compactMap{t in t.0})
        wordLabel.text =  Words.randomWord()
        currentRoundScore += 1
        currentScore.text = String(currentRoundScore)
        
    }
    @IBAction func SkipButtonAction(_ sender: Any) {
        let newElement = PlayItem(word: wordLabel.text!, isCorrect: false)
        
        currentWordsInRound.append(newElement)
        //wordLabel.text =  Words.randomWord(notIncluding: currentWordsInRound.compactMap{t in t.0})
        wordLabel.text =  Words.randomWord()
        currentRoundScore -= 1
        currentScore.text = String(currentRoundScore)
    }
    
    @IBAction func startButtonAction(_ sender: Any) {
        playGame()
    }
    @IBAction func endGameButton(_ sender: Any) {
        navigationController?.popToRootViewController(animated: true)
        startOfGamedelegate?.createNewTeams()
    }
    func playGame() {
//        currentTeamName.text = currentTeam.teamName
        runTimer()
        wordLabel.alpha = 1.0
        OkButton.alpha = 1.0
        SkipButton.alpha = 1.0
        startButton.alpha = 0.0
    
        
        wordLabel.text =  Words.randomWord()

        
        //when time ends
//        showResults()

    }
    
    func checkNextTeam() {
        
        let currentTeamIndex = teamList.teams.firstIndex(of: currentTeam)!
        if currentTeam == teamList.teams.last {
            currentRound += 1
            currentTeam = teamList.teams.first
        }
        else {
            currentTeam = teamList.teams[currentTeamIndex + 1]
        }
    }
    
    func prepareViewBeforePlay() {
        wordLabel.alpha = 0.0
        OkButton.alpha = 0.0
        SkipButton.alpha = 0.0
        startButton.alpha = 1.0
        
        currentRoundScore = 0
        currentWordsInRound = []
        seconds = secondsForTimer
        timeLabel.text = timeString(time: TimeInterval(secondsForTimer))
        
        currentScore.text = String(currentRoundScore)
        currentTeamName.text = currentTeam.teamName
        //timer = Timer()
    }
    
//    func showResults() {
//        let currentTeamIndex = teamList.teams.firstIndex(of: currentTeam)!
//        //currentTeam.teamScore += currentRoundScore
//        teamList.teams[currentTeamIndex].teamScore += currentRoundScore
//
//        if currentRound == roundTotal,
//            currentTeam == teamList.teams.last {
//
//            //showl last results page
//            let storyboard = UIStoryboard(name: "Main", bundle: nil)
//            let endOfGameViewController: EndOfGameViewController = storyboard.instantiateViewController(withIdentifier: "EndOfGameViewController") as! EndOfGameViewController
//
//            let teamWithHighestScore = String(teamList.sortedTeams().first!.teamName)
//            endOfGameViewController.teamWinnerName = teamWithHighestScore
//            endOfGameViewController.teamRatings = teamList.sortedTeams()
//            endOfGameViewController.delegate =  self
//            navigationController?.pushViewController(endOfGameViewController, animated: true)
//        }
//        else {
//            //show results
//            let storyboard = UIStoryboard(name: "Main", bundle: nil)
//            let roundResultsViewController: RoundResultViewController = storyboard.instantiateViewController(withIdentifier: "RoundResultViewController") as! RoundResultViewController
//
//            roundResultsViewController.teamRatings = teamList.teams
//            roundResultsViewController.wordResultsInRound = currentWordsInRound
//            roundResultsViewController.scoreForRound = currentRoundScore
//            roundResultsViewController.totalScore = currentTeam.teamScore
//            roundResultsViewController.currentTeamValue = currentTeam.teamName
//            roundResultsViewController.delegate = self
//
//            navigationController?.pushViewController(roundResultsViewController, animated: true)
//        }
//    }
    
    func showResults() {
        let currentTeamIndex = teamList.teams.firstIndex(of: currentTeam)!
        //currentTeam.teamScore += currentRoundScore
        teamList.teams[currentTeamIndex].teamScore += currentRoundScore
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let roundResultsViewController: RoundResultViewController = storyboard.instantiateViewController(withIdentifier: "RoundResultViewController") as! RoundResultViewController
        
        if currentRound == roundTotal,
            currentTeam == teamList.teams.last {
            roundResultsViewController.isEndOfGame = true
            roundResultsViewController.teamRatingsSorted = teamList.sortedTeams()
            roundResultsViewController.buttonName = "Results"
            
            //showl last results page
//            let storyboard = UIStoryboard(name: "Main", bundle: nil)
//            let endOfGameViewController: EndOfGameViewController = storyboard.instantiateViewController(withIdentifier: "EndOfGameViewController") as! EndOfGameViewController
//
//            let teamWithHighestScore = String(teamList.sortedTeams().first!.teamName)
//            endOfGameViewController.teamWinnerName = teamWithHighestScore
//            endOfGameViewController.teamRatings = teamList.sortedTeams()
//            endOfGameViewController.delegate =  self
//            navigationController?.pushViewController(endOfGameViewController, animated: true)
        }
            roundResultsViewController.teamRatings = teamList.teams
            roundResultsViewController.teamList = teamList
            roundResultsViewController.wordResultsInRound = currentWordsInRound
            roundResultsViewController.scoreForRound = currentRoundScore
            roundResultsViewController.totalScore = currentTeam.teamScore
            roundResultsViewController.currentTeamValue = currentTeam.teamName
            roundResultsViewController.delegate = self
            
            navigationController?.pushViewController(roundResultsViewController, animated: true)
    }

    
    func runTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self,   selector: (#selector(self.updateTimer)), userInfo: nil, repeats: true)
    }
    
    @objc func updateTimer() {
        if seconds < 1 {
            timer.invalidate()
            showResults()
            
            //Send alert to indicate "time's up!"
        } else {
            seconds -= 1
            timeLabel.text = timeString(time: TimeInterval(seconds))
        }
        
    }
    
    func timeString(time:TimeInterval) -> String {
    let hours = Int(time) / 3600
    let minutes = Int(time) / 60 % 60
    let seconds = Int(time) % 60
    return String(format:"%02i:%02i:%02i", hours, minutes, seconds)
    }
}

// Delegate
extension StartGameViewController: RoundResultViewControllerDelegate {
    func updateStartGameBaseValues() {
        checkNextTeam()
        prepareViewBeforePlay()
    }
    
    func createNewTeams () {
        startOfGamedelegate?.createNewTeams()
    }
        
}

//extension StartGameViewController: EndOfGameViewControllerDelegate {
//    func createNewTeams() {
//        startOfGamedelegate?.createNewTeams()
//    }
//}

protocol StartGameViewControllerDelegate{
    func createNewTeams()
}
