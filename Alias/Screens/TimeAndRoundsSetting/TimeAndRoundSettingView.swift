//
//  TimeAndRoundSettingView.swift
//  Alias
//
//  Created by Kapitan Kanapka on 17.06.2020.
//  Copyright © 2020 Crazy Hippo. All rights reserved.
//

import UIKit
import SnapKit

class TimeAndRoundSettingView: TimeAndRoundsSettingViewInteractable {
    var delegate: TimeAndRoundsSettingsViewDelegate?
    
    var titleLabel: TitleLabel!
    var pickerView: UIPickerView!
    
    var config: TimeAndRoundsSettingViewConfig

    var okButton: NavigateForwardButton!
    var cancelButton: NavigateBackwardButton!
    
    let screenSize = UIScreen.main.bounds
    var currentPickerData: [String] = []
    var userPickedValue = 0
    
    required init(with config: TimeAndRoundsSettingViewConfig) {
        self.config = config
        
        super.init(frame: .zero)
        
        currentPickerData = config.pickerDataRange
        userPickedValue = config.originalPickerValue
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
        setupPickerView()
        setupOkButton()
        setupCancelButton()
    }
    
    private func updateViewConstraints() {
        updateTitleLabelConstraints()
        updatePickerViewConstraints()
        updateOkButtonConstraints()
        updateCancelButtonConstraints()
    }
}

// MARK: - View Setup

private extension TimeAndRoundSettingView {
    func setupTitleLabel() {
        titleLabel = TitleLabel()
        titleLabel.text = config.isTimeSettings ? "Time" : "Rounds"
        titleLabel.textAlignment = .center
        
        addSubview(titleLabel)
    }
    
    func setupBackround() {
       let backGroundView = BackgroundView(frame: screenSize, isMainView: false)
        addSubview(backGroundView)
    }

    func setupPickerView() {
        pickerView = UIPickerView()
//        if let indexForDefaultTime = currentPickerData.firstIndex(of: String(config.originalPickerValue)) {
//                    pickerView.selectRow(indexForDefaultTime, inComponent: 0, animated:true)
//        }
        let indexForDefaultTime = currentPickerData.firstIndex(of: String(config.originalPickerValue)) ?? 0
        
        pickerView.delegate = self
        pickerView.dataSource = self
        
        addSubview(pickerView)
        
        pickerView.selectRow(indexForDefaultTime, inComponent: 0, animated: true)
    }
    
    func setupOkButton() {
        okButton = NavigateForwardButton()
           okButton.setTitle("Ok", for: .normal)
           okButton.addTarget(self,
                                 action: #selector(okButtonPressed),
                                 for: .touchUpInside)
           
           addSubview(okButton)
    }
    
    func setupCancelButton() {
        cancelButton = NavigateBackwardButton()
        cancelButton.setTitle("Cancel", for: .normal)
        cancelButton.addTarget(self,
                              action: #selector(cancelButtonPressed),
                              for: .touchUpInside)
        
        addSubview(cancelButton)
    }
    
}

// MARK: - Constraints

private extension TimeAndRoundSettingView {
    func updateTitleLabelConstraints() {
        let offsetHeight = Screen.width / 4
        titleLabel.snp.updateConstraints { make in
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.top.equalToSuperview().offset(+offsetHeight)
        }


    }
    
    func updatePickerViewConstraints() {
        pickerView.snp.updateConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(+20)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
        }
    }
    
    func updateOkButtonConstraints() {
        let offsetRight = Screen.width / 20
        let offsetBottom = Screen.height / 15
        
        okButton.snp.updateConstraints { make in
            make.width.equalTo(okButton.width)
            make.height.equalTo(okButton.height)
            make.right.equalToSuperview().offset(-offsetRight)
            make.bottom.equalToSuperview().offset(-offsetBottom)
        }
    }
    
    func updateCancelButtonConstraints() {
        let offsetLeft = Screen.width / 20
        let offsetBottom = Screen.height / 15
        
        cancelButton.snp.updateConstraints { make in
            make.width.equalTo(okButton.width)
            make.height.equalTo(okButton.height)
            make.left.equalToSuperview().offset(offsetLeft)
            make.bottom.equalToSuperview().offset(-offsetBottom)
        }
    }
}

// MARK: - Public

extension TimeAndRoundSettingView {
    func update(with config: TimeAndRoundsSettingViewConfig) {
        // do any UI updates based on values from config
    }
}

// MARK: - Actions

extension TimeAndRoundSettingView {
    @objc func okButtonPressed() {
        delegate?.okButtonPressed(userPickedValue: userPickedValue)
    }
    
    @objc func cancelButtonPressed() {
        delegate?.cancelButtonPressed()
    }

}

// MARK: - UICollectionViewDataSource  - UICollectionViewDelegate

extension TimeAndRoundSettingView: UIPickerViewDataSource, UIPickerViewDelegate {


    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return currentPickerData.count
    }
//
//    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
////        if let pickerValue = currentPickerData[row] {
////            let attributedString = NSAttributedString(string: "some string", attributes: [NSForegroundColorAttributeName : UIColor.systemGray2])
////            return currentPickerData[row]
////        }
//        let pickerValue = currentPickerData[row]
//        let attributedString = NSAttributedString(string: pickerValue, attributes: [NSAttributedString.Key.foregroundColor : UIColor.systemGray2])
//        return attributedString
//    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {

       let pickerValue = currentPickerData[row]
        let attributedString = NSAttributedString(string: pickerValue, attributes: [NSAttributedString.Key.foregroundColor : UIColor.systemGray2])
        return attributedString
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if let pickedValue = Int(currentPickerData[row]) {
            userPickedValue = pickedValue
        }
    }
}


