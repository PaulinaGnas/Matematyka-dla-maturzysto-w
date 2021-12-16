//
//  File.swift
//  Matematyka dla maturzystów
//
//  Created by Paulina Gnas on 21/11/2021.
//

import UIKit

class MenuViewController: UIViewController {
    
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.register(UINib(nibName: C.cellNibName, bundle: nil), forCellReuseIdentifier: C.cellIdentifier)
        tableView.delegate = self
    }
    
    let courseBrain = CourseBrain()
    var indexNum: Int = 0
}

extension MenuViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        courseBrain.getNumber()
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: C.cellIdentifier, for: indexPath) as! CourseCell
        
        cell.courseLabel.text = courseBrain.getName(index: indexPath.row)
        
        return cell
    }
}

extension MenuViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        indexNum = indexPath.row
        performSegue(withIdentifier: C.categorySegue, sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == C.categorySegue {}
        let destinationVC = segue.destination as! CategoryViewController
        destinationVC.categoryInfo = courseBrain.getInfo(index: indexNum)
        destinationVC.categoryName = courseBrain.getName(index: indexNum)
    }
}

//override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    //if segue.identifier == C.resultSegue {}
    //let destinationVC = segue.destination as! ResultViewController
    //destinationVC.score = score
  //  destinationVC.questions = testBrain.numberOfQuestions()
//}
