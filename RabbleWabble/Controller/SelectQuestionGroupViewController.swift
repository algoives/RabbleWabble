//
//  SelectQuestionGroupViewController.swift
//  RabbleWabble
//
//  Created by Ives Murillo on 4/28/22.
//

import Foundation
import UIKit

public class SelectQuestionGroupViewController: UIViewController {
    // MARK: - Outlets
    @IBOutlet internal var tableView: UITableView!{
        didSet{
            tableView.tableFooterView = UIView()
        }
    }
    
    public var questionStrategy: QuestionStrategy! {
        didSet{
            navigationItem.title = questionStrategy.title
        }
    }
    
    // MARK: - Properties
    
    private let appSetting = AppSetting.shared
    
   /* public var questionGroups = [QuestionGroup(question: [ Question(answer: "what is that", hint: "hint what", prompt: " what?") ,
                                                          Question(answer: "why becouse this", hint: "hint why", prompt: "why?") ,
                                                          Question(answer: "who him", hint: "hint who", prompt: "who?") ,
                                                          Question(answer: "how that way", hint: "hint how", prompt: "how?") ,
                                                          Question(answer: "when yesterday", hint: "hint when", prompt: "when ?")], title: "Basic Questions"),
                                 
                                 QuestionGroup(question: [ Question(answer: "what is that ios", hint: "hint what ios", prompt: " what ios?") ,
                                                           Question(answer: "why becouse this ios", hint: "hint why ios", prompt: "why ios?") ,
                                                           Question(answer: "who him ios", hint: "hint who ios", prompt: "who ios?") ,
                                                           Question(answer: "how that way ios", hint: "hint how ios", prompt: "how ios?") ,
                                                           Question(answer: "when yesterday ios", hint: "hint when ios", prompt: "when ios?")], title: "IOS Questions"),
                                 
                                 QuestionGroup(question: [ Question(answer: "what is that swift", hint: "hint what swift", prompt: " what swift?") ,
                                                           Question(answer: "why becouse this swift", hint: "hint why swift", prompt: "why swift?") ,
                                                           Question(answer: "who him swift", hint: "hint who swift", prompt: "who swift?") ,
                                                           Question(answer: "how that way swift", hint: "hint how swift", prompt: "how swift?") ,
                                                           Question(answer: "when yesterday swift ", hint: "hint when swift", prompt: "when swift?")], title: "Swift Questions")
    ]*/
    private let questionGroupCareTaker = QuestionGroupCaretaker()
    private var questionGroups: [QuestionGroup]{
        return questionGroupCareTaker.questionGroups
    }
    //
   // private var selectedQuestionGroup: QuestionGroup!
    private var selectedQuestionGroup: QuestionGroup! {
        get{ return questionGroupCareTaker.selectedQuestionGroup}
        set{ questionGroupCareTaker.selectedQuestionGroup = newValue}
    }
    
    // MARK: - View Lifecycle
    public override func viewDidLoad() {
        super.viewDidLoad()
        questionGroups.forEach {
            print("\($0.title) :" + "correctCount \($0.score.correctCount), " + "incorrectCount \($0.score.incorrectCount)")
        }
    }
}

// MARK: - UITableVliewDataSource
extension SelectQuestionGroupViewController: UITableViewDataSource {
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "QuestionGroupCell") as! QuestionGroupCell
        let questionGroup = questionGroups[indexPath.row]
        cell.titleLabel.text = questionGroup.title
        
        // 1
        questionGroup.score.runningPercentage.addObserver(cell, options: [.initial,.new]){
            // 2
            [weak cell] (percentage, _) in
            DispatchQueue.main.async {
                //4
                cell?.percentageLabel.text = String(format: "%.0f %%", round(100 * percentage))
            }
        }
        
        return cell
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return questionGroups.count
    }
}

// MARK: - UITableViewDelegate
extension SelectQuestionGroupViewController: UITableViewDelegate {
    // 1
    public func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        selectedQuestionGroup = questionGroups[indexPath.row]
        return indexPath
    }
    // 2
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    // 3
    public override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let viewController = segue.destination as? QuestionViewController else { return }
        //viewController.questionStrategy = RandomQuestionStrategy(questionGroup: selectedQuestionGroup)
        viewController.questionStrategy = appSetting.questionStrategy(for: questionGroupCareTaker)
        viewController.delegate = self
    }
}

// MARK: - QuestionViewControllerDelegate
extension SelectQuestionGroupViewController: QuestionViewControllerDelegate {
    public func questionViewController(_ viewController: QuestionViewController, didCancel questionGroup: QuestionStrategy) {
        navigationController?.popToViewController(self, animated: true)
    }

    public func questionViewController(_ viewController: QuestionViewController, didComplete questionGroup: QuestionStrategy) {
        navigationController?.popToViewController(self, animated: true)
    }
       
   
}



