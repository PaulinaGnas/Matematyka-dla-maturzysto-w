//
//  Constans.swift
//  Matematyka dla maturzystów
//
//  Created by Paulina Gnas on 23/11/2021.
//

import Foundation

struct C {
    static let resultSegue = "resultSeque"
    static let returnSegue = "returnSegue"
    static let testSegue = "testSegue"
    static let lectureSegue = "lectureSegue"
    static let categorySegue = "categorySegue"
    static let exampleIdentifier = "exampleIdentifier"
    
    static let logToMenuSegue = "LogToMenuSegue"
    static let regToMenuSegue = "regToMenuSegue"
    
    static let menuToProfileSegue = "menuToProfileSegue"
    
    static let cellIdentifier = "ReusableCell"
    static let cellNibName = "CourseCell"
    
    static let pCellNibName = "ProfileCellTableViewCell"
    static let pCellIdentifier = "ProfileReusableCell"
    
    static let usersScores = "usersScores"
    
    struct Category {
        static let categories = "kategorie"
        static let courseInfo = "opis"
        static let lecturePath = "nazwaWykladu"
        static let examplePath = "nazwaPrzykladow"
    }
    
    struct FirebaseScore {
        static let firebaseScore = "wynik"
        static let firebaseQuestions = "liczba pytań"
        static let firebasePCT = "wynik w procentach"
    }
    
    struct Test {
        static let answer = "odp"
        static let fileName = "plik"
        static let buttonXcoord = "buttonXcoord"
        static let button1Ycoord = "button1Ycoord"
        static let button2Ycoord = "button2Ycoord"
        static let button3Ycoord = "button3Ycoord"
        static let button4Ycoord = "button4Ycoord"
        static let buttonWidth = "buttonWidth"
        static let buttonHeight = "buttonHeight"
    }
}
