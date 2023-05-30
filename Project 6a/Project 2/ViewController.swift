//
//  ViewController.swift
//  Project 2
//
//  Created by Walery Łojko on 14/11/2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    
    var countries = [String]()
    var score = 0
    var correctAnswer = 0
    var countChange = 0
    
    private lazy var barButtonItem: UIBarButtonItem = {
       let item = UIBarButtonItem()
        item.setTitleTextAttributes(nil, for: .normal)
        item.tintColor = .red
        item.setTitleTextAttributes([ NSAttributedString.Key.font: UIFont(name: "Arial", size: 40)!], for: UIControl.State.normal)

        return item
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        countries.append("estonia")
        countries.append("france")
        countries.append("germany")
        countries.append("ireland")
        countries.append("italy")
        countries.append("monaco")
        countries.append("nigeria")
        countries.append("poland")
        countries.append("russia")
        countries.append("spain")
        countries.append("uk")
        countries.append("us")
                
        button1.layer.borderWidth = 1
        button2.layer.borderWidth = 1
        button3.layer.borderWidth = 1
        
        button1.layer.borderColor = UIColor.lightGray.cgColor
        button2.layer.borderColor = UIColor.lightGray.cgColor
        button3.layer.borderColor = UIColor.lightGray.cgColor
        
        askQuestion()
        navigationItem.rightBarButtonItem = barButtonItem
        barButtonItem.title = String(score)
    }
    
    func askQuestion(action: UIAlertAction! = nil ) {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        title = countries[correctAnswer].uppercased()

        button1.setImage(UIImage(named: countries[0]), for: .normal)
        button2.setImage(UIImage(named: countries[1]), for: .normal)
        button3.setImage(UIImage(named: countries[2]), for: .normal)
    }

    @IBAction func buttonTapped(_ sender: UIButton) {
        var title: String
        
        if sender.tag == correctAnswer {
            title = "Correct"
            score += 1
            countChange += 1
            askQuestion()
        } else {
            title = "Wrong"
            score -= 1
            countChange += 1
            addWrongAnswerAlert(index: sender.tag)
        }
        
        if countChange == 5 {
           let alert = addNewAllert()
            present(alert, animated: true)
        }
        
        barButtonItem.title = String(score)
        
        let ac = UIAlertController(title: title, message: "Your score is \(score)", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Continue", style: .default, handler: askQuestion))
    }
    
    private func addNewAllert() -> UIAlertController {
        let alert = UIAlertController(title: "Out of 5 attempts you guessed right ", message: "Your score is \(score)", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: askQuestion(action:)))
        return alert
    }
    
    private func addWrongAnswerAlert(index: Int) {
        let alert = UIAlertController(title: "\(countries[index])", message: "This flag is \(countries[index])", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: askQuestion(action:)))
        present(alert, animated: true)
    }
}

