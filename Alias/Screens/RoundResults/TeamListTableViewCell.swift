//
//  TeamListTableViewCell.swift
//  Alias
//
//  Created by Kapitan Kanapka on 22.06.2020.
//  Copyright © 2020 Crazy Hippo. All rights reserved.
//

import UIKit

class TeamListTableViewCell: UITableViewCell {
    
    var teamNameLabel = UILabel()
    var teamScoreLabel = UILabel()

    var cellConfig: Team? {
        didSet {
            guard let cellConfig = cellConfig else { return }
            
            self.backgroundColor = #colorLiteral(red: 0.8458984628, green: 0.8431453339, blue: 0.9147565038, alpha: 0).withAlphaComponent(0.00)
            setupViewLayouts(with: cellConfig)
            updateViewConstraints()
            
        }
    }

    private func setupViewLayouts(with config: Team) {
        setupTeamNameLabel()
        setupTeamScoretLabel()
    }
    
    private func updateViewConstraints() {
        udpateTeamNameLabelConstraints()
        updateTeamScoreLabel()
    }
}

// MARK: - View Setup

private extension TeamListTableViewCell {
    private func setupTeamNameLabel() {
        teamNameLabel.text = cellConfig?.teamName
        teamNameLabel.backgroundColor = #colorLiteral(red: 0.8458984628, green: 0.8431453339, blue: 0.9147565038, alpha: 0).withAlphaComponent(0.0)
        teamNameLabel.font = UIFont(name: "BradleyHandITCTT-Bold", size: 20.0)
        
        addSubview(teamNameLabel)
    }
    
    private func setupTeamScoretLabel() {
        if let teamScore = cellConfig?.teamScore {
            teamScoreLabel.text = String(teamScore)
        }
        teamScoreLabel.backgroundColor = #colorLiteral(red: 0.8458984628, green: 0.8431453339, blue: 0.9147565038, alpha: 0).withAlphaComponent(0.0)
        teamScoreLabel.font = UIFont(name: "BradleyHandITCTT-Bold", size: 17.0)
        
        addSubview(teamScoreLabel)
    }
}

// MARK: - Constraints

private extension TeamListTableViewCell {
    
    // TODO: update constraints properly in this method
    private func udpateTeamNameLabelConstraints() {
        teamNameLabel.snp.updateConstraints { (make) in
            make.left.equalToSuperview().offset(10)
        }
        
    }
    
    private func updateTeamScoreLabel() {
        teamScoreLabel.snp.updateConstraints { (make) in
            make.right.equalToSuperview().offset(-10)
        }
    }
}

