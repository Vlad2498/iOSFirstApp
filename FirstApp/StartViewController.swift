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
    
    
    @IBOutlet weak var startButton: UIButton!
    
    
    // MARK: -DidLoad Function
    override func viewDidLoad() {
        startButton.isEnabled = false
        super.viewDidLoad()
        
        downloadQuestions(amount: 5)
        
        //Settings for the text field
        nameTextField.placeholder = "Type your name here"
        nameTextField.delegate = self
        nameTextField.returnKeyType = .done

        if let name = UserDefaults.standard.string(forKey: "username"){
            nameTextField.text = name
        }
    }
    


    @IBAction func highscoreButtonHandler(_ sender: Any) {
        let highscoreTableViewController = HighscoreTableViewController()
        navigationController?.pushViewController(highscoreTableViewController, animated: true)
    }


    private func downloadQuestions(amount: Int) {
        guard let url = URL(string: "https://opentdb.com/api.php?amount=\(amount)&type=multiple")
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
