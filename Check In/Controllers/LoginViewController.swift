//
//  LoginViewController.swift
//  Check In
//
//  Created by Saundra Castaneda on 2/22/18.
//  Copyright © 2018 DePaul University. All rights reserved.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {
    let loginToList = "LoginToList"
    
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    @IBAction func loginDidTouch(_ sender: Any) {
        performSegue(withIdentifier: loginToList, sender: nil)
        Auth.auth().signIn(withEmail: emailField.text!, password: passwordField.text!)
    }
    
    @IBAction func signUpDidTouch(_ sender: Any) {
        let alert = UIAlertController(title: "Register",
                                      message: "Register",
                                      preferredStyle: .alert)
        
        let saveAction = UIAlertAction(title: "Save",
                                       style: .default) { action in
            // 1
            let emailAlertField = alert.textFields![0]
            let passwordAlertField = alert.textFields![1]
            
            // 2
            Auth.auth().createUser(withEmail: emailAlertField.text!,
                                       password: passwordAlertField.text!) { user, error in
                if error == nil {
                    // 3
                    Auth.auth().signIn(withEmail: emailAlertField.text!,
                                           password: passwordAlertField.text!)
                }
            }
        }
        
        let cancelAction = UIAlertAction(title: "Cancel",
                                         style: .default)
        
        alert.addTextField { textEmail in
            textEmail.placeholder = "Enter your email"
        }
        
        alert.addTextField { textPassword in
            textPassword.isSecureTextEntry = true
            textPassword.placeholder = "Enter your password"
        }
        
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        Auth.auth().addStateDidChangeListener() { auth, user in
            // 2
            if user != nil {
                // 3
                self.performSegue(withIdentifier: self.loginToList, sender: nil)
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension LoginViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailField {
            passwordField.becomeFirstResponder()
        }
        if textField == passwordField {
            textField.resignFirstResponder()
        }
        return true
    }
    
}
