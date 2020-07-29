//
//  Team.swift
//  Alias
//
//  Created by Kapitan Kanapka on 04.06.2020.
//  Copyright © 2020 hippo. All rights reserved.
//

import Foundation

class Team: Hashable, Comparable {
    static func < (lhs: Team, rhs: Team) -> Bool {
        return lhs.teamScore < rhs.teamScore
    }
    
    
    var teamName: String
    var teamScore: Int = 0
    let identifier = UUID().uuidString
    
    static func == (lhs: Team, rhs: Team) -> Bool {
        return lhs.teamScore == rhs.teamScore
    }
    
    func hash(into hasher: inout Hasher) {
      hasher.combine(identifier)
    }

    
    init(teamName: String) {
        self.teamName = teamName
    }
    
    convenience init() {
        self.init(teamName: Team.randomTeamName())
    }
    
    static func randomTeamName() -> String {
        let defaultTeamNamesArray =
            ["Надоїдливі джмелі",
             "Скажені ховрахи",
             "Мурахи ордероносці",
             "Стресостійкі удави",
             "Відважні півні",
             "Усердні щуки",
             "Розважливі слимаки",
             "Невгамовні кози",
             "Щиросердні єдинороги",
             "Ясновидячі жаби",
             "Воркуючі гуски",
             "Стрункі журавлі",
             "Непереможні страуси",
             "Просвітлені богомольці",
             "Кмітливі клопи",
             "Ситі хом'яки",
             "Кокетливі устриці",
             "Наполегливі гусениці",
             "Відважні кролі",
             "Винахідливі мухи",
             "Дружелюбні верблюди",
             "Дальноглядні яструби",
             "Карколомні пелікани",
             "Жирафи бігуни",
             "Поважні лящі",
             "Вчені дикобрази",
             "Кури завойовники",
             "Вперті їжаки",
             "Сердиті єноти",
             "Усміхнені бегемоти"]
        let randomInt = Int.random(in: 0...defaultTeamNamesArray.count - 1)
        return defaultTeamNamesArray[randomInt]
    }    
}
