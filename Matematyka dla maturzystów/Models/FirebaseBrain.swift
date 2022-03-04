//
//  FirebaseBrain.swift
//  Matematyka dla maturzystów
//
//  Created by Paulina Gnas on 17/02/2022.
//

import Foundation
import Firebase
import WebKit


class FirebaseBrain {
    let storage = Storage.storage()
    var myUrl: URL?
    
    func downloadLecture(myName: String, fishished: @escaping () -> Void) {
        
        let pathReference = storage.reference(withPath: myName)
        
        pathReference.downloadURL { url, error in
            if let error  = error {
                print("Błąd w pobieraniu danych z Firebase \(error)")
                fishished()
            } else {
                self.myUrl = url
                fishished()
            }
        }
    }
    
    func createWebView(withFrame frame: CGRect) -> WKWebView? {
          let webView = WKWebView(frame: frame)
          webView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
          
          if myUrl != nil {
              let request = URLRequest(url: myUrl!)
              webView.load(request)
              return webView
          }
          return nil
      }
}
