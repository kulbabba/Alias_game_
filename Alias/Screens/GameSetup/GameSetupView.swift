//
//  MainView.swift
//  Alias
//
//  Created by Kapitan Kanapka on 16.06.2020.
//  Copyright © 2020 hippo. All rights reserved.
//

import UIKit
import SnapKit

class GameSetupView: GameSetupViewInteractable {
    var delegate: GameSetupViewDelegate?
    
    var teamLabel: TitleLabel!
    
    var config: GameSetupViewConfig
    
    var roundLabel: TitleLabel!
    var timeLabel: TitleLabel!
    var roundLabelButton: UIButton!
    var timeLabelButton: UIButton!
    var startButton: NavigateForwardButton!
    let screenSize = UIScreen.main.bounds
    var teamCollecionView: UICollectionView!
    
    required init(with config: GameSetupViewConfig) {
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
        setupTitleLabel()
        setupRoundsButton()
        setupTimeButton()
        setupRoundsValueLabel()
        setupTimeValueLabel()
        setupTeamCollecionView()
        setupStartGameButton()
    }
    
    private func updateViewConstraints() {
        updateTitleLabelConstraints()
        updateRoundsButtonConstraints()
        updateTimeButtonConstraints()
        updateRoundsValueConstraints()
        updateTimeValueConstraints()
        updateTeamCollectionViewConstraints()
        updateStartGameButtonConstraints()
    }
}

// MARK: - View Setup

private extension GameSetupView {
    func setupTitleLabel() {
        teamLabel = TitleLabel()
        teamLabel.text = "Teams:"
        
        addSubview(teamLabel)
    }
    
    func setupBackround() {
       let backGroundView = BackgroundView(frame: screenSize, isMainView: true)
        addSubview(backGroundView)
    }
    
    func setupRoundsButton() {
        roundLabelButton = UIButton()
        roundLabelButton.setTitle("Rounds: ", for: .normal)
        roundLabelButton.setTitleColor(.systemGray2, for: .normal)
        roundLabelButton.backgroundColor = .clear
        roundLabelButton.titleLabel!.font = UIFont(name: "Chalkduster" , size: 26.0)
        roundLabelButton.frame.size = CGSize(width: 152, height: 45)
        roundLabelButton.addTarget(self,
                              action: #selector(roundButtonPressed),
                              for: .touchUpInside)
        addSubview(roundLabelButton)
    }
    
    func setupTimeButton() {
        timeLabelButton = UIButton()
        timeLabelButton.setTitle("Time: ", for: .normal)
        timeLabelButton.setTitleColor(.systemGray2, for: .normal)
        timeLabelButton.backgroundColor = .clear
        timeLabelButton.titleLabel!.font = UIFont(name: "Chalkduster" , size: 26.0)
        timeLabelButton.addTarget(self,
                              action: #selector(timeButtonPressed),
                              for: .touchUpInside)
        
        addSubview(timeLabelButton)
    }
    
    func setupRoundsValueLabel() {
        roundLabel = TitleLabel()
        roundLabel.text = String(config.rounds)
        addSubview(roundLabel)
    }
    
    func setupTimeValueLabel() {
        timeLabel = TitleLabel()
        timeLabel.text = String(config.duration)
        addSubview(timeLabel)
    }
    
    func setupTeamCollecionView() {
        let layout = TeamCollectionFlowLayout()
        
        teamCollecionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        teamCollecionView.register(class: TeamCollectionViewCell.self)
        teamCollecionView.backgroundColor = .clear
        teamCollecionView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.2091449058).withAlphaComponent(0.21)
        teamCollecionView.layer.cornerRadius = 9
        
        teamCollecionView.delegate = self
        teamCollecionView.dataSource = self
        
        addSubview(teamCollecionView)
    }
    
    func setupStartGameButton() {
        startButton = NavigateForwardButton()
        startButton.setTitle("Start Game", for: .normal)
        startButton.addTarget(self,
                              action: #selector(startButtonPressed),
                              for: .touchUpInside)
        
        addSubview(startButton)
    }
}

// MARK: - Constraints

private extension GameSetupView {
    func updateTitleLabelConstraints() {
        let offsetWidth = Screen.width / 20
        let offsetHeight = Screen.width / 8
        teamLabel.snp.updateConstraints { make in
            make.left.equalToSuperview().offset(offsetWidth)
            make.right.equalToSuperview()
            make.top.equalToSuperview().offset(offsetHeight)
        }
    }
    
    func updateRoundsButtonConstraints() {
        let offsetWidth = Screen.width / 25
        roundLabelButton.snp.updateConstraints { make in
            make.top.equalTo(teamCollecionView.snp.bottom).offset(+10)
            make.left.equalToSuperview().offset(offsetWidth)
        }
    }
    
    func updateTimeButtonConstraints() {
        let offsetWidth = Screen.width / 25
        timeLabelButton.snp.updateConstraints { make in
            make.top.equalTo(roundLabelButton.snp.bottom)
            make.left.equalToSuperview().offset(offsetWidth)
        }
    }
    
    func updateRoundsValueConstraints() {
        roundLabel.snp.updateConstraints { make in
            make.left.equalTo(roundLabelButton.snp.right).offset(10)
            make.top.equalTo(teamCollecionView.snp.bottom).offset(+10)
        }
    }
    
    func updateTimeValueConstraints() {
        timeLabel.snp.updateConstraints { make in
           make.left.equalTo(timeLabelButton.snp.right).offset(+10)
           make.top.equalTo(roundLabelButton.snp.bottom)
        }
    }
    
