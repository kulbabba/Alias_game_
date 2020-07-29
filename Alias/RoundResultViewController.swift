//
//  RoundResultViewController.swift
//  Alias
//
//  Created by Kapitan Kanapka on 08.06.2020.
//  Copyright © 2020 hippo. All rights reserved.
//

import UIKit
import Foundation


class RoundResultViewController: UIViewController {
    
    @IBOutlet weak var currentTeamName: UILabel!
    @IBOutlet weak var totalScoreValue: UILabel!
    @IBOutlet weak var wordsTableView: UITableView!
    @IBOutlet weak var scoreForThisRound: UILabel!
    @IBOutlet weak var teamsTableView: UITableView!
    
    @IBOutlet weak var nextTeamButtonOutlet: UIButton!
    
    var wordResultsInRound: [PlayItem] = []
    var teamRatings: [Team] = []
    var teamList: TeamData = TeamData()
    var teamRatingsSorted: [Team] = []
    var currentTeamValue = ""
    var totalScore = 0
    var scoreForRound = 0
    var isEndOfGame = false
    var delegate: RoundResultViewControllerDelegate?
    var buttonName = "Next Team"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title:"", style:.plain, target:nil, action:nil)
        
        wordsTableView.dataSource = self
        teamsTableView.dataSource = self
        currentTeamName.text = currentTeamValue
        totalScoreValue.text = String(totalScore)
        scoreForThisRound.text = String(scoreForRound)
        nextTeamButtonOutlet.setTitle(buttonName, for: .normal)
    }
    @IBAction func NextTeamButton(_ sender: Any) {
        if isEndOfGame {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let endOfGameViewController: EndOfGameViewController = storyboard.instantiateViewController(withIdentifier: "EndOfGameViewController") as! EndOfGameViewController
            let result = teamList.sumUpResults()
            
            switch result.gameResult {
            case .allWinners:
                endOfGameViewController.teamWinnerName = "A l l  T E A M S !"
                
            case .multipleWinners:
                endOfGameViewController.winnerLabel = "Winners:"
                endOfGameViewController.multipleWinnerTeams = result.team
                
            case .oneWinner:
                let teamWithHighestScore = String(teamRatingsSorted.first!.teamName)
                endOfGameViewController.teamWinnerName = teamWithHighestScore
            }

            endOfGameViewController.teamRatings = teamRatingsSorted
            endOfGameViewController.delegate =  self
            navigationController?.pushViewController(endOfGameViewController, animated: true)
            
        } else {
            
            navigationController?.popViewController(animated: true)
            delegate?.updateStartGameBaseValues()
        }
    }
    
    @IBAction func endGameButton(_ sender: Any) {
        navigationController?.popToRootViewController(animated: true)
        delegate?.createNewTeams()
    }
    

}


extension RoundResultViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == wordsTableView {
            return wordResultsInRound.count
        } else {
            return teamRatings.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == wordsTableView {
            return wordsTableView(tableView, cellForRowAt: indexPath)
        } else {
            return teamsTableView(tableView, cellForRowAt: indexPath)
        }
    }
    
    private func wordsTableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: WordsTableViewCell = tableView.dequeueReusableCell(withIdentifier: "WordsCell", for: indexPath) as! WordsTableViewCell
        
        cell.wordNameValue.text = wordResultsInRound[indexPath.row].word
        cell.wordResultValue.text = wordResultsInRound[indexPath.row].isCorrect ? "+" : "-"
        
        
        return cell
    }
    
    private func teamsTableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: TeamTableViewCell = tableView.dequeueReusableCell(withIdentifier: "TeamTableViewCell", for: indexPath) as! TeamTableViewCell
        
        cell.teamNameTableViewCell.text = teamRatings[indexPath.row].teamName
        cell.teamScoreTableViewCell.text = String(teamRatings[indexPath.row].teamScore)
        
        return cell
    }
}


protocol RoundResultViewControllerDelegate {
    func updateStartGameBaseValues()
    func createNewTeams()
}

extension RoundResultViewController: EndOfGameViewControllerDelegate {
    func createNewTeams() {
        delegate?.createNewTeams()
    }
}
