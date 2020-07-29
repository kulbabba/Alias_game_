//
//  WordItemsTableViewCell.swift
//  Alias
//
//  Created by Kapitan Kanapka on 22.06.2020.
//  Copyright © 2020 Crazy Hippo. All rights reserved.
//

import UIKit

class WordItemsTableViewCell: UITableViewCell {
    
    var word: UILabel = UILabel()
    var isWordCorrect: UILabel!

    var cellConfig: PlayItem? {
        didSet {
            guard let cellConfig = cellConfig else { return }
            
            self.backgroundColor = #colorLiteral(red: 0.8458984628, green: 0.8431453339, blue: 0.9147565038, alpha: 0).withAlphaComponent(0.00)
            setupViewLayouts(with: cellConfig)
            updateViewConstraints()
            
        }
    }

    private func setupViewLayouts(with config: PlayItem) {
        setupWordLabel()
        setupWordIsCorrectLabel()
    }
    
    private func updateViewConstraints() {
        udpateWordLabelConstraints()
        updateWordIsCorrectConstraints()
    }
}

// MARK: - View Setup

private extension WordItemsTableViewCell {
    private func setupWordLabel() {
        word.text = cellConfig?.word
        word.backgroundColor = #colorLiteral(red: 0.8458984628, green: 0.8431453339, blue: 0.9147565038, alpha: 0).withAlphaComponent(0.01)
        word.font = UIFont(name: "BradleyHandITCTT-Bold", size: 22.0)
        
        //TODO: add this as a regular subview, not fully extended
        addSubview(word)
    }
    
    private func setupWordIsCorrectLabel() {
        isWordCorrect = UILabel()
        isWordCorrect.backgroundColor = #colorLiteral(red: 0.8458984628, green: 0.8431453339, blue: 0.9147565038, alpha: 0).withAlphaComponent(0.01)
        isWordCorrect.font = UIFont(name: "BradleyHandITCTT-Bold", size: 22.0)
        
        if let isCorrect = cellConfig?.isCorrect {
            isWordCorrect.text = isCorrect ? "+" : "-"
        }
       // isWordCorrect.text = cellConfig?.isCorrect ? "+" : "-"
        isWordCorrect.text = "+"
        addSubview(isWordCorrect)
    }
}

// MARK: - Constraints

private extension WordItemsTableViewCell {
    
    // TODO: update constraints properly in this method
    private func udpateWordLabelConstraints() {
        word.snp.updateConstraints { (make) in
            make.left.equalToSuperview().offset(15)
        }
    }
    
    private func updateWordIsCorrectConstraints() {
        isWordCorrect.snp.updateConstraints{(make) in
            make.right.equalToSuperview().offset(-15)
        }
    }
}
