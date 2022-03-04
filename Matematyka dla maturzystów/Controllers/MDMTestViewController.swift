//
//  TestViewController.swift
//  Matematyka dla maturzystów
//
//  Created by Paulina Gnas on 18/02/2022.
//

import Foundation
import UIKit
import Firebase
import WebKit

class MDMTestViewController: UIViewController {
    @IBOutlet weak var tempView: UIView!
    
    let db = Firestore.firestore()
    var test: [Exercise] = []
    var questionNumber = 0
    var score = 0
    var progress = 0.0
    var courseName: String?
    let storage = Storage.storage()
    var myUrl: URL?
    var tries: Int?
    let userName = Auth.auth().currentUser?.email
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        getNumberOfTries()
        loadTest()
    }
    
    func getNumberOfTries() {
            if userName != nil {
                db.collection(C.usersScores).document(userName!).collection(courseName!).getDocuments { (querySnapshot, error) in
                    if let e = error {
                        print("There was an issue with retrieving data from Firestore. \(e)")
                    } else {
                        if let snapshotDocuments = querySnapshot?.documents {
                            self.tries = snapshotDocuments.count + 1
                        }
                    }
                }
            }
        }
    
    private func createWebView(withFrame frame: CGRect) -> WKWebView? {
        let webView = WKWebView(frame: frame)
        webView.scrollView.contentMode = .scaleAspectFit
        webView.scrollView.isScrollEnabled = false
        
        if myUrl != nil {
            let request = URLRequest(url: myUrl!)
            webView.load(request)
            return webView
        }
        return nil
    }
    
    func getProgress() -> Float {
        return Float(questionNumber) / Float(test.count)
    }
    
    private let progressView: UIProgressView = {
        let progressView = UIProgressView(progressViewStyle: .bar)
        progressView.progressTintColor = .cyan
        progressView.trackTintColor = .gray
        return progressView
    }()
    
    private func displayWebView() {
        if let webView = self.createWebView(withFrame: self.view.bounds) {
            self.view.addSubview(tempView)
            tempView.addSubview(webView)
            
            webView.frame = tempView.bounds
            webView.underPageBackgroundColor = .white
            
            webView.addSubview(progressView)
            progressView.frame = CGRect(x: 60, y: 40, width: 300, height: 55)
            progressView.setProgress(getProgress(), animated: true)

            let offset = 16.0
            
            if let webButton = self.createButton(bx: test[questionNumber].buttonXcoord+offset, by: test[questionNumber].button1Ycoord+offset, bw: test[questionNumber].buttonWidth, bh: test[questionNumber].buttonHeight) {
                webButton.tag = 1
                webView.addSubview(webButton)
            }
            
            if let webButton = self.createButton(bx: test[questionNumber].buttonXcoord+offset, by: test[questionNumber].button2Ycoord+offset, bw: test[questionNumber].buttonWidth, bh: test[questionNumber].buttonHeight) {
                webButton.tag = 2
                webView.addSubview(webButton)
            }
            
            if let webButton = self.createButton(bx: test[questionNumber].buttonXcoord+offset, by: test[questionNumber].button3Ycoord+offset, bw: test[questionNumber].buttonWidth, bh: test[questionNumber].buttonHeight) {
                webButton.tag = 3
                webView.addSubview(webButton)
            }
            
            if let webButton = self.createButton(bx: test[questionNumber].buttonXcoord+offset, by: test[questionNumber].button4Ycoord+offset, bw: test[questionNumber].buttonWidth, bh: test[questionNumber].buttonHeight) {
                webButton.tag = 4
                webView.addSubview(webButton)
            }
        }
    }
    
    
    func createButton(bx: CGFloat, by: CGFloat, bw: CGFloat, bh: CGFloat) -> UIButton? {
        
        let multiplier = 838 / (self.view.bounds.size.width - 16)
        
        let webButton = UIButton(frame: CGRect(x: bx/multiplier, y: by/multiplier, width: bw/multiplier, height: bh/multiplier))
        
        webButton.backgroundColor = UIColor.clear
        
        let tapGesture = UITapGestureRecognizer.init(target: self, action: #selector(didTapAnswerButton(sender:)))
        
        webButton.addGestureRecognizer(tapGesture)
        
        return webButton
    }
    
    
    @IBAction func didTapAnswerButton(sender: UITapGestureRecognizer) {
        
        let userAnswer = sender.view?.tag
        
        checkAnswer(userAnswer: userAnswer!, goodAnswer: test[questionNumber].goodAnswer)
        
        if lastQuestion() {
            performSegue(withIdentifier: C.resultSegue, sender: self)
            questionNumber = 0
            score = 0
            progress = 0
        } else {
            nextQuestion()
        }
        let t = test[questionNumber].fileName
        updateUI(file: t)
    }
    
    
    func checkAnswer(userAnswer: Int, goodAnswer: Int) {
        if userAnswer == goodAnswer {
            score += 1
        }
    }
    func nextQuestion() {
        if questionNumber + 1 < test.count {
            questionNumber += 1
        } else {
            questionNumber = 0
        }
    }
    func lastQuestion() -> Bool {
        if questionNumber + 1 == test.count {
            return true
        } else {
            return false
        }
    }
    
    func downloadLecture(nazwaPliku: String, fishished: @escaping () -> Void) {
        
        let pathReference = storage.reference(withPath: nazwaPliku)
        
        pathReference.downloadURL { url, error in
            if let error  = error {
                print("Błąd w pobieraniu danych z Firebase \(error)")
                fishished()
            } else {
                self.myUrl = url
                fishished()
            }
        }
    }
    
    @objc func updateUI(file: String) {
        self.downloadLecture(nazwaPliku: file) {
            self.displayWebView()
        }
    }
    
    func loadTest() {
        db.collection(courseName!).getDocuments { (querySnapshot, error) in
            if let e = error {
                print("There was an issue with retrieving data from Firestore. \(e)")
            } else {
                if let snapshotDocuments = querySnapshot?.documents {
                    for doc in snapshotDocuments {
                        let data = doc.data()
                        if let answer = data[C.Test.answer] as? Int,
                           let name = data[C.Test.fileName] as? String,
                           let buttonXc = data[C.Test.buttonXcoord] as? CGFloat,
                           let button1Yc = data[C.Test.button1Ycoord] as? CGFloat,
                           let button2Yc = data[C.Test.button2Ycoord] as? CGFloat,
                           let button3Yc = data[C.Test.button3Ycoord] as? CGFloat,
                           let button4Yc = data[C.Test.button4Ycoord] as? CGFloat,
                           let buttonW = data[C.Test.buttonWidth] as? CGFloat,
                           let buttonH = data[C.Test.buttonHeight] as? CGFloat {
                            let testInfo = Exercise(exNumber: doc.documentID, goodAnswer: answer, fileName: name, buttonXcoord: buttonXc, button1Ycoord: button1Yc, button2Ycoord: button2Yc, button3Ycoord: button3Yc, button4Ycoord: button4Yc, buttonHeight: buttonH, buttonWidth: buttonW)
                            
                            self.test.append(testInfo)
                            
                            DispatchQueue.main.async {
                                self.updateUI(file: self.test[self.questionNumber].fileName)
                            }
                        }
                    }
                }
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == C.resultSegue {}
        let destinationVC = segue.destination as! MDMResultViewController
        destinationVC.score = score
        destinationVC.questions = test.count
        destinationVC.courseName = courseName
        destinationVC.tries = tries
    }
}
