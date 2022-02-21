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
    var categoryName: String?

    @IBOutlet weak var categoryLabel: UILabel!
    
    @IBAction func testButtonPressed(_ sender: UIButton) {
        performSegue(withIdentifier: C.testSegue, sender: self)
    }
    
    @IBAction func wykladyButtonPressed(_ sender: UIButton) {
        performSegue(withIdentifier: C.lectureSegue, sender: self)
    }
    
    @IBAction func przykladyButtonPressed(_ sender: UIButton) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        categoryLabel.text = courseDescription
        self.navigationItem.title = categoryName
    }
    


    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == C.testSegue {
//            let destinationVC = segue.destination as! MDMTestViewController
//        //    destinationVC.cName = categoryName
//        }
//        if segue.identifier == C.lectureSegue {
//            let destinationVC = segue.destination as! MDMLectureViewController
//        }
//    }

}
