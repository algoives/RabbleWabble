//
//  BaseQuestionStrategy.swift
//  RabbleWabble
//
//  Created by Ives Murillo on 5/2/22.
//

import Foundation

public class BaseQuestionStrategy: QuestionStrategy {
  
    // MARK: - Properties
    // 1
   public var correctCount: Int {
        get{ return questionGroup.score.correctCount}
        set{ questionGroup.score.correctCount = newValue}
    }
    
    public var incorrecCount: Int {
        get{ return questionGroup.score.incorrectCount}
        set{ questionGroup.score.incorrectCount = newValue}
    }
    
    private var questionGroupCareTaker: QuestionGroupCaretaker
    
    // 2
    private var questionGroup: QuestionGroup {
        return questionGroupCareTaker.selectedQuestionGroup
    }
    
    private var questionIndex = 0
    private let questions: [Question]
    
    // MARK:  - Object LifeCycle
    //3
    public init(questionGroupCareTaker: QuestionGroupCaretaker,questions: [Question]){
        self.questionGroupCareTaker = questionGroupCareTaker
        self.questions = questions
        
        // 4
        self.questionGroupCareTaker.selectedQuestionGroup.score.reset()
    }
    
    // MARK: - QuestionStrategy
    
    public var title: String {
        return questionGroup.title
    }
    
    public func advanceToNextQuestion() -> Bool {
        try? questionGroupCareTaker.save()
        guard questionIndex + 1 < questions.count else{
            return false
        }
        questionIndex += 1
        return true
    }

    public func currentQuestion() -> Question {
        return questions[questionIndex]
    }

    public func markQuestionCorrect(_ question: Question) {
        correctCount += 1
    }

    public func markQuestionIncorrect(_ question: Question) {
        incorrecCount -= 1
    }

    public func questionIndexTitle() -> String {
        return "\(questionIndex + 1)/" + "\(questions.count)"
    }
}
