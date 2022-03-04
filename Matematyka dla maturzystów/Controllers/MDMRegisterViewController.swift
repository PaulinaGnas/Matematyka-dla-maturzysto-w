//
//  RegisterViewController.swift
//  Matematyka dla maturzystów
//
//  Created by Paulina Gnas on 13/11/2021.
//

import UIKit
import Firebase

class MDMRegisterViewController: UIViewController {
    @IBOutlet weak var emailLabel: UITextField!
    @IBOutlet weak var passwordLabel: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    @IBAction func registerButtonPressed(_ sender: UIButton) {
        if let email = emailLabel.text, let password = passwordLabel.text {
            Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                if let e = error {
                    
                    let dialogMessage = UIAlertController(title: "Confirm", message: e.localizedDescription, preferredStyle: .alert)
                    let ok = UIAlertAction(title: "OK", style: .default) { (action) -> Void in
                    }
                    dialogMessage.addAction(ok)
                    self.present(dialogMessage, animated: true, completion: nil)
                    
                } else {
                    self.performSegue(withIdentifier: C.regToMenuSegue, sender: self)
                }
            }
        }
    }
}
