//
//  SequencialQuestionStrategy.swift
//  RabbleWabble
//
//  Created by Ives Murillo on 4/30/22.
//

public class SequentialQuestionStrategy: BaseQuestionStrategy {
    
    // MARK: - Properties
   

   // public var correctCount: Int = 0

   // public var incorrecCount: Int = 0
    
 /*   public var correctCount: Int {
        get{ return questionGroup.score.correctCount}
        set{ questionGroup.score.correctCount = newValue}
    }
    
    public var incorrecCount: Int {
        get{ return questionGroup.score.incorrectCount}
        set{ questionGroup.score.incorrectCount = newValue}
    }
    
    private let questionGroup: QuestionGroup
    
    private var questionIndex = 0*/
    
    // MARK:  - Object LifeCycle
   /* public init(questionGroup: QuestionGroup){
        self.questionGroup = questionGroup
    }
    */
    public convenience init(questionGroupCareTaker: QuestionGroupCaretaker) {
        let questionGroup = questionGroupCareTaker.selectedQuestionGroup!
        
        let questions = questionGroup.questions 
        self.init(questionGroupCareTaker: questionGroupCareTaker, questions: questions)
    }
    
    
  /*  // MARK: - QuestionStrategy
    
    public var title: String {
        return questionGroup.title
    }
    
    public func advanceToNextQuestion() -> Bool {
        guard questionIndex + 1 < questionGroup.questions.count else{
            return false
        }
        questionIndex += 1
        return true
    }

    public func currentQuestion() -> Question {
        return questionGroup.questions[questionIndex]
    }

    public func markQuestionCorrect(_ question: Question) {
        correctCount += 1
    }

    public func markQuestionIncorrect(_ question: Question) {
        incorrecCount -= 1
    }

    public func questionIndexTitle() -> String {
        return "\(questionIndex + 1)/" + "\(questionGroup.questions.count)"
    }*/

}
