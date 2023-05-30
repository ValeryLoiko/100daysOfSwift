//
//  TableViewController.swift
//  Project 4 Challenge
//
//  Created by Walery Łojko on 03/01/2023.
//

import UIKit

class TableViewController: UITableViewController {

    var websites = ["google.com", "apple.com", "hackingwithswift.com", "allegro.pl", "justjoin.it", "peugeot.pl"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Gau"
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
     
        return websites.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = websites[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "ViewController") as? ViewController {
            vc.title = String(websites[indexPath.row])
            
            vc.website = websites[indexPath.row]
            
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}

