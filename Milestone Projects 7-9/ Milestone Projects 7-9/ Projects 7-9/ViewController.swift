//
//  ViewController.swift
//   Projects 7-9
//
//  Created by Diana on 16/06/2023.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    private var backgroundImage: UIImageView!
    private var scoreLabel: UILabel!
    private var answerLabel: UILabel!
    
    private var words: [String] = []
    private var wordToGuess: String?
    private var buttons: [UIButton] = []
    
    private var score: Int = 0 {
        didSet {
            scoreLabel.text = "Score \(score)"
            backgroundImage.image = UIImage(named: "\(score)")
        }
    }
    
    private var answerArray: [String] = [] {
        didSet {
            answerLabel.text = answerArray.joined()
        }
    }
    
    let letters = ["a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        loadWords()
        restartGame()
    }
    
   @objc private func restartGame() {
        wordToGuess = words.randomElement()?.uppercased()
        answerArray = Array<String>(repeating: "_ ", count: wordToGuess!.count)
       
        score = 0
       
        buttons.forEach {
            $0.alpha = 1
            $0.isEnabled = true
        }
        print(wordToGuess)
    }
    
    private func loadWords() {
        guard let fileURL = Bundle.main.url(forResource: "fruitsAndVegetables", withExtension: ".txt") else {
            fatalError("Could not find fruitsAndVegetable.txt in bundle")
        }
        guard let fileContents = try? String(contentsOf: fileURL) else {
            fatalError("Could not get contents of fruitsAndVegetables.txt from bundle")
        }
        words = fileContents.trimmingCharacters(in: .newlines).components(separatedBy: .newlines)
    }
    
    @objc private func letterButtonTapped(_ sender: UIButton) {
        guard let wordToGuess = wordToGuess else { return }
        guard let buttonLetter = sender.currentTitle else { return }
        
        sender.alpha = 0.2
        sender.isEnabled = false
        
        let charTapped = Character(buttonLetter)
        var charFound = false
        
        for (index, char) in wordToGuess.enumerated() {
            if char == charTapped {
                answerArray[index] = String(char)
                charFound = true
            }
        }
    
        if !charFound {
            score += 1
            if score == 7 {
                showAlert(title: "You are lose", message: "The word was \(wordToGuess). Play again?")
                if let image = UIImage(named: "6") {
                           showFullscreen(image: image)
                       }
            }
        }
        if wordToGuess == answerArray.joined() {
            showAlert(title: "Congratulations", message: "You correctly guessed the word. Play again?")
        }
    }
    
    private func configureView() {
        title = "Hangman"
        view.backgroundColor = .cyan
        
        let refreshButton = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(restartGame))
        navigationItem.rightBarButtonItem = refreshButton
        
        
        backgroundImage = UIImageView(image: UIImage(named: "1"))
        backgroundImage.contentMode = .scaleAspectFit
        
        scoreLabel = UILabel()
        scoreLabel.text = "Score \(score)"
        scoreLabel.textAlignment = .center
        scoreLabel.font = UIFont.systemFont(ofSize: 40)
        scoreLabel.textColor = .yellow
        
        answerLabel = UILabel()
        answerLabel.font = UIFont.boldSystemFont(ofSize: 24)
        answerLabel.textAlignment = .center
        answerLabel.layer.borderColor = UIColor.black.cgColor
        answerLabel.layer.borderWidth = 1
        answerLabel.layer.cornerRadius = 10
        
        view.addSubview(backgroundImage)
        backgroundImage.addSubview(scoreLabel)
        view.addSubview(answerLabel)
        
        let buttonsView = UIView()
        buttonsView.backgroundColor = .clear
        view.addSubview(buttonsView)
        
        let width = 60
        let height = 50
        
        var column = 0
        var row = 0
        
        for letter in 0...letters.count - 1 {
            let letterButton = UIButton(type: .system)
            letterButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 24)
            letterButton.setTitleColor(.brown, for: .normal)
            letterButton.setTitle(letters[letter].uppercased(), for: .normal)
            letterButton.layer.borderColor = UIColor.red.cgColor
            letterButton.layer.borderWidth = 1
            letterButton.layer.cornerRadius = 10
            buttons.append(letterButton)
            
            if letter % 6 == 0, letter != 0 {
                row += 1
                column = 0
            }
            
            if letter == letters.count - 2 {
                column = 2
            }
            
            letterButton.frame = CGRect(origin: CGPoint(x: column * width, y: row * height + 5), size: CGSize(width: width, height: height))
            letterButton.addTarget(self, action: #selector(letterButtonTapped), for: .touchUpInside)
            buttonsView.addSubview(letterButton)
            
            column += 1
        }
        
        backgroundImage.snp.makeConstraints {
            $0.left.right.equalToSuperview()
            $0.height.equalToSuperview().multipliedBy(0.5)
            $0.top.equalToSuperview().inset(90)
        }
        
        scoreLabel.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(10)
            $0.left.right.equalToSuperview().inset(20)
        }
        
        answerLabel.snp.makeConstraints {
            $0.top.equalTo(backgroundImage.snp.bottom)
            $0.left.right.equalToSuperview().inset(10)
            $0.height.equalTo(40)
        }
        
        buttonsView.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(20)
            $0.top.equalTo(answerLabel.snp.bottom)
            $0.leading.trailing.equalToSuperview().inset(10)
        }
    }
    
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in self.restartGame()
        }))
        present(alert, animated: true)Q
    }
}

extension UIViewController {
    func showFullscreen(image: UIImage) {
        let imageView = UIImageView(image: image)
        imageView.frame = UIScreen.main.bounds
        imageView.contentMode = .scaleAspectFit
        imageView.isUserInteractionEnabled = true

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
        imageView.addGestureRecognizer(tapGesture)

        view.addSubview(imageView)
        view.bringSubviewToFront(imageView)

        UIView.animate(withDuration: 0.3) {
            imageView.alpha = 1.0
        }
    }

    @objc private func imageTapped(_ gesture: UITapGestureRecognizer) {
        if let imageView = gesture.view {
            UIView.animate(withDuration: 0.3, animations: {
                imageView.alpha = 0.0
            }) { _ in
                imageView.removeFromSuperview()
            }
        }
    }
}
