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
    
    let test: [Question] = []
    
    func getQuestionText() -> String {
        return test[questionNumber].question
    }
    
   // func getAAnswersText() -> String {
  //      return test[questionNumber].aAnswer
  //  }
  //  func getBAnswersText() -> String {
 //       return test[questionNumber].bAnswer
 //   }
 //  func getCAnswersText() -> String {/
 //       return test[questionNumber].cAnswer
   // }
  //  func getDAnswersText() -> String {
  //      return test[questionNumber].dAnswer
  //  }
    
 //   func getProgress() -> Float {
  //      return Float(questionNumber) / Float(test.count)
 //   }
    
 //   func getScore() -> Int {
//        return score
  //  }//
    
 //   mutating func checkAnswer(userAnswer: String) -> Bool {
 //       if userAnswer == test[questionNumber].goodAnswer {
 //           score += 1
  //          return true
 //       } else {
 //           return false
 //       }
 //   }
    
 //   mutating func nextQuestion() {
        
    //    if questionNumber + 1 < test.count {
            
    //        questionNumber += 1
   //     } else {
   //         questionNumber = 0
            
  //      }
  //  }
    
 //   mutating func lastQuestion() -> Bool {
//        if questionNumber + 1 == test.count {
//            score = 0
//            return true
//        } else {
//            return false
//        }
//    }
    
//    func numberOfQuestions() -> Int {
//        return test.count
//    }
}
