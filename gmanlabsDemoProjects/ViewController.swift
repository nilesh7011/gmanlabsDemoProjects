//
//  ViewController.swift
//  gmanlabsDemoProjects
//
//  Created by m8nilesh on 30/05/24.
//

import UIKit
import AuthenticationServices
import SwiftUI

class ViewController: UIViewController,UITextFieldDelegate {
    
    @IBOutlet weak var usertext: UITextField!
    
    @IBOutlet weak var passwordtext: UITextField!
    
    @IBOutlet weak var signinbtn: UIButton!
    
    @IBOutlet weak var nxtpage: UIButton!
    
    private let signinbutton = ASAuthorizationAppleIDButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        signinbtn.layer.borderColor = UIColor(red: 224/255.0, green: 233/255.0, blue: 255/255.0, alpha: 1.0).cgColor
        signinbtn.layer.borderWidth = 1
        signinbtn.layer.cornerRadius = 15
        
        nxtpage.layer.borderColor = UIColor(red: 224/255.0, green: 233/255.0, blue: 255/255.0, alpha: 1.0).cgColor
        nxtpage.layer.borderWidth = 1
        nxtpage.layer.cornerRadius = 15
        
        self.usertext.delegate = self
        self.passwordtext.delegate = self
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    
    @IBAction func signin(_ sender: Any) {
        
        let provider = ASAuthorizationAppleIDProvider()
        let request = provider.createRequest()
        request.requestedScopes = [.fullName, .email]
        let controller = ASAuthorizationController(authorizationRequests: [request])
        controller.delegate = self
        controller.presentationContextProvider = self
        controller.performRequests()
        
    }
    
    @IBAction func nxtpage(_ sender: Any) {
        
        let viewC = (self.storyboard?.instantiateViewController(withIdentifier: "HealthKitViewController")) as! HealthKitViewController
        self.navigationController?.pushViewController(viewC, animated: true)
        
    }
    
}


extension ViewController : ASAuthorizationControllerDelegate {
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        print("Sign in your personal apple account")
    }
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        
        switch authorization.credential {
        case let credentials as ASAuthorizationAppleIDCredential:
            let firstname = credentials.fullName?.givenName
            let lastname = credentials.fullName?.familyName
            let email = credentials.email
            break
            
        default:
            break
        }
        
    }
    
}

extension ViewController : ASAuthorizationControllerPresentationContextProviding{
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return view.window!
    }
    
    
    
}
