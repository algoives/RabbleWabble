//
//  RandomQuestionStrategy.swift
//  RabbleWabble
//
//  Created by Ives Murillo on 4/30/22.
//

import GameplayKit

public class RandomQuestionStrategy: BaseQuestionStrategy{
   
    
    // MARK: - Properties
   

 /*   public var correctCount: Int = 0

    public var incorrecCount: Int = 0
    
    private let questionGroup: QuestionGroup
    
    private var questionIndex = 0
    
    private let questions: [Question]*/
    
    // MARK:  - Object LifeCycle
  /*  public convenience init(questionGroup: QuestionGroup){
        self.questionGroup = questionGroup
        
        //2
        let randomSource = GKRandomSource.sharedRandom()
        self.questions = randomSource.arrayByShufflingObjects(in: questionGroup.question) as! [Question]
        
    }*/
    
    public convenience init(questionGroupCareTaker: QuestionGroupCaretaker) {
        let questionGroup = questionGroupCareTaker.selectedQuestionGroup!
        let ranDomSource = GKRandomSource.sharedRandom()
        let questions = ranDomSource.arrayByShufflingObjects(in: questionGroup.questions) as! [Question]
        self.init(questionGroupCareTaker: questionGroupCareTaker, questions: questions)
    }
    
    
    
  
    
}
