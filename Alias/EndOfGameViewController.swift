//
//  EndOfGameViewController.swift
//  Alias
//
//  Created by Kapitan Kanapka on 08.06.2020.
//  Copyright © 2020 hippo. All rights reserved.
//

import UIKit

class EndOfGameViewController: UIViewController {
    
    @IBOutlet weak var teamName: UILabel!
    @IBOutlet weak var teamTableView: UITableView!
    @IBOutlet weak var multipleWinnerTableView: UITableView!
    
    @IBOutlet weak var winnerLabelOutlet: UILabel!
    @IBOutlet weak var newStar1: UIImageView!
    @IBOutlet weak var newStar2: UIImageView!
    @IBOutlet weak var newStar3: UIImageView!
    @IBOutlet weak var newStar4: UIImageView!
    
    var teamRatings: [Team] = []
    var multipleWinnerTeams: [Team] = []
    var teamWinnerName = ""
    var winnerLabel = "Winner:"
    var showMultipleTeamsWinners = false
    var delegate: EndOfGameViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title:"", style:.plain, target:nil, action:nil)
        
        teamTableView.dataSource = self
        teamName.text = teamWinnerName
        winnerLabelOutlet.text = winnerLabel
        if showMultipleTeamsWinners {
            multipleWinnerTableView.alpha = 1
            teamName.alpha = 0
        }
        
        let arrayOftimeIntervales = [1.0, 3.0, 5.0, 8.0]
        let arrayOfStarsToBlink = [newStar1, newStar2, newStar3, newStar4]
        
        for star in arrayOfStarsToBlink {
            star!.alpha = 0.0
            UIView.animate(withDuration: arrayOftimeIntervales.randomElement()!, delay: arrayOftimeIntervales.randomElement()!, options: [.curveLinear, .repeat, .autoreverse], animations: {
                
                star!.alpha = 1.0
                
            }, completion: nil)
            
        }
    }
    
    @IBAction func NewGameButton(_ sender: Any) {
        delegate?.createNewTeams()
        navigationController?.popToRootViewController(animated: true)
    }
}


extension EndOfGameViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       var teamsCount = 0
        if tableView == teamTableView{
            teamsCount = teamRatings.count
        }
        if tableView == multipleWinnerTableView {
            teamsCount = multipleWinnerTeams.count
        }
            return teamsCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell: TeamTableViewCell = tableView.dequeueReusableCell(withIdentifier: "TeamTableViewCell", for: indexPath) as! TeamTableViewCell
//
//        cell.teamNameTableViewCell.text = teamRatings[indexPath.row].teamName
//        cell.teamScoreTableViewCell.text = String(teamRatings[indexPath.row].teamScore)
//
//        return cell
        
        
        var cell = UITableViewCell()
        if tableView == teamTableView{
            let teamcell: TeamTableViewCell = tableView.dequeueReusableCell(withIdentifier: "TeamTableViewCell", for: indexPath) as! TeamTableViewCell
            
            teamcell.teamNameTableViewCell.text = teamRatings[indexPath.row].teamName
            teamcell.teamScoreTableViewCell.text = String(teamRatings[indexPath.row].teamScore)
            cell = teamcell
            
        }
        if tableView == multipleWinnerTableView {
            let cell: MultipleWinnerTableViewCell = tableView.dequeueReusableCell(withIdentifier: "MultipleWinnerTableViewCell", for: indexPath) as! MultipleWinnerTableViewCell
            
            cell.multipleWinnerTableViewCellLabel.text = multipleWinnerTeams[indexPath.row].teamName
        }
        return cell
    }

}

protocol EndOfGameViewControllerDelegate {
    func createNewTeams() 
}
