//
//  LectureViewController.swift
//  Matematyka dla maturzystów
//
//  Created by Paulina Gnas on 28/01/2022.
//

import UIKit
import WebKit
import Firebase


class MDMLectureViewController: UIViewController
{
    let storage = Storage.storage()
    var lectureName: String?
    let firebaseBrain = FirebaseBrain()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        firebaseBrain.downloadLecture(myName: lectureName!) {
            self.loadMyWebKit()
        }
    }
    
    func loadMyWebKit() {
        if let webView = firebaseBrain.createWebView(withFrame: self.view.bounds) {
            self.view.addSubview(webView)
        }
    }
}
