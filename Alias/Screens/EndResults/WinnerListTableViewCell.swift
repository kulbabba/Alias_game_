//
//  WinnerListTableViewCell.swift
//  Alias
//
//  Created by Kapitan Kanapka on 22.06.2020.
//  Copyright © 2020 Crazy Hippo. All rights reserved.
//

import UIKit

class WinnerListTableViewCell: UITableViewCell {
    
    var teamNameLabel = UILabel()

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
    }
    
    private func updateViewConstraints() {
        udpateTeamNameLabelConstraints()
    }
}

// MARK: - View Setup

private extension WinnerListTableViewCell {
    private func setupTeamNameLabel() {
        teamNameLabel.text = cellConfig?.teamName
        teamNameLabel.backgroundColor = #colorLiteral(red: 0.8458984628, green: 0.8431453339, blue: 0.9147565038, alpha: 0).withAlphaComponent(0.0)
        teamNameLabel.font = UIFont(name: "BradleyHandITCTT-Bold", size: 20.0)
        teamNameLabel.textColor = #colorLiteral(red: 0.2021885702, green: 0.6823529412, blue: 0.6980392157, alpha: 1)
        teamNameLabel.textAlignment = .center
        
        addSubview(teamNameLabel)
    }
}

// MARK: - Constraints

private extension WinnerListTableViewCell {
    
    // TODO: update constraints properly in this method
    private func udpateTeamNameLabelConstraints() {
        teamNameLabel.snp.updateConstraints { (make) in
            make.left.equalToSuperview().offset(10)
        }
        
    }
}


