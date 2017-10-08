//
//  MessagesTableViewController.swift
//  WTChan
//
//  Created by Kyri IOULIANOU on 2017/10/08.
//  Copyright © 2017 Kyri IOULIANOU. All rights reserved.
//

import UIKit

class MessagesTableViewController: UITableViewController {
    
    var topic: Topic = Topic()
    let tokenName: String = "token"
    var reuseIdentifier = "cell"
    
    var TableData:Array< Message > = Array < Message >()

    override func viewDidLoad() {
        super.viewDidLoad()
        get_messages()
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
        
        cell.title.text = TableData[row].content
        cell.descript.text = TableData[row].author
        cell.postDate.text = TableData[row].date
        
        return cell
    }
    
    func parse_json(data: Data) {
        let myObj = try! JSONSerialization.jsonObject(with: data, options: []) as? [AnyObject]
        
        if (myObj == nil) {
            print("error parsing json")
            return
        }
        
        for obj in (myObj)! {
            let content: String = (obj["content"] as? String)!
            let date: String = (obj["created_at"] as? String)!
            let authorObj: AnyObject = (obj["author"] as? AnyObject)!
            let author: String = (authorObj["login"] as? String)!
            
            let message: Message = Message()
            message.content = content
            message.author = author
            message.date = date
            
            TableData.append(message)
        }
        DispatchQueue.main.async() {
            self.tableView.reloadData()
        }
    }
    
    func get_messages() {
        let session = UserDefaults.standard
        let token = session.string(forKey: tokenName)
        let url = URL(string: topic.messageUrl!)
        var request = URLRequest(url: url!)
        request.httpMethod = "GET"
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

}
