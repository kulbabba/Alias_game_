//
//  StartGameView.swift
//  Alias
//
//  Created by Kapitan Kanapka on 17.06.2020.
//  Copyright © 2020 Crazy Hippo. All rights reserved.
//

import UIKit
import SnapKit



class PlayGameView: PlayGameViewInteractable {
    var delegate: PlayGameViewDelegate?
    
    var config: PlayGameViewConfig
    var teamLabel: TitleLabel!
    var teamNameLabel: TitleLabel!
    var scoreLabel: TitleLabel!
    var scoreValueLabel: TitleLabel!
    var timerLabel: TitleLabel!
    var wordLabel: UILabel!
    var startButton: NavigateForwardButton!
    var endGameButton: NavigateBackwardButton!
    var okButton: OkSkipButton!
    var skipButton: OkSkipButton!
    let screenSize = UIScreen.main.bounds
    
    var currentWordsInRound: [PlayItem] = []
    var currentRound: Int = 1
    var seconds: Int = 0
    var timer = Timer()
    var isTimerRunning = false
    
    required init(with config: PlayGameViewConfig) {
        self.config = config
        
        super.init(frame: .zero)
        
        setupViewLayouts()
        updateViewConstraints()
        toggleVisibilityOfWordLabelWithOkSkipButton(makeVisible: false)
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViewLayouts() {
        setupBackround()
        setupTitleLabel()
        setupTeamNameLabel()
        setupScoreLabel()
        setupScoreValueLabel()
        setupTimerLabel()
        setupWordLabel()
        setupOkButton()
        setupSkipButton()
        setupStartGameButton()
        setupEndGameButton()
    }
    
    private func updateViewConstraints() {
        self.updateTitleLabelConstraints()
        self.updateConstraintsTeamNameLabel()
        updateConstraintsScoreLabel()
        updateConstraintsScoreValueLabel()
        updateConstraintsTimerLabel()
        updateConstraintsWordLabel()
        updateConstraintsOkButton()
        updateConstraintsSkipButton()
        updateConstraintsStartGameButton()
        updateConstraintsEndGameButton()
    }
}

// MARK: - View Setup

private extension PlayGameView {
    func setupBackround() {
        let backGroundView = BackgroundView(frame: screenSize, isMainView: false)
        addSubview(backGroundView)
    }
    
    func setupTitleLabel() {
        teamLabel = TitleLabel()
        teamLabel.font = UIFont(name: "Chalkduster", size: 26)
        teamLabel.text = "Team:"
        
        addSubview(teamLabel)
    }
    
    func setupTeamNameLabel() {
        teamNameLabel = TitleLabel()
        teamNameLabel.text = config.currentTeam.teamName
        teamNameLabel.font = UIFont(name: "BradleyHandITCTT-Bold", size: 26.0)
        teamNameLabel.textColor = #colorLiteral(red: 0.2021885702, green: 0.6823529412, blue: 0.6980392157, alpha: 1)
        
        addSubview(teamNameLabel)
    }
    
    func setupScoreLabel() {
        scoreLabel = TitleLabel()
        scoreLabel.font = UIFont(name: "Chalkduster", size: 26)
        scoreLabel.text = "Score:"
        
        addSubview(scoreLabel)
    }
    
    func setupScoreValueLabel() {
        scoreValueLabel = TitleLabel()
        scoreValueLabel.text = String(0)
        scoreValueLabel.font = UIFont(name: "BradleyHandITCTT-Bold", size: 26.0)
        scoreValueLabel.textColor = #colorLiteral(red: 0.2021885702, green: 0.6823529412, blue: 0.6980392157, alpha: 1)
        
        addSubview(scoreValueLabel)
    }
    func setupTimerLabel() {
        timerLabel = TitleLabel()
        timerLabel.text = timeString(time: TimeInterval(config.duration))
        timerLabel.textAlignment = .center
        
        addSubview(timerLabel)
    }
    
    func setupWordLabel() {
        wordLabel = UILabel()
        wordLabel.text = Words.randomWord()
        wordLabel.textAlignment = .center
        wordLabel.font = UIFont(name: "BradleyHandITCTT-Bold", size: 30.0)
        wordLabel.backgroundColor = #colorLiteral(red: 0.7935841182, green: 0.7628424658, blue: 0.6980392157, alpha: 0.5687607021).withAlphaComponent(0.57)
        
        addSubview(wordLabel)
    }
    
    func setupOkButton() {
        okButton = OkSkipButton(isOkButton: true)
        okButton.addTarget(self,
                              action: #selector(okButtonPressed),
                              for: .touchUpInside)
        
        addSubview(okButton)
    }
    func setupSkipButton() {
        skipButton = OkSkipButton(isOkButton: false)
        skipButton.addTarget(self,
                              action: #selector(skipButtonPressed),
                              for: .touchUpInside)
        
        addSubview(skipButton)
    }
    func setupStartGameButton() {
        startButton = NavigateForwardButton()
        startButton.setTitle("Play", for: .normal)
        startButton.addTarget(self,
                              action: #selector(startGameButtonPressed),
                              for: .touchUpInside)
        
        addSubview(startButton)
    }
    
