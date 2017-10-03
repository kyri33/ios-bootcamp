//
//  TableViewController.swift
//  Table View
//
//  Created by Kyri IOULIANOU on 2017/10/03.
//  Copyright © 2017 Kyri IOULIANOU. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    
    let names:[String] = [
        "Hugh Hefner", "Chester Bennington", "Michael Jackson"
    ]
    
    let descript:[String] = [
        "Founder Of Playboy", "Singer For Linkin Park", "King of Pop"
    ]
    
    let dates:[String] = [
        "2017", "2017", "2010"
    ]
    
    let cellSpacing: CGFloat = 20

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let row = indexPath.row
        cell.textLabel?.text = names[row] + " - " + dates[row]
        cell.detailTextLabel?.text = descript[row]
        return cell
    }
    

}
