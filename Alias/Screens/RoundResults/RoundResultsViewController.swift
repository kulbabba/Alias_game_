//
//  RoundResultsViewController.swift
//  Alias
//
//  Created by Kapitan Kanapka on 17.06.2020.
//  Copyright © 2020 Crazy Hippo. All rights reserved.
//

import UIKit

class RoundResultsViewController: UIViewController {
    var mainView: RoundResultsViewInteractable!
    let viewModel = RoundResultsViewModel()
    var isLastRound = false
    var delegateRoundResults: RoundResultsViewControllerDelegate?
    
    var configForView = RoundResultsViewConfig(curentTeam: Team(), teamList: TeamData(), wordList: [], scoreForCurrentRound: 0, isLastRound: false)

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
        
        let config = configForView
        
        mainView = RoundResultsView(with: config)
        mainView.delegate = self
        
        view.addFullyExtended(mainView)
    }
}

extension RoundResultsViewController: RoundResultsViewDelegate {
    func startNextTeamButtonPressed() {
        if isLastRound {
            let result = configForView.teamList.sumUpResults()
            
            let endResultsViewController = EndResultsViewController()

            endResultsViewController.result = result.gameResult
            endResultsViewController.winnerList = result.team
            endResultsViewController.teamList = configForView.teamList
            endResultsViewController.delegate = self
            navigationController?.pushViewController(endResultsViewController, animated: true)
            
        } else {
            delegateRoundResults?.updateValuesForNewRound()
            navigationController?.popViewController(animated: true)
        }
        
    }
    
    func endGamePressed() {
        delegateRoundResults?.endGameOnRoundResults()
    }

}

protocol RoundResultsViewControllerDelegate {
    func updateValuesForNewRound()
    func endGameOnRoundResults()
}

extension RoundResultsViewController: EndResultsViewControllerDelegate {
    func endGame() {
        delegateRoundResults?.endGameOnRoundResults()
    }
    
    
}
