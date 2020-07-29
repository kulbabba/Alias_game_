//
//  RoundResultsView.swift
//  Alias
//
//  Created by Kapitan Kanapka on 17.06.2020.
//  Copyright © 2020 Crazy Hippo. All rights reserved.
//

import UIKit
import SnapKit

class RoundResultsView: RoundResultsViewInteractable {
    var delegate: RoundResultsViewDelegate?
    
    var config: RoundResultsViewConfig
    
    var teamNameLabel: UILabel!
    var scoreLabel: TitleLabel!
    var scoreValueLabel: UILabel!
    var generalResultsLabel: TitleLabel!
    var nextTeamButton: NavigateForwardButton!
    var endGameButton: NavigateBackwardButton!
    let screenSize = UIScreen.main.bounds
    var wordsTableView: UITableView!
    var teamTableView: UITableView!
    
    required init(with config: RoundResultsViewConfig) {
        self.config = config
        
        super.init(frame: .zero)
        
        setupViewLayouts()
        updateViewConstraints()
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViewLayouts() {
        setupBackround()
        setupTeamNameLabel()
        setupScoreLabel()
        setupScoreValueLabel()
        setupWordsTableView()
        setupGeneralResultsLabel()
        setupTeamsTableView()
        setupNextTeamButton()
        setupEndGameButton()
    }
    
    private func updateViewConstraints() {
        updateTeamNameLabelConstraints()
        updateScoreLabelConstraints()
        updateScoreValueConstraints()
        updateWordsTableViewConstraints()
        updateGeneralResultsLabelConstraints()
        updateTeamsTableViewConstraints()
        updateNextTeamButtonConstraints()
        updateEndGameButtonConstraints()
    }
}

// MARK: - View Setup

private extension RoundResultsView {
    
    func setupBackround() {
       let backGroundView = BackgroundView(frame: screenSize, isMainView: false)
        addSubview(backGroundView)
    }
    
    func setupTeamNameLabel() {
        teamNameLabel = UILabel()
        teamNameLabel.font = UIFont(name: "BradleyHandITCTT-Bold", size: 26.0)
        teamNameLabel.textAlignment = .center
        teamNameLabel.text = config.curentTeam.teamName
        teamNameLabel.textColor = #colorLiteral(red: 0.2021885702, green: 0.6823529412, blue: 0.6980392157, alpha: 1)
        
        addSubview(teamNameLabel)
    }
    
    func setupScoreLabel() {
        scoreLabel = TitleLabel()
        scoreLabel.text = "Score:"
        addSubview(scoreLabel)
    }
    
    func setupScoreValueLabel() {
        scoreValueLabel = UILabel()
        scoreValueLabel.font = UIFont(name: "Chalkduster", size: 31.0)
        scoreValueLabel.text = String(config.curentTeam.teamScore)
        scoreValueLabel.textColor = #colorLiteral(red: 0.9279029188, green: 0.1136427593, blue: 0.2197436802, alpha: 0.8676155822).withAlphaComponent(0.87)
        
         addSubview(scoreValueLabel)

    }
    func setupWordsTableView() {
        wordsTableView = UITableView(frame: .zero)
        wordsTableView.register(class: WordItemsTableViewCell.self)
        wordsTableView.backgroundColor = .clear
        wordsTableView.backgroundColor = #colorLiteral(red: 0.9287510514, green: 0.9287510514, blue: 0.9287510514, alpha: 0.09546232877).withAlphaComponent(0.15)
        wordsTableView.layer.cornerRadius = 9
        
        wordsTableView.delegate = self
        wordsTableView.dataSource = self
        
        addSubview(wordsTableView)
 
    }
    
    func setupGeneralResultsLabel() {
        generalResultsLabel = TitleLabel()
        generalResultsLabel.text = "General Results:"
        generalResultsLabel.font = UIFont(name: "Chalkduster", size: 18.0)
        
        addSubview(generalResultsLabel)
    }
    
    func setupTeamsTableView() {
        
        //let layout = TeamCollectionFlowLayout()
         
         teamTableView = UITableView(frame: .zero)
         teamTableView.register(class: TeamListTableViewCell .self)
         teamTableView.backgroundColor = .clear
         teamTableView.backgroundColor = #colorLiteral(red: 0.9287510514, green: 0.9287510514, blue: 0.9287510514, alpha: 0.09546232877).withAlphaComponent(0.15)
         teamTableView.layer.cornerRadius = 9
         
         teamTableView.delegate = self
         teamTableView.dataSource = self
         
         addSubview(teamTableView)
 
    }
    
