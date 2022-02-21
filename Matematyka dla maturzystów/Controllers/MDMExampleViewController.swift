//
//  ExampleViewController.swift
//  Matematyka dla maturzystów
//
//  Created by Paulina Gnas on 17/02/2022.
//

import Foundation
import WebKit
import Firebase

class MDMExampleViewController: UIViewController {
    
    let storage = Storage.storage()
    var courseName: String = "przyklady/p1-T-2"

    
    let firebaseBrain = FirebaseBrain()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        firebaseBrain.downloadLecture(myName: courseName) {
            self.loadMyWebKit()
        }
    }
    
    func loadMyWebKit() {
        if let webView = firebaseBrain.createWebView(withFrame: self.view.bounds) {
            self.view.addSubview(webView)
        }
    }
}
