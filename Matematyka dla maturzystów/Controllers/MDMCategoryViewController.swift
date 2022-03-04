//
//  File.swift
//  Matematyka dla maturzystów
//
//  Created by Paulina Gnas on 21/11/2021.
//

import UIKit
import Firebase

class MDMCategoryViewController: UIViewController {
  
    let db = Firestore.firestore()
    var allCategories: [String] = []
    var courseDescription: String?
    var lectureName: String?
    var exampleName: String?
    var categoryName: String?

    @IBOutlet weak var categoryLabel: UILabel!
    
    @IBAction func logOutPressed(_ sender: UIBarButtonItem) {
        do {
            try Auth.auth().signOut()
            navigationController?.popToRootViewController(animated: true)

        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
    }
    @IBAction func testButtonPressed(_ sender: UIButton) {
        performSegue(withIdentifier: C.testSegue, sender: self)
    }
    
    @IBAction func wykladyButtonPressed(_ sender: UIButton) {
        performSegue(withIdentifier: C.lectureSegue, sender: self)
    }
    
    @IBAction func przykladyButtonPressed(_ sender: UIButton) {
        performSegue(withIdentifier: C.exampleIdentifier, sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        categoryLabel.text = courseDescription
        self.navigationItem.title = categoryName
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == C.lectureSegue {
            let destinationVC = segue.destination as! MDMLectureViewController
            destinationVC.lectureName = lectureName
            
        } else if segue.identifier == C.exampleIdentifier {
            let destinationVC = segue.destination as! MDMExampleViewController
            destinationVC.exampleName = exampleName
            
        } else if segue.identifier == C.testSegue {
            let destinationVC = segue.destination as! MDMTestViewController
            destinationVC.courseName = categoryName
        }
    }
}
