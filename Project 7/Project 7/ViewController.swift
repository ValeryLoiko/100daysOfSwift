//
//  ViewController.swift
//  Project 7
//
//  Created by Diana on 13/05/2023.
//

import UIKit

class ViewController: UITableViewController {
    
    var petitions: [Petition] = []
    var filteredPetitions: [Petition] = []
    var isFilteder: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .organize, target: self, action: #selector(ViewController.showAlertWithURL))
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(ViewController.showFilterPetitions))
        
        
        let  urlString: String
        
        if navigationController?.tabBarItem.tag == 0 {
            urlString = "https://www.hackingwithswift.com/samples/petitions-1.json"
        } else {
            urlString = "https://www.hackingwithswift.com/samples/petitions-2.json"
        }
        
        if let url = URL(string: urlString) {
            if let data = try? Data(contentsOf: url) {
                parse(json: data)
                return
            }
        }
        showError(title: "Loading error", message: "There was a problem loading the feed. Please, check your connection and try again.")
    }
    
    func filter(_ letters: String) {
        if !filteredPetitions.isEmpty {
            filteredPetitions.removeAll()
        }
        
        for petition in petitions {
            if petition.title.lowercased().contains(letters) ||
                petition.body.lowercased().contains(letters) {
                filteredPetitions.append(petition)
            }
        }
        if filteredPetitions.isEmpty {
            showError(title: "No results", message: "Your filter didn't match any result")
        } else {
            isFilteder = true
            tableView.reloadData()
        }
    }
    
    @objc private func showAlertWithURL() {
        let alert = UIAlertController(title: "Credits", message: "Filter the petitions on the following keyword (leave empty to reset filtering", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    
    @objc private func showFilterPetitions() {
        let alert = UIAlertController(title: "Filter petitions", message: nil, preferredStyle: .alert)
        alert.addTextField { textField in
            textField.placeholder = "Enter letter"
        }
        let searchAction = UIAlertAction(title: "Search", style: .default) {
            [weak self, weak alert] _ in
            guard let letter = alert?.textFields?[0].text else { return }
            self?.filter(letter)
        }
        alert.addAction(searchAction)
        present(alert, animated: true)
    }
    
    func parse(json: Data) {
        let decoder = JSONDecoder()
        
        if let jsonPetitions = try? decoder.decode(Petitions.self, from: json) {
            petitions = jsonPetitions.results
            tableView.reloadData()
        }
    }
    
    func showError(title: String, message: String) {
        let ac = UIAlertController(title: title,
                                   message: message, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFilteder {
            return filteredPetitions.count
        } else {
            return petitions.count
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        var petiton: Petition
        if isFilteder {
            petiton = filteredPetitions[indexPath.row]
        } else {
            petiton = petitions[indexPath.row]
        }
        
        cell.textLabel?.text = petiton.title
        cell.detailTextLabel?.text = petiton.body
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailViewController()
        vc.detailItem = petitions[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
}

