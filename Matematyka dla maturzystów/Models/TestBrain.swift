//
//  Questions.swift
//  Matematyka dla maturzystów
//
//  Created by Paulina Gnas on 23/11/2021.
//

import Foundation

struct TestBrain {
    var questionNumber = 0
    var score = 0
    var progres = 0
    
    let test = [
        Question(q: "pytanie1", a: "dupa1.1", b: "dupa1.2", c: "dupa1.3", d: "dupa1.4", g: "dupa1.2"),
        Question(q: "pytanie2", a: "dupa2.1", b: "dupa2.2", c: "dupa2.3", d: "dupa2.4", g: "dupa2.4"),
        Question(q: "pytanie3", a: "dupa3.1", b: "dupa3.2", c: "dupa3.3", d: "dupa3.4", g: "dupa3.2"),
        Question(q: "pytanie4", a: "dupa4.1", b: "dupa4.2", c: "dupa4.3", d: "dupa4.4", g: "dupa4.3"),
        Question(q: "pytanie5", a: "dupa5.1", b: "dupa5.2", c: "dupa5.3", d: "dupa5.4", g: "dupa5.1")]
    
    func getQuestionText() -> String {
        return test[questionNumber].question
    }
    
    func getAAnswersText() -> String {
        return test[questionNumber].aAnswer
    }
    func getBAnswersText() -> String {
        return test[questionNumber].bAnswer
    }
    func getCAnswersText() -> String {
        return test[questionNumber].cAnswer
    }
    func getDAnswersText() -> String {
        return test[questionNumber].dAnswer
    }
    
    func getProgress() -> Float {
        return Float(questionNumber) / Float(test.count)
    }
    
    func getScore() -> Int {
        return score
    }
    
    mutating func checkAnswer(userAnswer: String) -> Bool {
        if userAnswer == test[questionNumber].goodAnswer {
            score += 1
            return true
        } else {
            return false
        }
    }
    
    mutating func nextQuestion() {
        
        if questionNumber + 1 < test.count {
            
            questionNumber += 1
        } else {
            questionNumber = 0
            
        }
    }
    
    mutating func lastQuestion() -> Bool {
        if questionNumber + 1 == test.count {
            score = 0
            return true
        } else {
            return false
        }
    }
    
    func numberOfQuestions() -> Int {
        return test.count
    }
}
