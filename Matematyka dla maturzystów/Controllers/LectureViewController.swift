	//
//  LectureViewController.swift
//  Matematyka dla maturzystów
//
//  Created by Paulina Gnas on 28/01/2022.
//

import UIKit
import WebKit
import Firebase


class LectureViewController: UIViewController
{
  //  @IBOutlet weak var webView: WKWebView!
  //  @IBOutlet weak var webView: WKWebView!
    
    let storage = Storage.storage()
    var myUrl: URL?
    
    var nazwaKursu: String = "Logika i zbiory"
    
 //   var kursType = "wyklady/"
//    var myName = ""
    
    
    let firebaseBrain = FirebaseBrain()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
     //   myName = kursType+nazwaKursu
        firebaseBrain.downloadLecture(myName: getCName()) {
            self.loadMyWebKit()
        }
    }
    func getCName() -> String {
        return  C.lecture + nazwaKursu
    }
        
    //    firebaseBrain.downloadLecture(name: myName) {
       //     self.displayWebView()
     //   }
        
   //     downloadLecture(name: myName) {
     //       self.displayWebView()
       // }
    
    func loadMyWebKit() {
        if let webView = firebaseBrain.createWebView(withFrame: self.view.bounds) {
            self.view.addSubview(webView)
        }
    }
    
  //  private func createWebView(withFrame frame: CGRect) -> WKWebView? {
   //     let webView = WKWebView(frame: frame)
  //      webView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
  //      if myUrl != nil {
  //          let request = URLRequest(url: myUrl!)
  //          webView.load(request)
   //         return webView
   //     }

   //     return nil
   // }
    
 //   private func displayWebView() {
 //       if let webView = self.createWebView(withFrame: self.view.bounds) {
 //           self.view.addSubview(webView)
 //       }
 //   }
    
  //  func downloadLecture(name: String, fishished: @escaping () -> Void) {
        
   //     let pathReference = storage.reference(withPath: "wyklady/\(myName).pdf")
        
   //     pathReference.downloadURL { url, error in
    //        if let error  = error {
    //            print(" \(error)")
    //            fishished()
    //        } else {
    //            self.myUrl = url
    //            print("zzzzzzzzzzzzzzz \(url!)")
    //            fishished()
    //        }
    //    }
   // }
}
