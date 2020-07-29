//
//  ViewController.swift
//  Alias
//
//  Created by Kapitan Kanapka on 04.06.2020.
//  Copyright © 2020 hippo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var blinkingStartOne: UIImageView!
    @IBOutlet weak var blinkingStarTwo: UIImageView!
    @IBOutlet weak var blinkingStarThree: UIImageView!
    @IBOutlet weak var blinkingStarFour: UIImageView!
    @IBOutlet weak var blinkingStarFive: UIImageView!
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var line1: UIImageView!
    @IBOutlet weak var line3: UIImageView!
    @IBOutlet weak var line2: UIImageView!
    @IBOutlet weak var teamCollecionView: UICollectionView!
    
    @IBOutlet weak var deleteTeamButtonOutlet: UIButton!
//    @IBOutlet weak var timePickerView: UIPickerView!
//    @IBOutlet weak var roundsPickerView: UIPickerView!
    var dataSource: UICollectionViewDiffableDataSource<Section, Team>!
    
    @IBOutlet weak var roundTotalValueOutlet: UILabel!
    @IBOutlet weak var timerSecondsLabelOutlet: UILabel!
    
    let screenSize = UIScreen.main.bounds
    var teamList: TeamData
    var timePickerData: [String] = Array(stride(from: 10, to: 310, by: 10)).map{ String($0) }
    var roundsPickerData: [String] = Array(1...10).map{ String($0) }
    var secondsForTimer: Int = 60
    var totalRounds: Int = 8
    
    enum Section{
        case main
    }
    
    required init?(coder aDecoder: NSCoder) {
        teamList = TeamData()
        totalRounds = teamList.roundTotal
        secondsForTimer = teamList.secondsForRound
    
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let config = GameSetupViewConfig(rounds: 1,
//                                         duration: 60)
//        
//        view = GameSetupView(with: config)
        
//        view = MainViewInteractor(frame: screenSize, roundLabelValue: "1", timeLabelValue: "2")
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
        self.navigationItem.leftItemsSupplementBackButton = false
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title:"", style:.plain, target:nil, action:nil)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title:"", style:.plain, target:nil, action:nil)

        
        teamCollecionView.allowsMultipleSelection = true
        roundTotalValueOutlet.text = String(totalRounds)
        timerSecondsLabelOutlet.text = String(secondsForTimer)
        
        

        //pickers:======
        
        //timePickerView.setValue(UIColor.white, forKeyPath: "textColor")
        //self.timePickerView.delegate = self
        //self.timePickerView.dataSource = self
        
        //self.roundsPickerView.delegate = self
        //self.roundsPickerView.dataSource = self
        
        //setDefaultPickerValues()
        //===============================
        
//        let indexForDefaultTime = timePickerData.firstIndex(of: String(secondsForTimer))!
//        let indexForRoundTotal = teamList.roundTotal - 1
//        timePickerView.selectRow(indexForDefaultTime, inComponent: 0, animated:true)
//        roundsPickerView.selectRow(indexForRoundTotal, inComponent: 0, animated:true)

        let arrayOftimeIntervales = [1.0, 2.0, 3.0, 4.0, 5.0]
        let arrayOfStarsToBlink = [blinkingStartOne, blinkingStarTwo, blinkingStarThree, blinkingStarFour, blinkingStarFive]
        
        for star in arrayOfStarsToBlink {
            star!.alpha = 0.0
            UIView.animate(withDuration: arrayOftimeIntervales.randomElement()!, delay: arrayOftimeIntervales.randomElement()!, options: [.curveLinear, .repeat, .autoreverse], animations: {
                
                star!.alpha = 1.0
                
            }, completion: nil)
            
        }
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self,
                                                          action: #selector(self.didTap))
        
        view.addGestureRecognizer(tapGestureRecognizer)

        
        configureDataSource()
        configureSnapshot()
