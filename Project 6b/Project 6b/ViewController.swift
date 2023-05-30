//
//  ViewController.swift
//  Project 6b
//
//  Created by Walery Łojko on 13/01/2023.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let label1 = UILabel()
        label1.translatesAutoresizingMaskIntoConstraints = false
        label1.backgroundColor = .red
        label1.text = "THESE"
        label1.sizeToFit()
        
        let label2 = UILabel()
        label2.translatesAutoresizingMaskIntoConstraints = false
        label2.backgroundColor = .yellow
        label2.text = "ARE"
        label2.sizeToFit()
        
        let label3 = UILabel()
        label3.translatesAutoresizingMaskIntoConstraints = false
        label3.backgroundColor = .cyan
        label3.text = "SOME"
        label3.sizeToFit()
        
        let label4 = UILabel()
        label4.translatesAutoresizingMaskIntoConstraints = false
        label4.backgroundColor = .blue
        label4.text = "AWESOME"
        label4.sizeToFit()
        
        let label5 = UILabel()
        label5.translatesAutoresizingMaskIntoConstraints = false
        label5.backgroundColor = .green
        label5.text = "LABELS"
        label5.sizeToFit()
        
        view.addSubview(label1)
        view.addSubview(label2)
        view.addSubview(label3)
        view.addSubview(label4)
        view.addSubview(label5)
        
        let viewsDictionary = ["label1" : label1, "label2": label2, "label3": label3, "label4": label4, "label5": label5]
        
//        for label in viewsDictionary.keys {
//            view.addConstraints( NSLayoutConstraint.constraints(withVisualFormat: "H:|[\(label)]|", metrics: nil, views: viewsDictionary))
//        }
//
//        let metrics = ["labelHeight": 88]
//
//        view.addConstraints( NSLayoutConstraint.constraints(withVisualFormat: "V:|[label1(labelHeight)]-[label2(labelHeight)]-[label3(labelHeight)]-[label4(labelHeight)]-[label5(labelHeight)]->=10-|", metrics: metrics, views: viewsDictionary))
        
        var previous: UILabel?
        
        for label in [label1, label2, label3, label4, label5] {
            label.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
            label.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20).isActive = true
            label.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.2, constant: -10).isActive = true

            if let previous = previous {
                label.topAnchor.constraint(equalTo: previous.bottomAnchor, constant: 10).isActive = true
            } else {
                label.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
            }
            previous = label
        }
    }   
}

