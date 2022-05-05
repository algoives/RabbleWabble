//
//  ViewController.swift
//  RabbleWabble
//
//  Created by Ives Murillo on 4/27/22.
//

import UIKit

// MARK: - QuestionViewCintrollerDelegate
public protocol QuestionViewControllerDelegate: class {
    //1
    func questionViewController(_ viewController: QuestionViewController,
                                didCancel questionGroup: QuestionStrategy)
    //2
    func questionViewController(_ viewController: QuestionViewController, didComplete questionStrategy: QuestionStrategy)
    
}



public class QuestionViewController: UIViewController {

    // MARK: - Instance Properties
    
    public weak var delegate: QuestionViewControllerDelegate?
    
    public var questionStrategy: QuestionStrategy!{
        didSet{
            navigationItem.title = questionStrategy.title
        }
    }
    
    private  var questionGropQuestions =  [ Question(answer: "what?", hint: "hint what", prompt: "prompt what") ,
                                Question(answer: "why?", hint: "hint why", prompt: "prompt why") ,
                                Question(answer: "who?", hint: "hint who", prompt: "prompt who") ,
                                Question(answer: "how?", hint: "hint how", prompt: "prompt how") ,
                                Question(answer: "when?", hint: "hint when", prompt: "prompt when")

    ]
    
   /* public var questionGroup =  QuestionGroup(question: [ Question(answer: "what?", hint: "hint what", prompt: "prompt what") ,
                                                          Question(answer: "why?", hint: "hint why", prompt: "prompt why") ,
                                                          Question(answer: "who?", hint: "hint who", prompt: "prompt who") ,
                                                          Question(answer: "how?", hint: "hint how", prompt: "prompt how") ,
                                                          Question(answer: "when?", hint: "hint when", prompt: "prompt when")

                              ], title: "Basic Questions")*/
   /* public var questionGroup: QuestionGroup! {
        didSet{
            navigationItem.title = questionGroup.title
        }
    }*/
    
    public var questionIndex = 0
    
    public var correctCount = 0
    public var incorrecCount = 0
    
    public var questionView: QuestionView! {
        guard isViewLoaded else {return nil }
       
        return(view as! QuestionView)
    }
    
    private lazy var questionIndexItem: UIBarButtonItem = {
        let item = UIBarButtonItem(title: "",
                                   style: .plain,
                                   target: nil,
                                   action: nil)
        item.tintColor = .black
        navigationItem.rightBarButtonItem = item
        return item
    }()
    
    // MARK: - View Lifecycle
    public override func viewDidLoad() {
        super.viewDidLoad()
        setupCancelButton()
        showQuestion()
        
    }
    
    private func setupCancelButton() {
        let action = #selector(handleCancelPressed(sender:))
        let image = UIImage(systemName: "scale.3d")
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: image, landscapeImagePhone: nil, style: .plain, target: self, action: action)
            
    }
    
    @objc private func handleCancelPressed(sender: UIBarButtonItem){
        delegate?.questionViewController(self, didCancel: questionStrategy)
    }
    private func showQuestion(){
        
  //1
        let question = questionStrategy.currentQuestion()
        
        questionView.answerLabel.text = question.answer
        questionView.promtLabel.text = question.prompt
        questionView.hintLabel.text = question.hint
        
        questionView.answerLabel.isHidden = true
        questionView.hintLabel.isHidden = true
        questionIndexItem.title = questionStrategy.questionIndexTitle()
    }
    
    // MARK: - Actions
    @IBAction func toggleAnswerLabels(_ sender: Any){
        questionView.answerLabel.isHidden =
        !questionView.answerLabel.isHidden
        questionView.hintLabel.isHidden =
        !questionView.hintLabel.isHidden
    }
    
    //1
    @IBAction func handleCorrect(_ sender: Any){
        /*correctCount += 1
        questionView.correctCountLabel.text = "\(correctCount)"
        showNextQuestion()*/
        
        let question = questionStrategy.currentQuestion()
        questionStrategy.markQuestionCorrect(question)
        
        questionView.correctCountLabel.text = String(questionStrategy.correctCount)
        showNextQuestion()
    }
    //2
    @IBAction func handleInCorrect(_ sender: Any){
        /*incorrecCount += 1
        questionView.incorrectCountLabel.text = "\(incorrecCount)"
        showNextQuestion()*/
        
        let question = questionStrategy.currentQuestion()
        questionStrategy.markQuestionIncorrect(question)
        
        questionView.incorrectCountLabel.text = String(questionStrategy.incorrecCount)
        showNextQuestion()
        
    }
    //3
    private func showNextQuestion(){
        
        guard questionStrategy.advanceToNextQuestion() else {
            delegate?.questionViewController(self, didComplete: questionStrategy)
            return
        }
        showQuestion()
    }

}