    func setupEndGameButton() {
        endGameButton = NavigateBackwardButton()
        endGameButton.setTitle("EndGame", for: .normal)
        endGameButton.addTarget(self,
                              action: #selector(endGameButtonPressed),
                              for: .touchUpInside)
        
        addSubview(endGameButton)
    }
}

// MARK: - Constraints

private extension PlayGameView {
    func updateTitleLabelConstraints() {
        let offsetHeight = Screen.height / 9
        let offsetWidth = Screen.width / 20
        teamLabel.snp.updateConstraints { make in
            make.left.equalToSuperview().offset(offsetWidth)
            make.top.equalToSuperview().offset(offsetHeight)
        }
    }
    func updateConstraintsTeamNameLabel() {
        let offsetHeight = Screen.height / 9
        teamNameLabel.snp.updateConstraints { make in
            make.left.equalTo(teamLabel.snp.right).offset(+10)
            make.top.equalToSuperview().offset(offsetHeight)
        }
    }
    func updateConstraintsScoreLabel() {
        let offsetWidth = Screen.width / 20
        scoreLabel.snp.updateConstraints { make in
            make.left.equalToSuperview().offset(offsetWidth)
            make.top.equalTo(teamLabel.snp.bottom).offset(+10)
        }
    }
    func updateConstraintsScoreValueLabel() {
        scoreValueLabel.snp.updateConstraints { make in
            make.left.equalTo(scoreLabel.snp.right).offset(+10)
            make.top.equalTo(teamLabel.snp.bottom).offset(+15)
        }
    }
    func updateConstraintsTimerLabel() {
        timerLabel.snp.updateConstraints {make in
            make.right.equalToSuperview()
            make.left.equalToSuperview()
            make.top.equalTo(scoreLabel.snp.bottom).offset(+20)
            
        }
    }
    
    func updateConstraintsWordLabel() {
        let offsetWidth = Screen.width / 20
        let height = Screen.height / 8
        wordLabel.snp.updateConstraints { make in
            make.top.equalTo(timerLabel.snp.bottom).offset(+10)
            make.left.equalToSuperview().offset(offsetWidth)
            make.right.equalToSuperview().offset(-offsetWidth)
            make.height.equalTo(height)
        }
    }
    
    func updateConstraintsOkButton() {
        okButton.snp.updateConstraints { make in
            make.top.equalTo(wordLabel.snp.bottom).offset(+40)
            make.right.equalTo(wordLabel.snp.right).offset(-20)
            make.width.equalTo(okButton.width)
            make.height.equalTo(startButton.height)
        }
    }
    
    func updateConstraintsSkipButton() {
        skipButton.snp.updateConstraints { make in
            make.top.equalTo(wordLabel.snp.bottom).offset(+40)
            make.left.equalTo(wordLabel.snp.left).offset(+20)
            make.width.equalTo(skipButton.width)
            make.height.equalTo(skipButton.height)
        }
    }
    
    func updateConstraintsStartGameButton() {
        let offsetRight = Screen.width / 20
        let offsetBottom = Screen.height / 15
        
        startButton.snp.updateConstraints { make in
            make.width.equalTo(startButton.width)
            make.height.equalTo(startButton.height)
            make.right.equalToSuperview().offset(-offsetRight)
            make.bottom.equalToSuperview().offset(-offsetBottom)
        }
    }
    
    func updateConstraintsEndGameButton() {
        let offsetLeft = Screen.width / 20
        let offsetBottom = Screen.height / 15
        
        endGameButton.snp.updateConstraints { make in
            make.width.equalTo(startButton.width)
            make.height.equalTo(startButton.height)
            make.left.equalToSuperview().offset(offsetLeft)
            make.bottom.equalToSuperview().offset(-offsetBottom)
        }
    }
}

// MARK: - Public

extension PlayGameView {
    func update(with config: PlayGameViewConfig) {
        // do any UI updates based on values from config
    }
    
    func toggleVisibilityOfWordLabelWithOkSkipButton(makeVisible: Bool) {
        if makeVisible {
            wordLabel.alpha = 1.0
            okButton.alpha = 1.0
            skipButton.alpha = 1.0
            startButton.alpha = 0.0
        }
        else {
            wordLabel.alpha = 0.0
            okButton.alpha = 0.0
            skipButton.alpha = 0.0
            startButton.alpha = 1.0
        }
        
    }
    
    func timeString(time:TimeInterval) -> String {
    let hours = Int(time) / 3600
    let minutes = Int(time) / 60 % 60
    let seconds = Int(time) % 60
    return String(format:"%02i:%02i:%02i", hours, minutes, seconds)
    }
    
    func updatetimerLabel(seconds: Int) {
        timerLabel.text = timeString(time: TimeInterval(seconds))
    }
    
    func updateScoreLabelValue(score: Int) {
        scoreValueLabel.text = String(score)
    }
    
    func updateCurrentTeamName(teamName: String) {
        teamNameLabel.text = teamName
    }
    
    func updateGameValuesBeforeGame() {
        toggleVisibilityOfWordLabelWithOkSkipButton(makeVisible: false)
        
        scoreValueLabel.text = String(0)
        wordLabel.text = Words.randomWord()
        updatetimerLabel(seconds: config.duration)
    }
}


// MARK: - Actions

extension PlayGameView {
    @objc func startGameButtonPressed() {
        toggleVisibilityOfWordLabelWithOkSkipButton(makeVisible: true)
        wordLabel.text =  Words.randomWord()
        delegate?.startGameButtonPressed()
    }
    
    @objc func okButtonPressed() {
        let oldWord = wordLabel.text!
        wordLabel.text =  Words.randomWord()
        delegate?.okButtonPressed(word: oldWord)
    }
    
    @objc func skipButtonPressed() {
        let oldWord = wordLabel.text!
        wordLabel.text =  Words.randomWord()
        delegate?.skipPressed(word: oldWord)
    }
    
    @objc func endGameButtonPressed() {
        delegate?.endGame()
    }

}
