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
    var myUrl: URL?
    
    var nazwaKursu: String = "wyklady/Logika i zbiory"
        
    let firebaseBrain = FirebaseBrain()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        firebaseBrain.downloadLecture(myName: nazwaKursu) {
            self.loadMyWebKit()
        }
    }
    
    func loadMyWebKit() {
        if let webView = firebaseBrain.createWebView(withFrame: self.view.bounds) {
            self.view.addSubview(webView)
        }
    }
}
