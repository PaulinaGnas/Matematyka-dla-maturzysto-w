//
//  ExampleViewController.swift
//  Matematyka dla maturzystów
//
//  Created by Paulina Gnas on 17/02/2022.
//

import Foundation
import WebKit
import Firebase

class ExampleViewController: UIViewController {
    
    let storage = Storage.storage()
    var courseName: String = "GP_wstep-przyklady"

    
    let firebaseBrain = FirebaseBrain()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        firebaseBrain.downloadLecture(myName: getCName()) {
            self.loadMyWebKit()
        }
    }
    
    func getCName() -> String {
        return C.example + courseName
    }
    
    func loadMyWebKit() {
        if let webView = firebaseBrain.createWebView(withFrame: self.view.bounds) {
            self.view.addSubview(webView)
        }
    }
}
