//
//  StartViewController.swift
//  FirstApp
//
//  Created by vlad on 12/11/2020.
//

import UIKit

class StartViewController: UIViewController {
    
    var questions: [Question] = []

    
    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var questionsNrTextField: UITextField!
    
    @IBOutlet weak var questionsDifficultyTextField: UITextField!
    
    @IBOutlet weak var startButton: UIButton!
    
    var nrQuestions = 0
    var difficulty = ""
    
    // MARK: -DidLoad Function
    override func viewDidLoad() {
        startButton.isEnabled = false
        super.viewDidLoad()
        
        hideKeyboardWhenTappingAround()
        
//        downloadQuestions(amount: 1)
        
        //Settings for the text field
        nameTextField.placeholder = "Type your name here"
        nameTextField.delegate = self
        nameTextField.returnKeyType = .done
        
        questionsNrTextField.returnKeyType = .done

        if let name = UserDefaults.standard.string(forKey: "username"){
            nameTextField.text = name
        }
        
        
    }
    
   
    
    //handling press on highscore button
    @IBAction func highscoreButtonHandler(_ sender: Any) {
        let highscoreTableViewController = HighscoreTableViewController()
        navigationController?.pushViewController(highscoreTableViewController, animated: true)
    }
    
    
    // Getting the number of questions
     @IBAction func sendQuestionNumber(_ sender: Any) {
//         print(questionsNrTextField.text!)
        nrQuestions = Int(questionsNrTextField.text ?? "1") ?? 1
        print("Number of questions selected is:", nrQuestions)
     }
    
    //getting the question difficulty
    @IBAction func sendQuestionsDifficulty(_ sender: Any) {
        let diff = Int(questionsDifficultyTextField.text ?? "0") ?? 0
        
        switch diff{
        
        case 0:
            difficulty = ""
            downloadQuestions(amount: nrQuestions, difficulty: difficulty)
            
        case 1:
            difficulty = "easy"
            downloadQuestions(amount: nrQuestions, difficulty: difficulty)
            
        case 2:
            difficulty = "medium"
            downloadQuestions(amount: nrQuestions, difficulty: difficulty)
            
        case 3:
            difficulty = "hard"
            downloadQuestions(amount: nrQuestions, difficulty: difficulty)
            
        default:
            let alertController = UIAlertController(title: "Wrong Input", message: "Please type a number between 0 and 3", preferredStyle: UIAlertController.Style.alert)
            
            let action_1 = UIAlertAction(title: "Okay", style: .default, handler:{(_) in alertController.dismiss(animated: true, completion: nil)
                
            })
            
            alertController.addAction(action_1)
            
            alertController.view.tintColor = .systemOrange
            self.present(alertController, animated: true, completion: nil)
        }
        print("Difficulty selected is:", difficulty)
        //calling the download questions function with the previously entered parameteres
        
    }
    

    //function that downloads the number of questions mentioned
    private func downloadQuestions(amount: Int, difficulty: String) {
        guard let url = URL(string: "https://opentdb.com/api.php?amount=\(amount)&difficulty=\(difficulty)&type=multiple")
        else {
            return
        }
        let task = URLSession.shared.dataTask(with: url) { [weak self] (data, _, error) in
            guard let data = data else {
                print(error)
                return
            }
            //print(String(data: data, encoding: .utf8))
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let questionResult = try? decoder.decode(QuestionsResult.self, from: data)
            self?.questions = questionResult?.results ?? []
            
            DispatchQueue.main.async {
                self?.startButton.isEnabled = true
            }
            
//            print(self.questions)
        }
        task.resume()
    }
    

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let questionViewController = segue.destination as? QuestionViewController {
//            let question1 = Question(category: "Food", type: .multiple, difficulty: .easy, question: "What is my favorite food", correctAnswer: "🍕", incorrectAnswers: ["🍚","🥩","🐟"])
//
//            let question2 = Question(category: "Animals", type: .multiple, difficulty: .hard, question: "Which is a mamal", correctAnswer: "🐭", incorrectAnswers: ["🦎" , "🐟" , "🐛"])
//            let questions = [question1 , question2 , question1]
            questionViewController.numberOfQuestions = questions.count
            questionViewController.questions = questions
            
            
        }
    }

    @IBAction func exampleButtonHandler(_ sender: Any) {
//        let scrollViewController = ExampleScrollViewController()
//        navigationController?.pushViewController(scrollViewController, animated: true)
        
        let cameraViewController = CameraViewController()
        navigationController?.pushViewController(cameraViewController, animated: true)
        
    }
    
}


// MARK: -Text field delegate
extension StartViewController: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let name = textField.text else {
            return
        }
        UserDefaults.standard.set(name, forKey: "username")
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        return true
    }
}

// extension that withdraws the keyboard when the user presses anywhere
extension UIViewController {
    func hideKeyboardWhenTappingAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
