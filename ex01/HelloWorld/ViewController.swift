//
//  ViewController.swift
//  HelloWorld
//
//  Created by Kyriakos Ioulianou on 2017/10/01.
//  Copyright © 2017 Kyriakos Ioulianou. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var myLabel: UILabel!
    
    @IBAction func sayHello(_ sender: Any) {
        myLabel.text = "Hello World !"
    }


}

