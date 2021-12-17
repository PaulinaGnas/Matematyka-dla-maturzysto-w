//
//  TestViewController.swift
//  Matematyka dla maturzystów
//
//  Created by Paulina Gnas on 21/11/2021.
//

import UIKit
import Firebase

class TestViewController: UIViewController {
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var aButton: UIButton!
    @IBOutlet weak var bButton: UIButton!
    @IBOutlet weak var cButton: UIButton!
    @IBOutlet weak var dButton: UIButton!
    @IBOutlet weak var progressBar: UIProgressView!
    
    let db = Firestore.firestore()
    
    var test: [Question] = []
    
    var questionNumber = 0
    var score = 0
    var progress = 0
    var cName: String? // Category Name
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = cName
        navigationItem.hidesBackButton = true
        
        loadTest()
    }
    
    @IBAction func answerButtonPressed(_ sender: UIButton) {
        
        //3 4 1 4 2
        
        let userAnswer = sender.currentTitle!
        let a = checkAnswer(userAnswer: userAnswer)
        
        if lastQuestion() {
            performSegue(withIdentifier: C.resultSegue, sender: self)
            score = 0
        } else {
            
            nextQuestion()
        }
        
        Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(updateUI), userInfo: nil, repeats: false)
    }
    
    func checkAnswer(userAnswer: String) -> Bool {
        if userAnswer == test[questionNumber].goodAnswer {
            score += 1
            return true
        } else {
            return false
        }
    }
    func lastQuestion() -> Bool {
        if questionNumber + 1 == test.count {
            //  score = 0
            return true
        } else {
            return false
        }
    }
    
    func getProgress() -> Float {
        return Float(questionNumber) / Float(test.count)
    }

    func loadTest() {
        db.collection(cName!).getDocuments { (querySnapshot, error) in
            if let e = error {
                print("There was an issue with retrieving data from Firestore. \(e)")
            } else {
                if let snapshotDocuments = querySnapshot?.documents {
                    for doc in snapshotDocuments {
                        let data = doc.data()
                        if let question = data[C.Test.questionField] as? String, let answerA = data[C.Test.answerAField] as? String,
                           let answerB = data[C.Test.answerBField] as? String,
                           let answerC = data[C.Test.answerCField] as? String, let answerD = data[C.Test.answerDField] as? String,
                           let gAnswer = data[C.Test.goodAnswerField] as? String {
                            
                            let testInfo = Question(question: question, answerA: answerA, answerB: answerB, answerC: answerC, answerD: answerD, goodAnswer: gAnswer)
                            
                            self.test.append(testInfo)
                            
                            DispatchQueue.main.async {
                                self.updateUI()
                            }
                        }
                    }
                }
            }
        }
    }
    
    @objc func updateUI() {
        questionLabel.text = test[questionNumber].question
        aButton.setTitle(test[questionNumber].answerA, for: .normal)
        bButton.setTitle(test[questionNumber].answerB, for: .normal)
        cButton.setTitle(test[questionNumber].answerC, for: .normal)
        dButton.setTitle(test[questionNumber].answerD, for: .normal)
        progressBar.progress = getProgress()
    }
    
    
    func nextQuestion() {
        if questionNumber + 1 < test.count {
            questionNumber += 1
        } else {
            questionNumber = 0
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == C.resultSegue {}
        let destinationVC = segue.destination as! ResultViewController
        destinationVC.score = score
        destinationVC.questions = test.count
        destinationVC.categoryName = cName
    }
}