    func setupNextTeamButton() {
        nextTeamButton = NavigateForwardButton()
        let buttonTitle = config.isLastRound ? "Results" : "Next Team"
        nextTeamButton.setTitle(buttonTitle, for: .normal)
        nextTeamButton.addTarget(self,
                              action: #selector(startNextTeamButtonPressed),
                              for: .touchUpInside)
        
        addSubview(nextTeamButton)

    }
    
    func setupEndGameButton() {
        endGameButton = NavigateBackwardButton()
        endGameButton.setTitle("EndGame", for: .normal)
        endGameButton.addTarget(self,
                              action: #selector(endGamePressed),
                              for: .touchUpInside)
        
        addSubview(endGameButton)

    }
}

// MARK: - Constraints

private extension RoundResultsView {
    
    func updateTeamNameLabelConstraints() {
        let height = Screen.height / 10
        teamNameLabel.snp.updateConstraints { make in
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.top.equalToSuperview().offset(height)
        }
    }
    
    func updateScoreLabelConstraints() {
        scoreLabel.snp.updateConstraints { make in
            make.top.equalTo(teamNameLabel.snp.bottom).offset(+20)
            make.left.equalToSuperview().offset(+20)
        }
    }
    
    func updateScoreValueConstraints() {
        scoreValueLabel.snp.updateConstraints { make in
            make.top.equalTo(teamNameLabel.snp.bottom).offset(+20)
            make.left.equalTo(scoreLabel.snp.right).offset(+10)
        }
    }
    
    func updateWordsTableViewConstraints() {
        let offsetWidth = Screen.width / 9
        let height = Screen.height / 4
        
        wordsTableView.snp.updateConstraints { (make) in
            make.centerX.equalToSuperview()
            make.left.equalToSuperview().offset(offsetWidth)
            make.right.equalToSuperview().offset(-offsetWidth)
            make.height.equalTo(height)
            make.top.equalTo(scoreLabel.snp.bottom).offset(+25)
        }
    }
    
    func updateGeneralResultsLabelConstraints() {
        generalResultsLabel.snp.updateConstraints { make in
            make.top.equalTo(wordsTableView.snp.bottom).offset(+35)
            make.left.equalToSuperview().offset(+20)
        }
    }
    
    func updateTeamsTableViewConstraints() {
        let offsetWidth = Screen.width / 9
        let height = Screen.height / 6
        
        teamTableView.snp.updateConstraints { (make) in
            make.centerX.equalToSuperview()
            make.left.equalToSuperview().offset(offsetWidth)
            make.right.equalToSuperview().offset(-offsetWidth)
            make.height.equalTo(height)
            make.top.equalTo(generalResultsLabel.snp.bottom).offset(+10)
        }
    }
    
    func updateNextTeamButtonConstraints() {
        
        let offsetRight = Screen.width / 20
        let offsetBottom = Screen.height / 15
        
        nextTeamButton.snp.updateConstraints { make in
            make.width.equalTo(nextTeamButton.width)
            make.height.equalTo(nextTeamButton.height)
            make.right.equalToSuperview().offset(-offsetRight)
            make.bottom.equalToSuperview().offset(-offsetBottom)
        }
    }
    
    func updateEndGameButtonConstraints() {
        let offsetLeft = Screen.width / 20
        let offsetBottom = Screen.height / 15
        
        endGameButton.snp.updateConstraints { make in
            make.width.equalTo(nextTeamButton.width)
            make.height.equalTo(nextTeamButton.height)
            make.left.equalToSuperview().offset(offsetLeft)
            make.bottom.equalToSuperview().offset(-offsetBottom)
        }
    }
}

// MARK: - Public

extension RoundResultsView {
    func update(with config: RoundResultsViewConfig) {
        // do any UI updates based on values from config
    }
}


// MARK: - Actions

extension RoundResultsView {
    @objc func startNextTeamButtonPressed() {
        delegate?.startNextTeamButtonPressed()
    }
    
    @objc func endGamePressed() {
        delegate?.endGamePressed()
    }

}


// MARK: - UICollectionViewDataSource

extension RoundResultsView: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
           if tableView == wordsTableView {
            return config.wordList.count
           } else {
            return config.teamList.teams.count
           }
       }
       
       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           if tableView == wordsTableView {
               return wordListTableView(tableView, cellForRowAt: indexPath)
           } else {
               return teamListTableView(tableView, cellForRowAt: indexPath)
           }
       }
       
    private func wordListTableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: WordItemsTableViewCell = tableView.dequeueReusableCell(at: indexPath)
        cell.cellConfig = config.wordList[indexPath.row]
        return cell
    }
       
       private func teamListTableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           
           let cell: TeamListTableViewCell = tableView.dequeueReusableCell(at: indexPath)
        cell.cellConfig = config.teamList.teams[indexPath.row]
        
           return cell
       }
}
