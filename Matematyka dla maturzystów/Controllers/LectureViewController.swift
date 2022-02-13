	//
//  LectureViewController.swift
//  Matematyka dla maturzystów
//
//  Created by Paulina Gnas on 28/01/2022.
//

import UIKit
import WebKit

class LectureViewController: UIViewController
{
  //  @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var webView: WKWebView!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
    //    self.displayWebView()
        displayWebView()
    }
    private func resourceUrl(forFileName fileName: String) -> URL? {
        if let resourceUrl = Bundle.main.url(forResource: fileName, withExtension: "pdf") {
            return resourceUrl
        }
        return nil
    }
    func displayWebView() {
        if let resourceUrl = self.resourceUrl(forFileName: "Logika i zbiory") {
            webView.loadFileURL(resourceUrl, allowingReadAccessTo: resourceUrl)
        }
    }
    
   // private func createWebView(withFrame frame: CGRect) -> WKWebView? {
  //      let webView = WKWebView(frame: frame)
  //      webView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
  //      if let resourceUrl = self.resourceUrl(forFileName: "zad") {
  //          webView.loadFileURL(resourceUrl, allowingReadAccessTo: resourceUrl)
            
  //          return webView
  //      }
  //      return nil
  //  }
    
 // //  private func displayWebView() {
  //      if let webView = self.createWebView(withFrame: self.view.bounds) {
  //          self.view.addSubview(webView)
   //     }
  //  }
}
