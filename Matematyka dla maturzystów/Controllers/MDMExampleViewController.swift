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
    var exampleName: String?
    let firebaseBrain = FirebaseBrain()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        firebaseBrain.downloadLecture(myName: exampleName!) {
            self.loadMyWebKit()
        }
    }
    
    func loadMyWebKit() {
        if let webView = firebaseBrain.createWebView(withFrame: self.view.bounds) {
            self.view.addSubview(webView)
        }
    }
}
