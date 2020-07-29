//
//  EndResultsViewController.swift
//  Alias
//
//  Created by Kapitan Kanapka on 17.06.2020.
//  Copyright © 2020 Crazy Hippo. All rights reserved.
//

import UIKit

class EndResultsViewController: UIViewController {
    var mainView: EndResultsViewInteractable!
    let viewModel = EndResultsViewModel()
    var result: GameResultSituation!
    var winnerList: [Team]!
    var teamList = TeamData()
    var delegate: EndResultsViewControllerDelegate?

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
        
        let sortedTeams = teamList.sortedTeams()
        let config = EndResultsViewConfig(gameResult: result, winnerList: winnerList, teamList: sortedTeams)
        
        mainView = EndResultsView(with: config)
        mainView.delegate = self
        
        view.addFullyExtended(mainView)
    }
}

extension EndResultsViewController: EndResultsViewDelegate {
    func startNewGameButtonPressed() {
        delegate?.endGame()
        navigationController?.popToRootViewController(animated: true)
    }
}

protocol EndResultsViewControllerDelegate {
    func endGame()
}

