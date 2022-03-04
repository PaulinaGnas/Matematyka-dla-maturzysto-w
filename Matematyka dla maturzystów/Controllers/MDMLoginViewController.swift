//
//  LoginViewController.swift
//  Matematyka dla maturzystów
//
//  Created by Paulina Gnas on 13/11/2021.
//

import UIKit
import Firebase

class MDMLoginViewController: UIViewController
{
    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func loginButtonPressed(_ sender: UIButton) {
        if let email = loginTextField.text, let password = passwordTextField.text {
            Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
                if let e = error {
                        let dialogMessage = UIAlertController(title: "Confirm", message: e.localizedDescription, preferredStyle: .alert)
                        let ok = UIAlertAction(title: "OK", style: .default) { (action) -> Void in
                        }
                        dialogMessage.addAction(ok)
                        self.present(dialogMessage, animated: true, completion: nil)
                } else {
                    self.performSegue(withIdentifier: C.logToMenuSegue, sender: self)
                }
            }
        }
    }
}
