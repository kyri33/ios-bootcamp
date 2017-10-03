//
//  AddMemberViewController.swift
//  Table View
//
//  Created by Kyri IOULIANOU on 2017/10/03.
//  Copyright © 2017 Kyri IOULIANOU. All rights reserved.
//

import UIKit

class AddMemberViewController: UIViewController {
    
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var dateField: UIDatePicker!
    @IBOutlet weak var descriptionField: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func doneButton(_ sender: Any) {
        let dateFormatr = DateFormatter()
        dateFormatr.dateFormat = "dd-MM-YYYY h:mm a"
        let strDate = dateFormatr.string(from: dateField.date)
        print("Name: " + nameField.text! + " Date: " + strDate + " Description: " + descriptionField.text)
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
