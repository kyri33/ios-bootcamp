//
//  AddMemberViewController.swift
//  Table View
//
//  Created by Kyri IOULIANOU on 2017/10/03.
//  Copyright © 2017 Kyri IOULIANOU. All rights reserved.
//

import UIKit
import os.log

class AddMemberViewController: UIViewController {
    
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var dateField: UIDatePicker!
    @IBOutlet weak var descriptionField: UITextView!
    @IBOutlet weak var doneButton: UIBarButtonItem!
    var name: String = ""
    var descript: String = ""
    var date: Date?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        guard let button = sender as? UIBarButtonItem, button === doneButton else {
            print("Not saved, cancelling")
            return
        }
        
        name = nameField.text!
        descript = descriptionField.text
        date = dateField.date
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
