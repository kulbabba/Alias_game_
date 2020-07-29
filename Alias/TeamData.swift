//
//  DataSource.swift
//  Alias
//
//  Created by Kapitan Kanapka on 04.06.2020.
//  Copyright © 2020 hippo. All rights reserved.
//

import Foundation

enum GameResultSituation {
    case oneWinner, allWinners, multipleWinners
}

class TeamData {

    var teams: [Team]
    var roundTotal: Int
    var secondsForRound: Int
    var roundTotalDefault: Int
    var secondsForRoundDefault: Int
    var gameSituation: GameResultSituation?
//    var timePickerData: [String] = Array(stride(from: 10, to: 310, by: 10)).map{ String($0) }
//    var roundsPickerData: [String] = Array(1...10).map{ String($0) }
    var timePickerData: [String]
    var roundsPickerData: [String]
    
    init() {
      let randomName1 = Team.randomTeamName()
      var randomName2 = Team.randomTeamName()
        while randomName2 == randomName1 {
            randomName2 = Team.randomTeamName()
        }
        self.teams = [Team(teamName: randomName1), Team(teamName: randomName2)]
        self.roundTotal = 1
        self.secondsForRound = 6
        self.roundTotalDefault = self.roundTotal
        self.secondsForRoundDefault = self.secondsForRound
        
        self.timePickerData = Array(stride(from: 10, to: 310, by: 10)).map{ String($0) }
        self.roundsPickerData = Array(1...10).map{ String($0) }
        
    }
    
    func sortedTeams () -> [Team] {
        return teams.sorted(by: {$0.teamScore > $1.teamScore})
    }
    
    func validateTeamName (teamName: String) -> String {
        var validatedName = teamName
        if teamName.isEmpty {
            validatedName = Team.randomTeamName()
        }
        let notUniqueNames = teams.filter{$0.teamName == validatedName}
        if notUniqueNames.count >= 1 {
            validatedName = validatedName + String(notUniqueNames.count)
        }
        return validatedName
    }
    
//    func updateTeamName (team: Team, teamNewName: String) {
//        var validatedName = teamNewName
//        if !teamNewName.isEmpty,  teamNewName != team.teamName {
//            let notUniqueNames = teams.filter{$0.teamName == validatedName}
//            if notUniqueNames.count > 0 {
//                if
//                validatedName = validatedName + String(notUniqueNames.count)
//            }
//        }
//    }
    func sumUpResults() -> (team: [Team],gameResult: GameResultSituation) {
        let gameResult: GameResultSituation
        let sortedTeams = self.sortedTeams()
        
        let highestScoreAmongTeams = sortedTeams.first!.teamScore
        let teamsWithHighestResult = sortedTeams.filter{$0.teamScore == highestScoreAmongTeams}
        if teamsWithHighestResult.count > 1 {
            if teamsWithHighestResult.count == sortedTeams.count {
                gameResult = .allWinners
            } else {
                gameResult = .multipleWinners
            }
        } else{
            gameResult = .oneWinner
        }
        return (teamsWithHighestResult, gameResult)
    }
    
    func deleteTeam(at indexPath: IndexPath) {
        teams.remove(at: indexPath.item)
    }
    
    func deleteTeams(at indexPaths: [IndexPath]) {
        for path in indexPaths {
            deleteTeam(at: path)
        }
    }
    
}
