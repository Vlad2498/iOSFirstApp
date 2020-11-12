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
    
    private var haveWon = false
    var question: Question? {
        didSet{
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var buttons = [buttonAnswerA ,buttonAnswerB , buttonAnswerC , buttonAnswerD]
        //Configuration of the buttons
        buttons.forEach{(button) in button?.layer.cornerRadius = 20}
       
        //        questionLabel.clipsToBounds = true
        //        questionLabel.layer.cornerRadius = 20
        //        questionLabel.backgroundColor = .systemTeal
        
        //configure the question label
        questionLabel.text = question?.question

        //shuffle button options
        buttons.shuffle()
        let correctButton = buttons.removeFirst()
        correctButton?.setTitle(question?.correctAnswer, for: .normal)
        
        question?.incorrectAnswers.forEach({(answer) in
            let button = buttons.removeFirst()
            button?.setTitle(answer, for: .normal)
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
        
        let alertController = UIAlertController(title: "You're right", message: "This is the right answer", preferredStyle: .alert)
                
        let action1 = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction) in
            print("Pressed OK");
            button.backgroundColor = .green
        }

        let action2 = UIAlertAction(title: "Great", style: .cancel) { (action:UIAlertAction) in
            print("Pressed Great");
            //self.navigationController?.popToRootViewController(animated: true) //go to the root view controller
            
            //Load another view
            self.performSegue(withIdentifier: "ResultView", sender: nil)
            
            button.backgroundColor = .green
            print("Went back to initial screen")
        }

        let action3 = UIAlertAction(title: "Cancel", style: .destructive) { (action:UIAlertAction) in
            print("Pressed Cancel");
        }

//        alertController.addAction(action1)
        alertController.addAction(action2)
        alertController.addAction(action3)
        self.present(alertController, animated: true, completion: nil)
    }
    
    private func showWrongAnswerAlert(button: UIButton) {
        let alertController = UIAlertController(title: "WRONG", message: "Wrong Again", preferredStyle: UIAlertController.Style.alert)
        
        let action_1 = UIAlertAction(title: "Oh no...", style: .default, handler:{(_) in alertController.dismiss(animated: true, completion: nil)
            button.backgroundColor = .red
        })
        
        alertController.addAction(action_1)
        
        alertController.view.tintColor = .systemOrange

        present(alertController, animated: true, completion: nil)
    }
    
    private func decideAnswer(button: UIButton){
        if button.title(for: .normal) == question?.correctAnswer {
            showRightAnswerAlert(button: button)
        } else {
            showWrongAnswerAlert(button: button)
        }
    }
    
    // MARK: - Navigation

//     In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let resultViewController = segue.destination as? ResultViewController {
            resultViewController.resultView.resultLabel.text = haveWon ? "🥳" : "😭"
        }
    }

}