//        configureCollectionViewLayout()
   
        
        
        //        blinkingStartOne.alpha = 0.0
        //        UIView.animate(withDuration: 1.0, delay: 1.0, options: [.curveLinear, .repeat, .autoreverse], animations: {
        //
        //            self.blinkingStartOne.alpha = 1.0
        //
        //        }, completion: nil)
        //
        //        blinkingStarTwo.alpha = 0.0
        //        UIView.animate(withDuration: 1.0, delay: 2.0, options: [.curveLinear, .repeat, .autoreverse], animations: {
        //
        //            self.blinkingStarTwo.alpha = 1.0
        //
        //        }, completion: nil)
        //
        //        blinkingStarThree.alpha = 0.0
        //        UIView.animate(withDuration: 1.0, delay: 3.0, options: [.curveLinear, .repeat, .autoreverse], animations: {
        //
        //            self.blinkingStarThree.alpha = 1.0
        //
        //        }, completion: nil)
        //
        //        blinkingStarFour.alpha = 0.0
        //        UIView.animate(withDuration: 1.0, delay: 4.0, options: [.curveLinear, .repeat, .autoreverse], animations: {
        //
        //            self.blinkingStarFour.alpha = 1.0
        //
        //        }, completion: nil)
        //
        //        blinkingStarFive.alpha = 0.0
        //        UIView.animate(withDuration: 1.0, delay: 5.0, options: [.curveLinear, .repeat, .autoreverse], animations: {
        //
        //            self.blinkingStarFive.alpha = 1.0
        //
        //        }, completion: nil)
        
        //        // Do any additional setup after loading the view.
        //
        //        ///
        //          UIView.animate(
        //              withDuration: 0.33,
        //              delay: 0.0,
        //              usingSpringWithDamping: 0.4,
        //              initialSpringVelocity: 10,
        //              options: .allowUserInteraction,
        //              animations: {
        //
        //              },
        //              completion: nil)
        //
        //
        //              //TODO: Build your first constraint animation!
        //
        //        }
        ///
        //    ///
        //    let iv=UIImageView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        //    imageView.addSubview(iv)
        //
        //    //assign your images to your image view
        //    let myImagesArray=[UIImage(named:"1.png"),UIImage(named:"2.png"),UIImage(named:"3.png")]
        //    iv.animationImages=myImagesArray
        //    iv.animationDuration=1*myImagesArray.count
        //    //to make it loop infinitely
        //    iv.animationRepeatCount=0
        //    iv.startAnimating()
        //    ///
        //        ///
    }
    
    @IBAction func deleteTeamButton(_ sender: Any) {
        
         //guard let selectedIndices = teamCollecionView.indexPathsForSelectedItems else { return }
         //let sectionsToDelete = Set(selectedIndices.map( { $0.section }))
         //let sortedIndexPaths = selectedIndices.sorted(by: {$0.item > $1.item })
        
      //  //teamList.deleteTeam(at: IndexPath(index: cell.tag))
      ///  teamCollecionView.deleteItems(at: [IndexPath(index: cell.tag)])

        deleteTeamButtonOutlet.isEnabled = false

        
    }
    
    @IBAction func timeButton(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let settingScreenViewController: SettingScreenViewController = storyboard.instantiateViewController(withIdentifier: "SettingScreenViewController") as! SettingScreenViewController
        
        let indexForDefaultTime = timePickerData.firstIndex(of: String(secondsForTimer))!

        settingScreenViewController.labelName = "Time:"
        settingScreenViewController.settingScreenViewControllerDelegate =  self
        settingScreenViewController.pickerData = timePickerData
        settingScreenViewController.isTimePicker = true
        settingScreenViewController.defaultIndexForPicker = indexForDefaultTime
        navigationController?.pushViewController(settingScreenViewController, animated: true)
    }
    @IBAction func roundsButton(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let settingScreenViewController: SettingScreenViewController = storyboard.instantiateViewController(withIdentifier: "SettingScreenViewController") as! SettingScreenViewController

        let indexForRoundTotal = teamList.roundTotal - 1
        settingScreenViewController.labelName = "Rounds:"
        settingScreenViewController.settingScreenViewControllerDelegate =  self
        settingScreenViewController.pickerData = roundsPickerData
        settingScreenViewController.isTimePicker = false
        settingScreenViewController.defaultIndexForPicker = indexForRoundTotal
        navigationController?.pushViewController(settingScreenViewController, animated: true)
    }
    @IBAction func startGameButtonPressed(_ sender: Any) {

        UIView.animate(withDuration: 0.7, delay: 0.2, options: [.curveLinear, .repeat, .autoreverse], animations: {
            self.line1.alpha = 0.5
            
        }, completion: nil)

        UIView.animate(withDuration: 0.4, delay: 0.3, options: [.curveLinear, .repeat, .autoreverse], animations: {
            self.line2.alpha = 0.4
            
        }, completion: nil)

        UIView.animate(withDuration: 0.3, delay: 0.1, options: [.curveLinear, .repeat, .autoreverse], animations: {
            self.line2.alpha = 0.5
            
        }, completion: nil)
    }
}

