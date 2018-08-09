/**
* Copyright (c) 2015-present, Parse, LLC.
* All rights reserved.
*
* This source code is licensed under the BSD-style license found in the
* LICENSE file in the root directory of this source tree. An additional grant
* of patent rights can be found in the PATENTS file in the same directory.
*/

import UIKit
import Parse

class ViewController: UIViewController {
    var activityIndicator = UIActivityIndicatorView()
    var signupMode = true
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var emailTF: UITextField!
    func alertController ( _ title : String , _ message : String){
        let alert = UIAlertController(title: title , message: message , preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action) in
            self.dismiss(animated: true, completion: nil)
        }))
        self.present(alert, animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    @IBOutlet weak var signInOutlet: UIButton!
    
    @IBOutlet weak var logInOutlet: UIButton!
    
    @IBOutlet weak var messageLabel: UILabel!
    @IBAction func signInAction(_ sender: Any) {
        if emailTF.text == "" || passwordTF.text == "" {
            alertController("Error in this form", "please enter your email and password")
        }
        else
        {
            activityIndicator =  UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
            activityIndicator.center = self.view.center
            activityIndicator.hidesWhenStopped = true
            activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
            view.addSubview(activityIndicator)
            activityIndicator.startAnimating()
            UIApplication.shared.beginIgnoringInteractionEvents()
            if signupMode{
                let user = PFUser()
                user.username = emailTF.text
                user.email = emailTF.text
                user.password = "0191541517"
                user.signUpInBackground { (success, error) in
                    self.activityIndicator.stopAnimating()
                    UIApplication.shared.endIgnoringInteractionEvents()
                    if error != nil {
                        var displayError = ""
                        if let errorMessage = ((error as Any) as! NSError).userInfo["error"] as? String {
                            displayError = errorMessage
                        }
                        self.alertController("Sign Up Error", displayError)
                        
                    }
                    else {
                        print("sign up successfully")
                        self.performSegue(withIdentifier: "toSecondViewController", sender: self)
                    }
                }
            }
            else {
                PFUser.logInWithUsername(inBackground: emailTF.text!, password: passwordTF.text!) { (user, error) in
                    self.activityIndicator.stopAnimating()
                    UIApplication.shared.endIgnoringInteractionEvents()
                    if error != nil {
                        var displayError = ""
                        if let errorMessage = ((error as Any) as! NSError).userInfo["error"] as? String {
                            displayError = errorMessage
                        }
                        self.alertController("LogIn Error", displayError)
                        
                    }
                    else {
                        print("LogIn successfully")
                        self.performSegue(withIdentifier: "toSecondViewController", sender: self)
                    }
                
                }
            }
        }
        
    }
    override func viewDidAppear(_ animated: Bool) {
        if PFUser.current() != nil {
            performSegue(withIdentifier: "toSecondViewController", sender: self)
            self.navigationController?.navigationBar.isHidden = true
        }
    }
    @IBAction func logInAction(_ sender: Any) {
        if signupMode {
            signInOutlet.setTitle("Log In", for: [])
            logInOutlet.setTitle("Sign Up", for: [])
            messageLabel.text = "Don't have an account?"
            signupMode = false
        }
        else{
            signInOutlet.setTitle("Sign Up", for: [])
            logInOutlet.setTitle("Log In", for: [])
            messageLabel.text = "Already have an account?"
            signupMode = true
        }
    }
    
    
    
    
    
    
    
    
}
