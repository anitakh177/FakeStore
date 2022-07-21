//
//  SignUpViewController.swift
//  FakeShop
//
//  Created by anita on 21.07.2022.
//

import UIKit
import FirebaseAuth
import Firebase

class SignUpViewController: UIViewController {
    private let signupView = SignUpView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupSignUpView()
        signupView.signUpButton.addTarget(self, action: #selector(signUpTapped), for: .touchUpInside)
    }
    // MARK: - Layout
    private func setupSignUpView() {
        view.addSubview(signupView)
        //signupView.backgroundColor = .red
        signupView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            signupView.widthAnchor.constraint(equalTo: view.widthAnchor),
            signupView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            signupView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            signupView.topAnchor.constraint(equalTo: view.topAnchor, constant: 170),
            //signupView.bottomAnchor.constraint(equalTo: view.bottomAnchor,constant: -100),
            signupView.heightAnchor.constraint(equalToConstant: 450)
        ])
        signupView.errorLabel.alpha = 0
    }
    
    // MARK: - Helper Methods
    
  private func validateFields() -> String? {
        
        // check if all field are filled in
        if signupView.firstNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            signupView.lastNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            signupView.emailField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            signupView.passwordField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            
            return "Please fill in all fields."
        }
        // check if password secure
        let cleanedPassword = signupView.passwordField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        if Utilities.isPasswordValid(cleanedPassword) == false {
            return "Please make sure your passsword is at least 8 characters, contains a special character and a number."
        }
        return nil
    }
    
    @objc func signUpTapped() {
        
        // validate the fields
        
        let error = validateFields()
        
        if error != nil {
            showError(error!)
        } else {
            //create cleaned versions of the data
            let firstName = signupView.firstNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let lastName = signupView.lastNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let email = signupView.emailField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = signupView.passwordField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            // create the user
            Auth.auth().createUser(withEmail: email, password: password) { result, error in
                
                // check for errors
                if error != nil {
                    self.showError("Error creating user")
                } else {
                    
                    // user was created succsesfully, now store the first name and last name
                    let db = Firestore.firestore()
                    
                    db.collection("users").addDocument(data: ["firstName": firstName, "lastName": lastName, "uid": result!.user.uid]) { (error) in
                        
                        if error != nil {
                            self.showError("Error saving user data")
                        }
                        
                    }
                    //transition to the main screen
                    self.trasitionToMainScreen()
                }
            }
        }
        
        
    }
    
    private func showError(_ message: String) {
        
        signupView.errorLabel.text = message
        signupView.errorLabel.alpha = 1
    }
    
    private func trasitionToMainScreen() {
       // let mainVC = MainViewController()
        //view.window?.rootViewController = mainVC
        //view.window?.makeKeyAndVisible()
    }
 
}

