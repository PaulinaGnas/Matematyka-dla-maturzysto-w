//
//  ResultViewController.swift
//  Matematyka dla maturzystów
//
//  Created by Paulina Gnas on 21/11/2021.
//

import UIKit

class ResultViewController: UIViewController {
    
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var textLabel: UILabel!
    
    var score: Int?
    var questions: Int?
    var categoryName: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = categoryName
        scoreLabel.text = "Twój wynik to \(score!)/\(questions!)"
    }
    
    @IBAction func returnButtonPressed(_ sender: UIButton) {
        guard let navigationController = self.navigationController else { return }
        var navigationArray = navigationController.viewControllers // To get all UIViewController stack as Array
        navigationArray.remove(at: navigationArray.count - 2) // To remove previous UIViewController
        self.navigationController?.viewControllers = navigationArray
        
        self.navigationController?.popViewController(animated: true)
    }
}