// MARK: - Collection View -

extension ViewController {
//    func configureCollectionViewLayout() {
//        func collectionView(collectionView: UICollectionView,
//              layout collectionViewLayout: UICollectionViewLayout,
//              sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize
//          {
//            //return CGSize(width:collectionView.frame.size.width, height: 33.0)
//            return CGSize(width: 100.0, height: 33.0)
//          }
//    }

    
//  func configureCollectionViewLayout() -> UICollectionViewCompositionalLayout {
//    let sectionProvider = { (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
//
//      let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
//      let item = NSCollectionLayoutItem(layoutSize: itemSize)
//      item.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
//
//      let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.6), heightDimension: .fractionalHeight(0.3))
//      let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
//
//      let section = NSCollectionLayoutSection(group: group)
//      section.orthogonalScrollingBehavior = .groupPaging
//      section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
//      section.interGroupSpacing = 10
//
//      let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(44))
//      let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .topLeading)
//      section.boundarySupplementaryItems = [sectionHeader]
//
//      return section
//    }
//
//    return UICollectionViewCompositionalLayout(sectionProvider: sectionProvider)
//  }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "StartGame" {
            if  let startGameViewController = segue.destination as? StartGameViewController {
                startGameViewController.currentTeam = teamList.teams.first!
                startGameViewController.roundTotal = totalRounds
                startGameViewController.teamList = teamList
                startGameViewController.startOfGamedelegate = self
                startGameViewController.secondsForTimer = secondsForTimer
            }
            
        }
            
    }
    
}


// MARK: - Diffable Data Source

extension ViewController {
    func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, Team>(collectionView: teamCollecionView) { (collectionView: UICollectionView, indexPath: IndexPath, team) -> UICollectionViewCell? in
            
            guard  let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TeamCell.reuseIdentifier, for: indexPath) as? TeamCell else { return nil }
            

            cell.teamNameTextField.text = team.teamName
            cell.teamNameTextField.tag = indexPath.row
//            cell.teamNameTextField.delegate = self
            cell.delegate = self
            
//            if (cell.isSelected) {
//                cell.backgroundColor = UIColor.green; // highlight selection
//            }
//            else
//            {
//                 cell.backgroundColor = UIColor.yellow // Default color
//            }
            
            return cell
        }
    }
    
    func configureSnapshot() {
        var initialSnapshot = NSDiffableDataSourceSnapshot<Section, Team> ()
        initialSnapshot.appendSections([.main])
 
        initialSnapshot.appendItems(teamList.teams, toSection: .main)
        dataSource.apply(initialSnapshot, animatingDifferences: false)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) else { return }
        //guard let indexPath = self.tableView.indexPathForCell(cell)
        cell.isSelected = true
        cell.backgroundColor = UIColor.black
        //indexPath
       // updateDeleteButtonState()
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) else { return }

        cell.isSelected = false
        cell.backgroundColor = UIColor.yellow
       // updateDeleteButtonState()
    }
    
    
}

extension ViewController {
    func updateDeleteButtonState() {
        
        guard let selectedIndexes = teamCollecionView.indexPathsForSelectedItems else {
            return
        }
        
        deleteTeamButtonOutlet.isEnabled = selectedIndexes.count > 0
    }
}

// MARK: - Actions

private extension ViewController {
    @objc func didTap() {
        view.endEditing(true)
        //teamCollecionView.deselectAllItems(animated: true)
    }
}

extension ViewController: TeamCellDelegate {
    func makeDeleteButtonEnabled(isEnabled: Bool) {
        deleteTeamButtonOutlet.isEnabled = isEnabled
    }
    
