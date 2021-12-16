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
    var testBrain = TestBrain()
    
    var questionNumber = 0
    var cName: String? // Category Name
    
    func nextQuestion() {
        if  questionNumber + 1 < test.count {
            questionNumber += 1
        } else {
            questionNumber = 0
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = cName
        navigationItem.hidesBackButton = true
       // print(cName)
        
        loadTest()
        
   //     updateUI()
    }
    var score = 0
    
    func loadTest() {
        db.collection("Funkcja liniowa").getDocuments { (querySnapshot, error) in
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
    }
    
    @IBAction func answerButtonPressed(_ sender: UIButton) {
        
        nextQuestion()
        
        Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(updateUI), userInfo: nil, repeats: false)
        
        let userAnswer = sender.currentTitle!
        
   //     let checkedAnswer = testBrain.checkAnswer(userAnswer: userAnswer)
   //     score = testBrain.score
        
   //     if testBrain.lastQuestion() {
   //         self.performSegue(withIdentifier: C.resultSegue, sender: self)
   //     } else {
   //         testBrain.nextQuestion()
   //     }
        
   //     Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: //#selector(updateUI), userInfo: nil, repeats: false)
        
    }
    
   // @objc func updateUI() {
  //      questionLabel.text = testBrain.getQuestionText()
        
  //      progressBar.progress = testBrain.getProgress()
        
  //      let aAnswer = testBrain.getAAnswersText()
    //    aButton.setTitle(aAnswer, for: .normal)
        
   //     let bAnswer = testBrain.getBAnswersText()
   //     bButton.setTitle(bAnswer, for: .normal)
        
  //      let cAnswer = testBrain.getCAnswersText()
   //     cButton.setTitle(cAnswer, for: .normal)
        
 //       let dAnswer = testBrain.getDAnswersText()
 //       dButton.setTitle(dAnswer, for: .normal)
 //   }
    
 //   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
  //      if segue.identifier == C.resultSegue {}
  //      let destinationVC = segue.destination as! ResultViewController
  //      destinationVC.score = score
  //      destinationVC.questions = testBrain.numberOfQuestions()
  //  }
}
