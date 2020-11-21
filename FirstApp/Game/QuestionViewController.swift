//
//  QuestionViewController.swift
//  FirstApp
//
//  Created by vlad on 26/10/2020.
//

import UIKit

class QuestionViewController: UIViewController {

    @IBOutlet weak var buttonAnswerA: UIButton!
    @IBOutlet weak var buttonAnswerB: UIButton!
    @IBOutlet weak var buttonAnswerC: UIButton!
    @IBOutlet weak var buttonAnswerD: UIButton!
    @IBOutlet weak var questionLabel: UILabel!
    
    
    private let gameResultDatabaseManager = GameResultDatabaseManager()
    
    private var haveWon = false
    
    var questions : [Question] = [] {
        didSet {
            question = questions.removeFirst()
        }
    }
    var question: Question?
    var numberOfQuestions = 0
    var rightAnswers = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var buttons = [buttonAnswerA ,buttonAnswerB , buttonAnswerC , buttonAnswerD]
        //Configuration of the buttons
        buttons.forEach{(button) in button?.layer.cornerRadius = 20}
       
                questionLabel.clipsToBounds = true
                questionLabel.layer.cornerRadius = 20
                questionLabel.backgroundColor = .systemTeal
        
        //configure the question label
        questionLabel.text = question?.question.htmlDecoded

        //shuffle button options
        buttons.shuffle()
        let correctButton = buttons.removeFirst()
        correctButton?.setTitle(question?.correctAnswer.htmlDecoded, for: .normal)
        
        question?.incorrectAnswers.forEach({(answer) in
            let button = buttons.removeFirst()
            button?.setTitle(answer.htmlDecoded, for: .normal)
        })
    }
    

    @IBAction func buttonAnswerAHandler(_ sender: Any) {
        print("Fish")

        decideAnswer(button: buttonAnswerA)
        
    }
    
    @IBAction func buttonAnswerBHandler(_ sender: Any) {
        print("Meat")
        
        decideAnswer(button: buttonAnswerB)
    
    }
    
    @IBAction func buttonAnswerCHandler(_ sender: Any) {
        print("Rice")
        
        decideAnswer(button: buttonAnswerC)
        
    }
    
    @IBAction func buttonAnswerDHandler(_ sender: Any) {
        print("Pizza")
                
        decideAnswer(button: buttonAnswerD)
        
    }
    
    
    
    
    private func showRightAnswerAlert(button: UIButton) {
        haveWon = true
        rightAnswers += 1
//        button.backgroundColor = .green
        
        UIView.transition(with: button, duration: 0.3, options: [.transitionFlipFromBottom]) {
                    button.backgroundColor = .systemGreen
                } completion: { (_) in
        
                    let alertController = UIAlertController(title: "You're right", message: "This is the right answer", preferredStyle: .alert)
                            
                    let action1 = UIAlertAction(title: "Great!", style: .default) { (action:UIAlertAction) in
                        
                        print("Pressed OK");
                        self.goToNextScreen()
                        
                    }

            //        let action2 = UIAlertAction(title: "Great", style: .cancel) { (action:UIAlertAction) in
            //            print("Pressed Great");
            //            //self.navigationController?.popToRootViewController(animated: true) //go to the root view controller
            //
            //            //Load another view
            //            self.performSegue(withIdentifier: "ResultView", sender: nil)
            //
            //            button.backgroundColor = .green
            //            print("Went back to initial screen")
            //        }

                    let action3 = UIAlertAction(title: "Cancel", style: .destructive) { (action:UIAlertAction) in
                        print("Pressed Cancel");
                    }

                    alertController.addAction(action1)
            //        alertController.addAction(action2)
                    alertController.addAction(action3)
        
                    self.present(alertController, animated: true, completion: nil)
                }
    }
    
    private func showWrongAnswerAlert(button: UIButton) {
        haveWon = false
//        button.backgroundColor = .red
        UIView.transition(with: button, duration: 0.3, options: [.transitionFlipFromLeft]) {
                    button.backgroundColor = .systemRed
                } completion: { (_) in
                    let alertController = UIAlertController(title: "WRONG", message: "I'm affraid this is the wrong answer", preferredStyle: UIAlertController.Style.alert)
                    
                    let action_1 = UIAlertAction(title: "Oh no...", style: .default, handler:{(_) in alertController.dismiss(animated: true, completion: nil)
                        
                        self.goToNextScreen()
                    })
                    
                    alertController.addAction(action_1)
                    
                    alertController.view.tintColor = .systemOrange
                    self.present(alertController, animated: true, completion: nil)
                }
        
    }
    
    // chacks if the answer is right or wrong
    func chackIfItIsTheRightAnswer (forButton button:UIButton) -> Bool {
        button.title(for: .normal) == question?.correctAnswer
    }
    
    //decides which alert to show
    private func decideAnswer(button: UIButton){
        if chackIfItIsTheRightAnswer(forButton: button) {
            showRightAnswerAlert(button: button)
        } else {
            showWrongAnswerAlert(button: button)
        }
    }
    
    private func goToNextScreen(){
        guard !questions.isEmpty,
              let questionViewController = storyboard?.instantiateViewController(withIdentifier: "QuestionViewController") as? QuestionViewController else {
            saveGameResult()
            performSegue(withIdentifier: "ResultView", sender: nil)
            return
        }
        
        questionViewController.numberOfQuestions = numberOfQuestions
        questionViewController.rightAnswers = rightAnswers
        questionViewController.questions = questions
        navigationController?.pushViewController(questionViewController, animated: true)
    }
    
    //MARK: - Saving the result
    private func saveGameResult() {
        
        if gameResultDatabaseManager.create(withNumberOfQuestions: numberOfQuestions, withRightAnswer: rightAnswers) != nil {
            
            gameResultDatabaseManager.save()
        }
    }
    
    // MARK: - Navigation

//     In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let resultViewController = segue.destination as? ResultViewController {
            resultViewController.resultView.resultLabel.text = "🥳 You answered \(rightAnswers) right from \(numberOfQuestions) questions!" 
        }
    }

}
