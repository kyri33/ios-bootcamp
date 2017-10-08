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
    var myTopic: Topic = Topic()
    let tokenName = "token"
    
    var TableData:Array< Topic > = Array < Topic >()

    override func viewDidLoad() {
        super.viewDidLoad()
        get_topics()
        NSLog("ayee")
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        myTopic = TableData[indexPath.row]
        
        performSegue(withIdentifier: "cell", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "cell" {
            let destVc = segue.destination as! MessagesTableViewController
            destVc.topic = myTopic
        }
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
        print("Getting topics")
        let session = UserDefaults.standard
        let token = session.string(forKey: tokenName)
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
            }        }
        task.resume()
    }
    
    func parse_json(data: Data) {
        let myObj = try! JSONSerialization.jsonObject(with: data, options: []) as? [AnyObject]
        
        print("obj \(myObj)")
        
        if (myObj == nil)
        {
            return ;
        }
        
        for obj in (myObj)! {
            let name: String = (obj["name"] as? String)!
            let authorObj: AnyObject = (obj["author"] as? AnyObject)!
            let author: String = (authorObj["login"] as? String)!
            let date: String = (obj["created_at"] as? String)!
            let messageUrl: String = (obj["messages_url"] as? String)!
            
            let topic: Topic = Topic()
            topic.name = name
            topic.author = author
            topic.date = date
            topic.messageUrl = messageUrl
            
            TableData.append(topic)
            //let authorObj = try! JSONSerialization(with: author, options: []) as? [AnyObject]
        }
        print("refreshing table")
        refresh_table()

    }
    
    func refresh_table() {
        DispatchQueue.main.async() {
            self.tableView.reloadData()
        }
    }

}
