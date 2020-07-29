//
//  TimeAndRoundsViewController.swift
//  Alias
//
//  Created by Kapitan Kanapka on 17.06.2020.
//  Copyright © 2020 Crazy Hippo. All rights reserved.
//

import UIKit

class TimeAndRoundsSettingViewController: UIViewController {
    var mainView: TimeAndRoundsSettingViewInteractable!
    let viewModel = TimeAndRoundsSettingViewModel()
    var timeAndRoundsViewControllerDelegate: TimeAndRoundsSettingViewControllerDelegate?
    var isTimePicker = true
    var teamList = TeamData()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupMainView()
    }
    
    private func setupMainView() {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
        self.navigationItem.leftItemsSupplementBackButton = false
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title:"", style:.plain, target:nil, action:nil)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title:"", style:.plain, target:nil, action:nil)
        
        let originalPickerValue = isTimePicker ? teamList.secondsForRound : teamList.roundTotal
        let pickerDataRange = isTimePicker ? teamList.timePickerData : teamList.roundsPickerData
        
        let config = TimeAndRoundsSettingViewConfig(
            originalPickerValue: originalPickerValue,
            pickerDataRange: pickerDataRange,
            isTimeSettings: isTimePicker)
        
        mainView = TimeAndRoundSettingView(with: config)
        mainView.delegate = self
        
        mainView.backgroundColor = .red
        
        view.addFullyExtended(mainView)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension TimeAndRoundsSettingViewController: TimeAndRoundsSettingsViewDelegate {
    func okButtonPressed(userPickedValue: Int) {
        if isTimePicker {
            teamList.secondsForRound = userPickedValue
        } else {
            teamList.roundTotal = userPickedValue
        }
        timeAndRoundsViewControllerDelegate?.updateUserPickedValue()
        navigationController?.popViewController(animated: true)
        
    }
    
    func cancelButtonPressed() {
        navigationController?.popViewController(animated: true)
    }
}

protocol TimeAndRoundsSettingViewControllerDelegate {
    func updateUserPickedValue()
}

