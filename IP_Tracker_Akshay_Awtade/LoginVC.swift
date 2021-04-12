//
//  LoginVC.swift
//  IP_Tracker_Akshay_Awtade
//
//  Created by Akshay Awtade on 04/04/21.
//  Copyright © 2021 Akshay Awtade. All rights reserved.
//

import UIKit
import FRAMEWORK 
class LoginVC: UIViewController {
    @IBOutlet weak var textFeildEmailID: UITextField!
    @IBOutlet weak var buttonLogin: UIButton!
    let VC = FRAMEWORK.LoginViewController()
    var PayloadApi = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(LoginIsApproved(_:)), name: Notification.Name("LoginApproved"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(loginCONTENTapi(_:)), name: Notification.Name("PayloadOfUser"), object: nil)

        self.buttonLogin.setview(backgroundcolor: UIColor.systemOrange, shadowcolor: .gray, shadowradius: 10, shadowopacity: 1, cornerradius: 15, bound: true, offsetWidth: 5, offsetHeight: 5, bordercolor: .white, borderwidth: 1)

    }
    
    @IBAction func buttonLoginTapped(_ sender: Any) {
      
        let apiKey = ["apikey": sawoAPIKey]
        let identifierType = ["identifier": "email"]
        let secretKey = ["secretkey":sawoSecretKey]

            NotificationCenter.default.post(name: Notification.Name("ProductKey"), object: nil,userInfo: apiKey)
            NotificationCenter.default.post(name: Notification.Name("IdentifierType"), object:nil, userInfo: identifierType)
            NotificationCenter.default.post(name: Notification.Name("SecretType"), object:nil, userInfo: secretKey)
//        }
        present(VC, animated: true, completion: nil)
    }
    
    @objc func LoginIsApproved(_ notification: Notification){
        print("Login was Successful")
        self.dismiss(animated: true, completion: nil)
        performSegue(withIdentifier: "segueidentifier", sender: nil)  
        

    }

    @objc func loginCONTENTapi(_ notification: Notification){
        if let data = notification.userInfo as? [String: String]
            {
                for (UserPayload, Content) in data
                {
                    PayloadApi = Content
                    print("\(UserPayload) : \(Content) ")
                }
        }

    }
}
