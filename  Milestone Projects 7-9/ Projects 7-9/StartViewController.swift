//
//  StartViewController.swift
//   Projects 7-9
//
//  Created by Diana on 22/07/2023.
//

import UIKit

class StartViewController: UIViewController {
    
    private var regulLabel: UILabel!
    private var infoLabel: UILabel!
    private var startButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    private func configureView() {
        view.backgroundColor = .cyan
        
        regulLabel = UILabel()
        regulLabel.text = """
        Guess the name of a vegetable or fruit
        You have 7 tries
        Good luck!
        """
        regulLabel.numberOfLines = 0
        regulLabel.font = UIFont.boldSystemFont(ofSize: 20)
        regulLabel.textAlignment = .center
        regulLabel.layer.borderColor = UIColor.black.cgColor
        regulLabel.layer.borderWidth = 1
        regulLabel.layer.cornerRadius = 10
        
        infoLabel = UILabel()
        infoLabel.text = "P.S. Ignore the photo above "
        infoLabel.font = UIFont.boldSystemFont(ofSize: 16)
        infoLabel.textAlignment = .center
        infoLabel.layer.borderColor = UIColor.black.cgColor
        
        startButton = UIButton(type: .system)
        startButton.setTitle("Start game", for: .normal)
        startButton.titleLabel?.textColor = .systemGray2
        startButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        startButton.layer.borderColor = UIColor.black.cgColor
        startButton.layer.borderWidth = 1
        startButton.layer.cornerRadius = 10
        startButton.addTarget(self, action: #selector(startGame), for: .touchUpInside)
        
        
        view.addSubview(regulLabel)
        view.addSubview(startButton)
        view.addSubview(infoLabel)
        
        regulLabel.snp.makeConstraints {
            $0.height.equalTo(200)
            $0.centerY.equalToSuperview().offset(-100)
            $0.left.right.equalToSuperview().inset(12)
        }
        
        startButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(60)
            $0.left.right.equalToSuperview().inset(50)
            $0.height.equalTo(60)
        }
        
        infoLabel.snp.makeConstraints {
            $0.top.equalTo(regulLabel.snp.bottom).offset(60)
            $0.height.equalTo(60)
            $0.left.right.equalToSuperview().inset(60)
        }
    }
    
    @objc private func startGame() {
        navigationController?.pushViewController(ViewController(), animated: true)
    }
}
