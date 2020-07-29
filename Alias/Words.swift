//
//  Words.swift
//  Alias
//
//  Created by Kapitan Kanapka on 12.06.2020.
//  Copyright © 2020 hippo. All rights reserved.
//

import Foundation

class Words {
  static let shared = Words()
  
  
 // var data: [String] = ["Лантух", "Дерево", "Какао", "Пятачисько", "Коліно", "Сплюх", "Макарони", "Солені горіхи", "Акація", "Муха цокотуха", "Кактус", "Опецько", "Шоколад", "Літооо", "Капець", "Ховрах", "💩" ]
  
  private init() {}
  
  static func randomWord() ->  String {
      let wordList: [String] = ["Лантух", "Дерево", "Какао", "Пятачисько", "Коліно", "Сплюх", "Макарони", "Солені горіхи", "Акація", "Муха цокотуха", "Кактус", "Опецько", "Шоколад", "Літооо", "Капець", "Ховрах", "💩" ]
    let randomIndex = Int.random(in: 0...wordList.count - 1)
    return wordList[randomIndex]
  }
    
    static func randomWord(notIncluding: [String]) ->  String {
        var randomWord = self.randomWord()
        while notIncluding.contains(randomWord){
            randomWord = self.randomWord()
        }
      return randomWord
    }

}