    func updateTeamName(in cell: TeamCell, newName: String) {
        let indexPath = teamCollecionView.indexPath(for: cell)
        
        if let row = indexPath?.row, teamList.teams.count > row {
            let team = teamList.teams[row]
            
            
            if !newName.isEmpty , newName != team.teamName {
                let newNameIsNotUnique = teamList.teams.filter{$0.teamName == newName}.count > 0
                if newNameIsNotUnique {
                    let alert = UIAlertController(title: "TeamName", message: "should be unique", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    alert.view.tintColor = UIColor.purple
                    
                    alert.view.backgroundColor = UIColor.purple
                    self.present(alert, animated: true, completion: nil)
                } else {
                    team.teamName = newName
                }
            }
            teamCollecionView.reloadData()
        }
    }
    
    func makeCellSelected (in cell: TeamCell){
        //teamCollecionView.selectItem(at: IndexPath(index: cell.tag), animated: true, scrollPosition: .top)
        cell.isSelected = true
       // cell.backgroundColor = UIColor.yellow
    }
    
    func makeCellDeselected (in cell: TeamCell){
       cell.isSelected = false
       // cell.backgroundColor = UIColor.blue
        //teamCollecionView.deselectItem(at: IndexPath(index: cell.tag), animated: true)
    }
    
    func toggleCellSelection (in cell: TeamCell){
        //cell.isSelected = !cell.isSelected
    }
    
    func deselectAllCells() {
        //teamCollecionView.deselectAllItems(animated: true)
    }
    
//    func deselectAllCells (){
//        let selectedItems = teamCollecionView.indexPathsForSelectedItems
//        selectedItems?.forEach { indexPath in
//            teamCollecionView.deselectItem(at: indexPath, animated:true)
//        }
//    }
    
    
}

// MARK: - StartGameViewControllerDelegate

extension ViewController: StartGameViewControllerDelegate {
    func createNewTeams() {
        teamList = TeamData()
        secondsForTimer = teamList.secondsForRound
        totalRounds = teamList.roundTotal
        roundTotalValueOutlet.text = String(teamList.roundTotal)
        timerSecondsLabelOutlet.text = String(secondsForTimer)
        //setDefaultPickerValues()
        teamCollecionView.reloadData()
        configureDataSource()
        configureSnapshot()
    }
    
}

//// MARK: - UIPickerViewDelegate
//
//extension ViewController: UIPickerViewDelegate, UIPickerViewDataSource {
//
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//    }
//
//    func numberOfComponents(in pickerView: UIPickerView) -> Int {
//        return 1
//    }
//
//    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
//              var pickerDataCount = 0
//        if(pickerView == timePickerView) {
// pickerDataCount = timePickerData.count
//        }
//        if(pickerView == roundsPickerView) {
//            pickerDataCount = roundsPickerData.count
//        }
//        return pickerDataCount
//    }
//
//    // The data to return fopr the row and component (column) that's being passed in
//    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
//        var pickerDataValue: String = " "
//        if(pickerView == timePickerView) {
//            pickerDataValue = timePickerData[row]
//        }
//        if(pickerView == roundsPickerView) {
//            pickerDataValue = roundsPickerData[row]
//        }
//        return pickerDataValue
//    }
//
//    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
//
//        if(pickerView == timePickerView) {
//            if let timeAmount = Int(timePickerData[row]) {
//                secondsForTimer = timeAmount
//            }
//
//        }
//        if(pickerView == roundsPickerView) {
//            if let roundAmount = Int(roundsPickerData[row]) {
//                totalRounds = roundAmount
//            }
//        }
//    }
//
//    func setDefaultPickerValues () {
//        let indexForDefaultTime = timePickerData.firstIndex(of: String(teamList.secondsForRound
//))!
//        let indexForRoundTotal = teamList.roundTotal - 1
//        timePickerView.selectRow(indexForDefaultTime, inComponent: 0, animated:true)
//        roundsPickerView.selectRow(indexForRoundTotal, inComponent: 0, animated:true)
//    }
//
//}


extension UICollectionView {

    func deselectAllItems(animated: Bool) {
        guard let selectedItems = indexPathsForSelectedItems else { return }
       // for indexPath in selectedItems { deselectItem(at: indexPath, animated: animated) }
          for indexPath in selectedItems {
            guard let cell = self.cellForItem(at: indexPath) else { return }
            cell.isSelected = false
        }
    }
}

extension ViewController: SettingScreenViewControllerDelegate{
    func updateValueAccordingToPicker(pickedValue: Int, isTimePicker: Bool) {
        if isTimePicker {
            secondsForTimer = pickedValue

            
            timerSecondsLabelOutlet.text = String(secondsForTimer)
            
        } else {
            totalRounds = pickedValue
            roundTotalValueOutlet.text = String(totalRounds)
        }
        
    }
}

          
