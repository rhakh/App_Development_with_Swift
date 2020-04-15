//
//  ResultsViewController.swift
//  PersonalityQuiz
//
//  Created by Роман Гах on 19.01.2020.
//  Copyright © 2020 Роман Гах. All rights reserved.
//

import UIKit

class ResultsViewController: UIViewController {
    
    @IBOutlet weak var resultAnswerLabel: UILabel!
    @IBOutlet weak var resultDefinitionLabel: UILabel!
    var responses: [Answer]!

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        calculatePersonalityResult()
    }
    
    func calculatePersonalityResult() {
        var frequencyOfAnswers: [AnimalType : Int] = [:]
        var responseTypes = responses.map { $0.type }
        
        for response in responseTypes {
            let newCount: Int
            
            if let oldCount = frequencyOfAnswers[response] {
                newCount = oldCount + 1
            }
            else {
                newCount = 1
            }
            
            frequencyOfAnswers[response] = newCount
        }
        
        let frequentAnswerSorted = frequencyOfAnswers.sorted(by: {
            (pair1, pair2) -> Bool in return pair1.value > pair2.value
        })
        
        let mostCommonAnswer = frequentAnswerSorted.first!.key
        
        resultAnswerLabel.text = "You are a \(mostCommonAnswer.rawValue) !"
        resultDefinitionLabel.text = mostCommonAnswer.definition
    }

}
