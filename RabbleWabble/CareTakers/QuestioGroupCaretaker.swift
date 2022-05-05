//
//  QuestioGroupCaretaker.swift
//  RabbleWabble
//
//  Created by Ives Murillo on 5/2/22.
//

import Foundation

// 1
public final class QuestionGroupCaretaker {
    // MARK: - Properties
    //2
    private let fileName = "QuestionGroupData"
    public var questionGroups: [QuestionGroup] = []
    public var selectedQuestionGroup: QuestionGroup!
    
    // MARK: - Object Lifecyle
    public init() {
        //3
        loadQuestionGroups()
    }
    
    // 4
    public func loadQuestionGroups() {
        if let questionGroups = try? DiskCareTaker.retrieve([QuestionGroup].self, from: fileName){
            self.questionGroups = questionGroups
        }else{
            let bundle = Bundle.main
            let url = bundle.url(forResource: fileName, withExtension: "json")!
            self.questionGroups = try! DiskCareTaker.retrieve([QuestionGroup].self, from: url)
            try! save()
        }
    }
    
    // MARK: - Instance Methods
    // 5
    public func save() throws {
        try DiskCareTaker.save(questionGroups, to: fileName)
    }
}
