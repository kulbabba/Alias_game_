//
//  TeamCell.swift
//  Alias
//
//  Created by Kapitan Kanapka on 04.06.2020.
//  Copyright © 2020 hippo. All rights reserved.
//

import UIKit

class TeamCell: UICollectionViewCell {
    
    @IBOutlet weak var teamNameTextField: UITextField!
    
    var delegate: TeamCellDelegate?
    
    static let reuseIdentifier = String(describing: TeamCell.self)
    
    override func awakeFromNib() {
        super.awakeFromNib()
        teamNameTextField.delegate = self
    }
    @IBAction func textFieldEditingIsDone(_ sender: Any) {
//        if let newValue == teamNameTextField.text {
//
//        }
    }
    
    override var isSelected: Bool {
        didSet {
              //  contentView.backgroundColor = isSelected ? UIColor.systemRed.withAlphaComponent(0.5) : UIColor.systemGroupedBackground
            self.teamNameTextField.backgroundColor = isSelected ? UIColor.systemRed.withAlphaComponent(0.2) : UIColor.systemGray2.withAlphaComponent(0.3)
            delegate?.makeDeleteButtonEnabled(isEnabled: isSelected)
            //self.label.backgroundColor = isSelected ? UIColor.systemRed.withAlphaComponent(0.5) : UIColor.white.withAlphaComponent(0.0)
            }

    }

    
}


// MARK: - UITextFieldDelegate

extension TeamCell: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let oldText = textField.text,
            let stringRange = Range(range, in: oldText) else {
                return false
        }
        let newText = oldText.replacingCharacters(in: stringRange, with: string)
        //self.isSelected = true
       // delegate?.makeCellSelected(in: self)
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
       // self.isSelected = false
        if let newText = textField.text {
            delegate?.updateTeamName(in: self, newName: newText)
        }
        delegate?.makeCellDeselected(in: self)
        //delegate?.toggleCellSelection(in: self)
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        delegate?.makeCellSelected(in: self)
        //delegate?.toggleCellSelection(in: self)
    }
}

protocol TeamCellDelegate {
    func updateTeamName(in cell: TeamCell, newName: String)
    func makeCellSelected(in cell: TeamCell)
    func makeCellDeselected(in cell: TeamCell)
    func toggleCellSelection(in cell: TeamCell)
    func makeDeleteButtonEnabled(isEnabled: Bool)
}
