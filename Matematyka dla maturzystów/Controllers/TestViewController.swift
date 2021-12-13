//
//  TestViewController.swift
//  Matematyka dla maturzystów
//
//  Created by Paulina Gnas on 21/11/2021.
//

import UIKit

class TestViewController: UIViewController {
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var aButton: UIButton!
    @IBOutlet weak var bButton: UIButton!
    @IBOutlet weak var cButton: UIButton!
    @IBOutlet weak var dButton: UIButton!
    @IBOutlet weak var progressBar: UIProgressView!
    
    
    var testBrain = TestBrain()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Test"
        navigationItem.hidesBackButton = true
        
        updateUI()
    }
    var score = 0
    
    @IBAction func answerButtonPressed(_ sender: UIButton) {
        
        let userAnswer = sender.currentTitle!
        
        let checkedAnswer = testBrain.checkAnswer(userAnswer: userAnswer)
        score = testBrain.score
        
        if testBrain.lastQuestion() {
            self.performSegue(withIdentifier: C.resultSegue, sender: self)
        } else {
            testBrain.nextQuestion()
        }
        
        Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(updateUI), userInfo: nil, repeats: false)
        
    }
    
    @objc func updateUI() {
        questionLabel.text = testBrain.getQuestionText()
        
        progressBar.progress = testBrain.getProgress()
        
        let aAnswer = testBrain.getAAnswersText()
        aButton.setTitle(aAnswer, for: .normal)
        
        let bAnswer = testBrain.getBAnswersText()
        bButton.setTitle(bAnswer, for: .normal)
        
        let cAnswer = testBrain.getCAnswersText()
        cButton.setTitle(cAnswer, for: .normal)
        
        let dAnswer = testBrain.getDAnswersText()
        dButton.setTitle(dAnswer, for: .normal)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == C.resultSegue {}
        let destinationVC = segue.destination as! ResultViewController
        destinationVC.score = score
        destinationVC.questions = testBrain.numberOfQuestions()
    }
}
