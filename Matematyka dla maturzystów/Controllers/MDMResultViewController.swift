//
//  ResultViewController.swift
//  Matematyka dla maturzystów
//
//  Created by Paulina Gnas on 21/11/2021.
//

import UIKit
import Firebase

class MDMResultViewController: UIViewController {
    
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var textLabel: UILabel!
    
    var score: Int?
    var questions: Int?
    var courseName: String?
    var tries: Int?
    let userName = Auth.auth().currentUser?.email
    let db = Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scoreLabel.text = "Twój wynik to \(score!)/\(questions!)"
        saveScore()
    }
    
    func calculateThePercentage() -> String {
        if score != nil, questions != nil {
            let pct = Float(score!) / Float(questions!) * 100
            return String("\(pct)%")
        } else {
            return("Bral wyniku")
        }
    }
    
    func getFullScore() -> String {
        if score != nil, questions != nil {
            return ("\(calculateThePercentage()) (\(score!)/\(questions!))")
        } else {
            return("Brak danych")
        }
    }
    
    func saveScore() {
        if userName != nil, score != nil, tries != nil {
            let docName = "próba \(tries!)"
            db.collection(C.usersScores).document(userName!).collection(courseName!).document(docName).setData([
                C.FirebaseScore.firebaseScore: score!,
                C.FirebaseScore.firebaseQuestions: questions!,
                C.FirebaseScore.firebasePCT: getFullScore()
                //                "wynik": score!,
//                "liczba pytań": questions!,
//                "wynik w procentach": getFullScore()
            ]) { err in
                if let err = err {
                    print("Error w zapisaniu wyniku \(err)")
                } else {
                    print("Document saved")
                }
            }
        } 
    }
    
    @IBAction func returnButtonPressed(_ sender: UIButton) {
        
        let viewControllers: [UIViewController] = self.navigationController!.viewControllers
        for aViewController in viewControllers {
            if aViewController is MDMCategoryViewController {
                self.navigationController!.popToViewController(aViewController, animated: true)
            }
        }
    }
}
