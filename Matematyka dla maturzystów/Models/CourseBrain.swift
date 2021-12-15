//
//  CourseBrain.swift
//  Matematyka dla maturzystów
//
//  Created by Paulina Gnas on 15/12/2021.
//

import Foundation

struct CourseBrain {
    
    let courses = [Course(name: "Kurs 1", info: "Opis 1"),
                   Course(name: "Kurs 2", info: "Opis 2"),
                   Course(name: "Kurs 3", info: "Opis 3"),
                   Course(name: "Kurs 4", info: "Opis 4"),
                   Course(name: "Kurs 5", info: "Opis 5"),
                   Course(name: "Kurs 6", info: "Opis 6"),
                   Course(name: "Kurs 7", info: "Opis 7"),
                   Course(name: "Kurs 8", info: "Opis 8"),
                   Course(name: "Kurs 9", info: "Opis 9"),
                   Course(name: "Kurs 10", info: "Opis 10"),
                   Course(name: "Kurs 11", info: "Opis 11"),
                   Course(name: "Kurs 12", info: "Opis 12")
    ]
    
    func getName(index: Int) -> String {
        return courses[index].name
    }
    func getInfo(index: Int) -> String {
        return courses[index].info
    }
    func getNumber() -> Int {
        return courses.count
    }
}
