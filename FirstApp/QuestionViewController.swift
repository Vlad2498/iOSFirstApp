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
    
    private var haveWon = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buttonAnswerA.layer.cornerRadius = 20
        buttonAnswerB.layer.cornerRadius = 20
        buttonAnswerC.layer.cornerRadius = 20
        buttonAnswerD.layer.cornerRadius = 20
    }
    

    @IBAction func buttonAnswerAHandler(_ sender: Any) {
        print("Fish")
        let alertController = UIAlertController(title: "WRONG", message: "Wrong answer playa", preferredStyle: UIAlertController.Style.alert)
        
        let action_1 = UIAlertAction(title: "Ah damn", style: .destructive, handler:{(_) in alertController.dismiss(animated: true, completion: nil)
            self.buttonAnswerA.backgroundColor = .red
        })
        let action_2 = UIAlertAction(title: "Try again ?", style: .default, handler:{(_) in alertController.dismiss(animated: true, completion: nil)
            self.buttonAnswerA.backgroundColor = .red
        })
        
        alertController.addAction(action_1)
        alertController.addAction(action_2)
        
        alertController.view.tintColor = .systemGreen
        present(alertController, animated: true, completion: nil)
        

    }
    
    @IBAction func buttonAnswerBHandler(_ sender: Any) {
        print("Meat")
        
        let alertController = UIAlertController(title: "WRONG", message: "Wrong Again", preferredStyle: UIAlertController.Style.alert)
        
        let action_1 = UIAlertAction(title: "Fine", style: .default, handler:{(_) in alertController.dismiss(animated: true, completion: nil)
            self.buttonAnswerB.backgroundColor = .red
        })
        
        
        alertController.addAction(action_1)
        
        alertController.view.tintColor = .systemOrange

        present(alertController, animated: true, completion: nil)
        
        
    }
    
    @IBAction func buttonAnswerCHandler(_ sender: Any) {
        print("Rice")
        
        let alertController = UIAlertController(title: "WRONG", message: "Wrong Again", preferredStyle: UIAlertController.Style.alert)
        
        let action_1 = UIAlertAction(title: "Again", style: .default, handler:{(_) in
            
            alertController.dismiss(animated: true, completion: nil)
            self.performSegue(withIdentifier: "ResultView", sender: nil)
            self.buttonAnswerC.backgroundColor = .red
        })
        
        let action_2 = UIAlertAction(title: "Leave", style: .destructive, handler:{(_) in
            
            alertController.dismiss(animated: true, completion: nil)
            self.buttonAnswerC.backgroundColor = .red
            self.navigationController?.popViewController(animated: true) //goes to the previous view controller
        })
        
        alertController.addAction(action_2)
        alertController.addAction(action_1)
        
        alertController.view.tintColor = .systemPurple

        present(alertController, animated: true, completion: nil)
        
        
    }
    
    @IBAction func buttonAnswerDHandler(_ sender: Any) {
        print("Pizza")
        
        haveWon = true
        
        let alertController = UIAlertController(title: "Alert", message: "This is the right answer", preferredStyle: .alert)
                
        let action1 = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction) in
            print("Pressed OK");
            self.buttonAnswerD.backgroundColor = .green
        }

        let action2 = UIAlertAction(title: "Great", style: .cancel) { (action:UIAlertAction) in
            print("Pressed Great");
            //self.navigationController?.popToRootViewController(animated: true) //go to the root view controller
            
            //Load another view
            self.performSegue(withIdentifier: "ResultView", sender: nil)
            
            self.buttonAnswerD.backgroundColor = .green
            print("Went back to initial screen")
        }

        let action3 = UIAlertAction(title: "Cancel", style: .destructive) { (action:UIAlertAction) in
            print("Pressed Cancel");
            self.buttonAnswerD.backgroundColor = .green
        }

        alertController.addAction(action1)
        alertController.addAction(action2)
        alertController.addAction(action3)
        self.present(alertController, animated: true, completion: nil)
        
        
        
    }
    
    // MARK: - Navigation

//     In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let resultViewController = segue.destination as? ResultViewController {
            resultViewController.resultView.resultLabel.text = haveWon ? "🥳" : "🤕"
        }
    }

}
