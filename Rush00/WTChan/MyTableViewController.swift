//
//  MyTableViewController.swift
//  WTChan
//
//  Created by Kyri IOULIANOU on 2017/10/07.
//  Copyright © 2017 Kyri IOULIANOU. All rights reserved.
//

import UIKit

class MyTableViewController: UITableViewController {
    
    let reuseIdentifier = "cell"
    
    var TableData:Array< Topic > = Array < Topic >()

    override func viewDidLoad() {
        super.viewDidLoad()
        get_topics()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return TableData.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)

        // Configure the cell...

        return cell
    }
    
    func get_topics() {
        let session = UserDefaults.standard
        let token = session.string(forKey: "access_token")
        let url = URL(string: "https://api.intra.42.fr/v2/topics")
        var request = URLRequest(url: url!)
        request.httpMethod = "GET"
        print("token " + token!)
        request.setValue("Bearer " + token!, forHTTPHeaderField: "Authorization")
        
        let task = URLSession.shared.dataTask(with: request as URLRequest) {
            (data, response, error) in
            if let err = error {
                print(err)
            } else if let d = data {
                do {
                    self.parse_json(data: d)
                }
            }
        }
        task.resume()
    }
    
    func parse_json(data: Data) {
        let myObj = try! JSONSerialization.jsonObject(with: data, options: []) as? [AnyObject]
        
        //print("obj \(myObj)")
        
        for obj in myObj! {
            print("Author \(obj["author"])")
        }
        
        print("Array ")
        
            /*if let json: Data? = try! JSONSerialization.data(withJSONObject: myObj, options: .prettyPrinted)  {
                print("Result \(json)")
            } else {
                print("json error")
            }*/

    }

}
