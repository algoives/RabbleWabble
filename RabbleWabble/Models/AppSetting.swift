//
//  AppSetting.swift
//  RabbleWabble
//
//  Created by Ives Murillo on 5/1/22.
//

import Foundation

public class AppSetting {
    
    // MARK: Keys
    private struct Keys {
        static let questionStrategy = "questionStrategy"
    }
    
    
    // MARK: - STAtic properti
    public static let shared = AppSetting()
    
    // MARK: - Instance Properties
    public var questionStrategyType: QuestionStrategyType {
        get {
            let rawValue = userDefaults.integer(forKey: Keys.questionStrategy)
            return QuestionStrategyType(rawValue: rawValue)!
        } set {
            userDefaults.set(newValue.rawValue, forKey: Keys.questionStrategy)
        }
    }
    private let userDefaults  = UserDefaults.standard
    
    // MARK: - Instance Methods
    public func questionStrategy(for questionGroupCaretaker: QuestionGroupCaretaker) -> QuestionStrategy{
        return questionStrategyType.questionStrategy(for: questionGroupCaretaker)
    }
    
    // MARK: - Object Lifecycle
    private init() {}
}

// MARK: - QuestionStrategyType
public enum QuestionStrategyType: Int, CaseIterable {
    case random
    case sequential
    
    // MARK: - INstance Methods
    public func title() -> String {
        switch self {
        case.random:
            return "Random"
        case.sequential:
            return "Sequential"
        }
    }
    
    public func questionStrategy(for questionGroupCaretaker: QuestionGroupCaretaker) ->QuestionStrategy {
        switch self {
        case .random:
            return RandomQuestionStrategy(questionGroupCareTaker: questionGroupCaretaker)
        case.sequential:
            return SequentialQuestionStrategy(questionGroupCareTaker: questionGroupCaretaker)
        }
    }
}
