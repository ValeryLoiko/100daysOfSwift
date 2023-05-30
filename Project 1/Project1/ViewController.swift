//
//  ViewController.swift
//  Project1
//
//  Created by Walery Łojko on 07/11/2022.
//

import UIKit

class ViewController: UITableViewController {
    
    var pictures = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Storm Viewer"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        performSelector(inBackground: #selector(ViewController.loadData), with: nil)
    }
    
    @objc private func loadData() {
        let fm = FileManager.default
        let path = Bundle.main.resourcePath!
        let items = try! fm.contentsOfDirectory(atPath: path)
        
        for item in items {
            if item.hasPrefix("IMG_") {
                pictures.append(item)
            }
        }
        DispatchQueue.main.async {
            self.tableView.reloadData()

        }
    }

    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pictures.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let picrs = pictures.sorted()
        cell.textLabel?.text =  picrs[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController {
            vc.selectedImage = pictures[indexPath.row]
            let index: Int = {
                var id: Int = 0
                for (index, i) in pictures.enumerated() {
                    if i == pictures[indexPath.row] {
                        id = index + 1
                    }
                }
                return id
            }()
            print(index)
            vc.title = vc.selectedImage! + " \(index) of \(pictures.count)"
            navigationController?.pushViewController(vc, animated: true )
        }
    }

}

