//
//  MDMProfileVievController.swift
//  Matematyka dla maturzystów
//
//  Created by Paulina Gnas on 28/02/2022.
//

import Foundation
import UIKit
import Firebase

class MDMProfileViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    var userName: String?
    let db = Firestore.firestore()

    var allCourses: [String] = [] // Tablica z nazwami kursow potrzebna do kolekcji  - z MenuVC
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Twój profil"
        loadProfileData()
        tableView.dataSource = self
        tableView.delegate = self
    }
    //    Wczytuje dana poprawnie w postaci
    //    proba 1 => ["liczba pytań": 2, "wynik w procentach": 50.0% (1/2), "wynik": 1]
    
    var kurs = [Wynik]()
    
    func loadProfileData() {
        var nazwa_kursu = ""
        var ogolny_opis: [String] = []
        for courseNumber in allCourses {
            db.collection("usersScores").document(userName!).collection(courseNumber).getDocuments {(querySnapshot, error) in
                if let e = error {
                    print("Error getting dosc from Firebase: \(e)")
                } else {
                    if let snapshotDocuments = querySnapshot?.documents {
//                        print(courseNumber)
                        nazwa_kursu = courseNumber
                        for doc in snapshotDocuments {
                            let data = doc.data()
                            if let procent = data["wynik w procentach"] as? String{
                                let opis = "\(doc.documentID) => \(procent)"
                                ogolny_opis.append(opis)
//                                print("\(doc.documentID) => \(procent)")
//                                print("\(doc.documentID) => \(wynik)")
                            }
                        }
                        self.kurs.append(Wynik(nazwaKategori: nazwa_kursu, opis_wyniku: ogolny_opis))
                        ogolny_opis = []
                        DispatchQueue.main.async {
                            self.tableView.reloadData()
                        }
//                        print(self.kurs)
                    }
                }
            }
        }
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return kurs.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 40))
        view.backgroundColor = .cyan
        view.layer.cornerRadius = view.frame.size.height / 5
        
        let lbl = UILabel(frame: CGRect(x: 15, y: 0, width: view.frame.width-15, height: 40))
        lbl.font = UIFont.systemFont(ofSize: 20)
        lbl.textAlignment = .center
        lbl.text = kurs[section].nazwaKategori
        view.addSubview(lbl)
        return view
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return kurs[section].opis_wyniku?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = kurs[indexPath.section].opis_wyniku?[indexPath.row]
        cell.layer.cornerRadius = cell.frame.size.height / 5
        cell.backgroundColor = .gray
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
}
class Wynik {
    let nazwaKategori: String?
    let opis_wyniku: [String]?
    
    init(nazwaKategori: String, opis_wyniku: [String]) {
        self.nazwaKategori = nazwaKategori
        self.opis_wyniku = opis_wyniku
    }
}
//extension MDMProfileViewController: UITableViewDelegate {
//
//}

//extension MDMProfileViewController: UITableViewDataSource {
//
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return kurs.count
//    }
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return kurs[section].opis_wyniku?.count ?? 0
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
//        cell.textLabel?.text = kurs[indexPath.section].opis_wyniku[indexPa]
//    }
//}
