//
//  TeamCollectionViewCell.swift
//  Alias
//
//  Created by Oleg Ivaniv on 17.06.2020.
//  Copyright © 2020 Crazy Hippo. All rights reserved.
//

import UIKit

class TeamCollectionViewCell: UICollectionViewCell {
    
    var teamNameTextField = UITextField()

    var cellConfig: Team? {
        didSet {
            guard let cellConfig = cellConfig else { return }
            setupViewLayouts(with: cellConfig)
            updateViewConstraints()
            
        }
    }

    private func setupViewLayouts(with config: Team) {
        setupTeamNameTextField()
    }
    
    private func updateViewConstraints() {
        udpateTeamNameTextFieldConstraints()
    }
}

// MARK: - View Setup

private extension TeamCollectionViewCell {
    private func setupTeamNameTextField() {
        teamNameTextField.delegate = self
        teamNameTextField.text = cellConfig?.teamName
        teamNameTextField.backgroundColor = #colorLiteral(red: 0.7207298801, green: 0.5995826199, blue: 0.7628424658, alpha: 0.4339950771).withAlphaComponent(0.43)
        teamNameTextField.font = UIFont(name: "BradleyHandITCTT-Bold", size: 17.0)
        teamNameTextField.textAlignment = .center
        teamNameTextField.layer.borderWidth = 2
        teamNameTextField.layer.cornerRadius = 9
        
        addSubview(teamNameTextField)
    }
}

// MARK: - Constraints

private extension TeamCollectionViewCell {
    
    private func udpateTeamNameTextFieldConstraints() {
        teamNameTextField.snp.updateConstraints { (make) in
            make.centerX.equalToSuperview()
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.top.equalToSuperview().offset(10)
            make.bottom.equalToSuperview().offset(-0.1)
        }
        
    }
}

// MARK: - UITextFieldDelegate

extension TeamCollectionViewCell: UITextFieldDelegate {
    // TODO: handle user typing here and pass it to the view via delegate;
    // delegate must be created as well.
}