    func updateTeamCollectionViewConstraints() {
        let offsetWidth = Screen.width / 20
        let height = Screen.height / 4
        
        teamCollecionView.snp.updateConstraints { (make) in
            make.centerX.equalToSuperview()
            make.left.equalToSuperview().offset(offsetWidth)
            make.right.equalToSuperview().offset(-offsetWidth)
            make.height.equalTo(height)
            make.top.equalTo(teamLabel.snp.bottom).offset(+10)
        }
        
    }
    func updateStartGameButtonConstraints() {
        let offsetRight = Screen.width / 20
        let offsetBottom = Screen.height / 15
        
        startButton.snp.updateConstraints { make in
            make.width.equalTo(startButton.width)
            make.height.equalTo(startButton.height)
            make.right.equalToSuperview().offset(-offsetRight)
            make.bottom.equalToSuperview().offset(-offsetBottom)
        }
    }
}

// MARK: - Actions

extension GameSetupView {
    @objc func startButtonPressed() {
        delegate?.startGameButtonPressed()
    }
    
    @objc func roundButtonPressed() {
        delegate?.roundsButtonPressed()
    }
    
    @objc func timeButtonPressed() {
        delegate?.timeButtonPressed()
    }
    
}

// MARK: - Public

extension GameSetupView {
    func update(with config: GameSetupViewConfig) {
        // do any UI updates based on values from config
    }
    
    func updateTimeAndRoundsValue(with config: GameSetupViewConfig) {
        self.config = config
        
        timeLabel.text = String(config.duration)
        roundLabel.text = String(config.rounds)
        
  
    }
}

// MARK: - UICollectionViewDataSource

extension GameSetupView: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return config.teams.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       
        let cell: TeamCollectionViewCell = collectionView.dequeueReusableCell(at: indexPath)
        
        cell.cellConfig = config.teams[indexPath.row]
        
        return cell
    }
}

// MARK: - UICollectionViewDelegate

extension GameSetupView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("11")
    }
}



//// MARK: - Diffable Data Source
//
//extension ViewController {
//    func configureDataSource() {
//        dataSource = UICollectionViewDiffableDataSource<Section, Team>(collectionView: teamCollecionView) { (collectionView: UICollectionView, indexPath: IndexPath, team) -> UICollectionViewCell? in
//
//            guard  let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TeamCell.reuseIdentifier, for: indexPath) as? TeamCell else { return nil }
//
//
//            cell.teamNameTextField.text = team.teamName
//            cell.teamNameTextField.tag = indexPath.row
////            cell.teamNameTextField.delegate = self
//            cell.delegate = self
//
////            if (cell.isSelected) {
////                cell.backgroundColor = UIColor.green; // highlight selection
////            }
////            else
////            {
////                 cell.backgroundColor = UIColor.yellow // Default color
////            }
//
//            return cell
//        }
//    }
//
//    func configureSnapshot() {
//        var initialSnapshot = NSDiffableDataSourceSnapshot<Section, Team> ()
//        initialSnapshot.appendSections([.main])
//
//        initialSnapshot.appendItems(teamList.teams, toSection: .main)
//        dataSource.apply(initialSnapshot, animatingDifferences: false)
//    }
//
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        guard let cell = collectionView.cellForItem(at: indexPath) else { return }
//        //guard let indexPath = self.tableView.indexPathForCell(cell)
//        cell.isSelected = true
//        cell.backgroundColor = UIColor.black
//        //indexPath
//       // updateDeleteButtonState()
//
//    }
//
//    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
//        guard let cell = collectionView.cellForItem(at: indexPath) else { return }
//
//        cell.isSelected = false
//        cell.backgroundColor = UIColor.yellow
//       // updateDeleteButtonState()
//    }
//
//
//}




//    init(frame: CGRect, roundLabelValue: String, timeLabelValue: String) {
//        super.init(frame: frame)
//
//        //teamLabel = Title1Label()
//        teamLabel.text = "Teams:"
//        teamLabel.frame.origin.y = 100
//        teamLabel.frame.origin.x = 25
//
//        timeLabel.text = timeLabelValue
//        roundLabel.text = roundLabelValue
//
//        backgroundView.image = UIImage(named: "mavka_02")
//        backgroundView.contentMode = .scaleAspectFill
//        backgroundView.frame = screenSize
//
//        //teamsCollectionView.backgroundColor = UIColor.gray.withAlphaComponent(0.2)
//        //teamsCollectionView.layer.cornerRadius = 9
//
//        roundLabel.frame.origin.y = 600
//        roundLabel.frame.origin.x = 100
//
//        roundLabelTitle.text = "Rounds:"
//        roundLabelTitle.frame.origin.y = 600
//        roundLabelTitle.frame.origin.x = 130
//
//        timeLabel.frame.origin.y = 700
//        timeLabel.frame.origin.x = 100
//
//        timeLabelTitle.text = "Time:"
//        timeLabelTitle.frame.origin.y = 700
//        timeLabelTitle.frame.origin.x = 130
//
//        startButton.setTitle("Start Game", for: [])
//        startButton.frame.origin.y = 800
//        startButton.frame.origin.x = 40
//
//        let backGroundView = BackgroundView(frame: screenSize, isMainView: true)
//
//        self.addSubview(backGroundView)
//        self.addSubview(teamLabel)
//        self.addSubview(startButton)
//        self.addSubview(timeLabel)
//        self.addSubview(roundLabel)
//        self.addSubview(timeLabelTitle)
//        self.addSubview(roundLabelTitle)
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
