//
//  File.swift
//  Matematyka dla maturzystów
//
//  Created by Paulina Gnas on 21/11/2021.
//

import UIKit

class CategoryViewController: UIViewController {
  
    @IBOutlet weak var categoryLabel: UILabel!
    @IBAction func testButtonPressed(_ sender: UIButton) {
        performSegue(withIdentifier: C.testSegue, sender: self)
    }
    
    @IBAction func wykladyButtonPressed(_ sender: UIButton) {
    }
    
    @IBAction func przykladyButtonPressed(_ sender: UIButton) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        categoryLabel.text = categoryInfo
        self.navigationItem.title = categoryName
        
    }
    var categoryInfo: String?
    var categoryName: String?
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == C.testSegue {}
        let destinationVC = segue.destination as! TestViewController
        destinationVC.cName = categoryName
    }
}
