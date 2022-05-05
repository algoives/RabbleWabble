//
//  QuestionStrategy.swift
//  RabbleWabble
//
//  Created by Ives Murillo on 4/30/22.
//

public protocol QuestionStrategy: class {
    // 1
    var title: String {get}
    
    // 2
    var correctCount: Int {get}
    var incorrecCount: Int {get}
    
    // 3
    func advanceToNextQuestion() -> Bool
    
    // 4
    func currentQuestion() -> Question
    
    // 5
    func markQuestionCorrect(_ question: Question)
    func markQuestionIncorrect(_ question: Question)
    
    // 6
    func questionIndexTitle() -> String
}
