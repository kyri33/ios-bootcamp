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
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! MyTableViewCell

        let row = indexPath.row
        
        cell.title.text = TableData[row].name
        cell.descript.text = TableData[row].author
        cell.postDate.text = TableData[row].date

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
            let name: String = (obj["name"] as? String)!
            let authorObj: AnyObject = (obj["author"] as? AnyObject)!
            let author: String = (authorObj["login"] as? String)!
            let date: String = (obj["created_at"] as? String)!
            
            let topic: Topic = Topic()
            topic.name = name
            topic.author = author
            topic.date = date
            
            TableData.append(topic)
            refresh_table()
            //let authorObj = try! JSONSerialization(with: author, options: []) as? [AnyObject]

        }
        
        

    }
    
    func refresh_table() {
        DispatchQueue.main.async() {
            self.tableView.reloadData()
        }
    }

}
