//
//  ViewController.swift
//  WTChan
//
//  Created by Kyri IOULIANOU on 2017/10/07.
//  Copyright © 2017 Kyri IOULIANOU. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let UID = "dc02ac6b227a3dfbddc79673fd66af056fdcafd2f291fced522166e201ba4492"
    let secret = "2a90c54653843bf1ac25eeaa309d856028a3d418663105e3f9a36aefb1154c58"
    var token: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let session = UserDefaults.standard
        if session.string(forKey: "access_token") != nil {
            checkSession()
        } else {
            userAuthenticate()
        }
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
    
    func userAuthenticate() {
        let urlStr = "https://api.intra.42.fr/oauth/authorize?client_id=\(self.UID)&redirect_uri=http%3A%2F%2Fwww.mibrandapp.com&response_type=code&scope=public%20forum"
        let myCompletionHandler: (Bool) -> Void = {(true) in
            self.fetchToken()
        }
        if let url = URL(string: urlStr) {
            UIApplication.shared.open(url, options: [:], completionHandler: myCompletionHandler)
        } else {
            print("URL Error")
        }
        
    }
    
    func fetchToken() {
        let url = URL(string: "https://api.intra.42.fr/oauth/token")
        let session = UserDefaults.standard
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        request.setValue("application/x-www-form-urlencoded;charset=UTF-8", forHTTPHeaderField: "Content-Type")
        request.httpBody = "grant_type=client_credentials&client_id=\(self.UID)&client_secret=\(self.secret)".data(using: String.Encoding.utf8)
        let task = URLSession.shared.dataTask(with: request as URLRequest) {
            (data, response, error) in
            if let err = error {
                print(err)
            } else if let d = data {
                do {
                    if let dic: NSDictionary = try JSONSerialization.jsonObject(with: d, options: .mutableContainers) as? NSDictionary {
                        if let response = dic["access_token"] {
                            self.token = response as? String
                            session.set(dic.value(forKey: "access_token"), forKey: "access_token")
                            session.synchronize()
                            print("Got token " + self.token!)
                        } else {
                            print("token error")
                        }
                    }
                } catch (let err) {
                    print(err)
                }
            }
        }
        task.resume()
    }
    
    func checkSession() {
        let session = UserDefaults.standard
        if session.string(forKey: "access_token") != nil {
            print("performing seg")
            DispatchQueue.main.async() {
                self.performSegue(withIdentifier: "auth", sender: self)
            }
        }
    }


}

