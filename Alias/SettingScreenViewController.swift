//
//  SettingScreenViewController.swift
//  Alias
//
//  Created by Kapitan Kanapka on 13.06.2020.
//  Copyright © 2020 hippo. All rights reserved.
//

import UIKit
 
class SettingScreenViewController: UIViewController {
    
    @IBOutlet weak var labelNameOutlet: UILabel!
    @IBOutlet weak var pickerView: UIPickerView!
    
    var labelName = "Time:"
    var defaultIndexForPicker = 0
    var pickerData: [String] = []
    var userPickedValie = 0
    var isTimePicker = true
    var settingScreenViewControllerDelegate: SettingScreenViewControllerDelegate?
    
    override func viewDidLoad() {
        pickerView.setValue(UIColor.white, forKeyPath: "textColor")
        
        self.pickerView.delegate = self
        self.pickerView.dataSource = self
        
        labelNameOutlet.text = labelName
        pickerView.selectRow(defaultIndexForPicker, inComponent: 0, animated:true)
    }
    
    
    @IBAction func okButtonAction(_ sender: Any) {
        settingScreenViewControllerDelegate?.updateValueAccordingToPicker(pickedValue: userPickedValie, isTimePicker: isTimePicker)
        navigationController?.popViewController(animated: true)
        
    }
    @IBAction func cancelButtonAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
}

// MARK: - UIPickerViewDelegate

extension SettingScreenViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    // The data to return fopr the row and component (column) that's being passed in
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
                    if let pickedValue = Int(pickerData[row]) {
                        userPickedValie = pickedValue
                    }
    }

}

protocol SettingScreenViewControllerDelegate {
    func updateValueAccordingToPicker(pickedValue: Int, isTimePicker: Bool)
}
