//
//  EndResultsView.swift
//  Alias
//
//  Created by Kapitan Kanapka on 17.06.2020.
//  Copyright © 2020 Crazy Hippo. All rights reserved.
//

import UIKit
import SnapKit

class EndResultsView: EndResultsViewInteractable {
    var delegate: EndResultsViewDelegate?
    
    var winnerLabel: TitleLabel!
    
    var config: EndResultsViewConfig
    
    var winnerList: UITableView!
    var winnerValueLabel: UILabel!
    var newGameButton: NavigateForwardButton!
    let screenSize = UIScreen.main.bounds
    var teamListTableView: UITableView!
    var winnerLabelText = "Winner:"
    
    required init(with config: EndResultsViewConfig) {
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
        switch config.gameResult {
        case .allWinners:
            setupWinnerValueLabel(winnerName: "A l l  T E A M S !")
        case .multipleWinners:
            winnerLabelText = "Winners:"
            setupWinnersListLabel()
        case .oneWinner:
            setupWinnerValueLabel(winnerName: config.winnerList.first!.teamName)
        }
        setupWinnerLabel()

        setupTeamsTableView()
        setupStartNewGameButton()
    }
    
    private func updateViewConstraints() {
        updateWinnerLabelConstraints()
        updateWinnerValueConstraints()
        updateTeamsTableViewConstraints()
        updateStartNewGameButtonConstraints()
    }
}

// MARK: - View Setup

private extension EndResultsView {
    
    func setupBackround() {
       let backGroundView = BackgroundView(frame: screenSize, isMainView: false)
        addSubview(backGroundView)
    }
    
    func setupWinnerLabel() {
        winnerLabel = TitleLabel()
        winnerLabel.text = winnerLabelText
        winnerLabel.textAlignment = .center
        
        addSubview(winnerLabel)
    }
    
    func setupWinnerValueLabel(winnerName: String) {
        winnerValueLabel = UILabel()
        winnerValueLabel.text = winnerName
        winnerValueLabel.textAlignment = .center
        winnerValueLabel.textColor = #colorLiteral(red: 0.2021885702, green: 0.6823529412, blue: 0.6980392157, alpha: 1)
        winnerValueLabel.font = UIFont(name: "BradleyHandITCTT-Bold", size: 30.0)
        
        addSubview(winnerValueLabel)
    }
    
    func setupWinnersListLabel() {
        winnerList = UITableView(frame: .zero)
        winnerList.register(class: WinnerListTableViewCell .self)
        winnerList.backgroundColor = .clear
        winnerList.backgroundColor = #colorLiteral(red: 0.9287510514, green: 0.9287510514, blue: 0.9287510514, alpha: 0.09546232877).withAlphaComponent(0.15)
        winnerList.layer.cornerRadius = 9
        
        winnerList.delegate = self
        winnerList.dataSource = self
        
        addSubview(winnerList)
    }
    
    func setupTeamsTableView() {
        teamListTableView = UITableView(frame: .zero)
        teamListTableView.register(class: TeamListEndResultsCell .self)
        teamListTableView.backgroundColor = .clear
        teamListTableView.backgroundColor = #colorLiteral(red: 0.9287510514, green: 0.9287510514, blue: 0.9287510514, alpha: 0.09546232877).withAlphaComponent(0.15)
        teamListTableView.layer.cornerRadius = 9
        
        teamListTableView.delegate = self
        teamListTableView.dataSource = self
        
        addSubview(teamListTableView)
    }
    
    func setupStartNewGameButton() {
        newGameButton = NavigateForwardButton()
        newGameButton.setTitle("New Game", for: .normal)
        newGameButton.addTarget(self,
                                 action: #selector(startNewGameButtonPressed),
                                 for: .touchUpInside)
        
        addSubview(newGameButton)
    }
}

// MARK: - Constraints

private extension EndResultsView {
    func updateWinnerLabelConstraints() {
        let offsetHeight = Screen.height / 9
        winnerLabel.snp.updateConstraints { make in
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.top.equalToSuperview().offset(offsetHeight)
        }
    }
    
    func updateWinnerValueConstraints() {
        winnerValueLabel.snp.updateConstraints { make in
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.top.equalTo(winnerLabel.snp.bottom).offset(+20)
        }
    }
    
    func updateWinnerValueListConstraints() {
        winnerList.snp.updateConstraints { make in
            make.top.equalTo(winnerLabel.snp.bottom).offset(+20)
        }
    }
    
    func updateTeamsTableViewConstraints() {
        let offsetWidth = Screen.width / 9
        let height = Screen.height / 5
        
        teamListTableView.snp.updateConstraints { make in
            make.centerY.equalToSuperview().offset(+30)
            make.centerX.equalToSuperview()
            make.left.equalToSuperview().offset(offsetWidth)
            make.right.equalToSuperview().offset(-offsetWidth)
            make.height.equalTo(height)
        }
        
    }
    func updateStartNewGameButtonConstraints() {
        let offsetRight = Screen.width / 20
        let offsetBottom = Screen.height / 15
        
        newGameButton.snp.updateConstraints { make in
            make.width.equalTo(newGameButton.width)
            make.height.equalTo(newGameButton.height)
            make.right.equalToSuperview().offset(-offsetRight)
            make.bottom.equalToSuperview().offset(-offsetBottom)
        }
    }
    func updateTimeValueConstraints() {
        let offsetRight = Screen.width / 20
        let offsetBottom = Screen.height / 15
        
        newGameButton.snp.updateConstraints { make in
            make.width.equalTo(newGameButton.width)
            make.height.equalTo(newGameButton.height)
            make.right.equalToSuperview().offset(-offsetRight)
            make.bottom.equalToSuperview().offset(-offsetBottom)
        }
    }
}

// MARK: - Public

extension EndResultsView {
    func update(with config: EndResultsViewConfig) {
        // do any UI updates based on values from config
    }
}


// MARK: - Actions

extension EndResultsView {
    @objc func startNewGameButtonPressed() {
        delegate?.startNewGameButtonPressed()
    }

}

// MARK: - UICollectionViewDataSource

extension EndResultsView: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
           if tableView == winnerList {
            return config.winnerList.count
           } else {
            return config.teamList.count
           }
       }
       
       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           if tableView == winnerList {
               return winnerListTableView(tableView, cellForRowAt: indexPath)
           } else {
               return teamListTableView(tableView, cellForRowAt: indexPath)
           }
       }
       
    private func winnerListTableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: WinnerListTableViewCell = tableView.dequeueReusableCell(at: indexPath)
        cell.cellConfig = config.winnerList[indexPath.row]
        return cell
    }
       
       private func teamListTableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           
           let cell: TeamListEndResultsCell = tableView.dequeueReusableCell(at: indexPath)
        cell.cellConfig = config.teamList[indexPath.row]
        
           return cell
       }

    
}
