//
//  Question.swift
//  Matematyka dla maturzystów
//
//  Created by Paulina Gnas on 23/11/2021.
//

import Foundation

struct Question {
    let question: String
    let aAnswer: String
    let bAnswer: String
    let cAnswer: String
    let dAnswer: String
    let goodAnswer: String
    
    init(q: String, a: String, b: String, c: String, d: String, g: String) {
        question = q
        aAnswer = a
        bAnswer = b
        cAnswer = c
        dAnswer = d
        goodAnswer = g
    }
}
