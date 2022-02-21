//
//  File.swift
//  Matematyka dla maturzystów
//
//  Created by Paulina Gnas on 21/11/2021.
//

import UIKit
import Firebase

class MDMMenuViewController: UIViewController {
    
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    let db = Firestore.firestore()
    
    var allCourses: [String] = []
    var courseDescriptions: [Course] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadTest()
        tableView.dataSource = self
        tableView.register(UINib(nibName: C.cellNibName, bundle: nil), forCellReuseIdentifier: C.cellIdentifier)
        tableView.delegate = self
    }
    
    let courseBrain = CourseBrain()
    var indexNum: Int = 0
    
    
    func loadTest() {
        db.collection(C.Category.categories).getDocuments { (querySnapshot, error) in
            if let e = error {
                print("There was an issue with retrieving data from Firestore. \(e)")
            } else {
                if let snapshotDocuments = querySnapshot?.documents {
                    for doc in snapshotDocuments {
                        self.allCourses.append(doc.documentID)
                        let data = doc.data()
                        if let des = data[C.Category.cInfo] as? String {
                            
                            let cInfo = Course(name: doc.documentID, info: des)
                            self.courseDescriptions.append(cInfo)
                        }
                        DispatchQueue.main.async {
                            self.tableView.reloadData()
                        }
                    }
                }
            }
        }

    }
}

extension MDMMenuViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allCourses.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: C.cellIdentifier, for: indexPath) as! CourseCell
        
        cell.courseLabel.text = allCourses[indexPath.row]

        return cell
    }
}

extension MDMMenuViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        indexNum = indexPath.row
        performSegue(withIdentifier: C.categorySegue, sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == C.categorySegue {}
        let destinationVC = segue.destination as! MDMCategoryViewController
        destinationVC.courseDescription = courseDescriptions[indexNum].info
        destinationVC.categoryName = courseDescriptions[indexNum].name
    }
}

