//
//  GameScene.swift
//  Project 11
//
//  Created by Diana on 31/07/2023.
//

import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var scoreLabel: SKLabelNode!
    var editLabel: SKLabelNode!
    let arrayColors = ["ballRed", "ballBlue", "ballCyan", "ballGreen", "ballGrey", "ballPurple", "ballYellow"]
    var countBalls = 0 {
        didSet {
            if countBalls == 10 {
                showAlert()
            }
        }
    }
    
    var score = 0 {
        didSet {
            scoreLabel.text = "Score \(score)"
        }
    }
    
    var editingMode: Bool = false {
        didSet {
            if editingMode {
                editLabel.text = "Done"
            } else {
                editLabel.text = "Edit"
            }
        }
    }
    
    override func didMove(to view: SKView) {
        let background = SKSpriteNode(imageNamed: "background.jpg")
        background.position = CGPoint(x: 512, y: 384)
        background.blendMode = .replace
        background.zPosition = -1
        addChild(background)
        
        makeBouncer(at: CGPoint(x: 0, y: 30))
        makeBouncer(at: CGPoint(x: 256, y: 30))
        makeBouncer(at: CGPoint(x: 512, y: 30))
        makeBouncer(at: CGPoint(x: 768, y: 30))
        makeBouncer(at: CGPoint(x: 1024, y: 30))
        
        makeSlot(at: CGPoint(x: 128, y: 30), isGood: true)
        makeSlot(at: CGPoint(x: 384, y: 30), isGood: false)
        makeSlot(at: CGPoint(x: 640, y: 30), isGood: true)
        makeSlot(at: CGPoint(x: 896, y: 30), isGood: false)
        
        physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
        physicsWorld.contactDelegate = self
        
        scoreLabel = SKLabelNode(fontNamed: "Chalkduster")
        scoreLabel.text = "Score: \(score)"
        scoreLabel.horizontalAlignmentMode = .right
        scoreLabel.position = CGPoint(x: 980, y: 700)
        addChild(scoreLabel)
        
        editLabel = SKLabelNode(fontNamed: "Chalkduster")
        editLabel.text = "Edit"
        editLabel.position = CGPoint(x: 80, y: 700)
        addChild(editLabel)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let location = touch.location(in: self)
            
            let object = nodes(at: location)
            if object.contains(editLabel) {
                editingMode.toggle()
            } else {
                if editingMode {
                    let size = CGSize(width: Int.random(in: 16...128), height: 16)
                    let box = SKSpriteNode(color: UIColor(red: CGFloat.random(in: 0...1), green: CGFloat.random(in: 0...1), blue: CGFloat.random(in: 0...1), alpha: 1), size: size)
                    box.zRotation = CGFloat.random(in: 0...3)
                    box.position = location
                    box.name = "box"
                    box.physicsBody = SKPhysicsBody(rectangleOf: box.size)
                    box.physicsBody?.isDynamic = false
                    addChild(box)
                } else {
                    let ball = SKSpriteNode(imageNamed: arrayColors.randomElement()!)
                    ball.physicsBody = SKPhysicsBody(circleOfRadius: ball.size.width / 2.0)
                    ball.physicsBody?.contactTestBitMask = ball.physicsBody!.collisionBitMask
                    ball.physicsBody?.restitution = 0.4
                    ball.position = CGPoint(x: location.x, y: 750)
                    ball.name = "Ball"
                    addChild(ball)
                }
            }
        }
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        guard let nodeA = contact.bodyA.node else { return }
        guard let nodeB = contact.bodyB.node else { return }
        
        if nodeA.name == "Ball" {
            collisionBetween(ball: nodeA, object: nodeB)
        } else if nodeB.name == "Ball" {
            collisionBetween(ball: nodeB, object: nodeA)
        }
    }
    
    private func makeBouncer(at position: CGPoint) {
        let bouncer = SKSpriteNode(imageNamed: "bouncer")
        bouncer.position = position
        bouncer.physicsBody = SKPhysicsBody(circleOfRadius: bouncer.size.width / 2.0)
        bouncer.physicsBody?.isDynamic = false
        bouncer.name = "bouncer"
        addChild(bouncer)
    }
    
    private func makeSlot(at position: CGPoint, isGood: Bool) {
        var slotBase: SKSpriteNode
        var slotGlow: SKSpriteNode
        
        if isGood {
            slotBase = SKSpriteNode(imageNamed: "slotBaseGood")
            slotGlow = SKSpriteNode(imageNamed: "slotGlowGood")
            slotBase.name = "Good"
        } else {
            slotBase = SKSpriteNode(imageNamed: "slotBaseBad")
            slotGlow = SKSpriteNode(imageNamed: "slotGlowBad")
            slotBase.name = "Bad"
        }
        
        slotBase.position = position
        slotGlow.position = position
        
        slotBase.physicsBody = SKPhysicsBody(rectangleOf: slotBase.size)
        slotBase.physicsBody?.isDynamic = false
        
        addChild(slotBase)
        addChild(slotGlow)
        
        let spin = SKAction.rotate(byAngle: .pi, duration: 10)
        let foreverSpin = SKAction.repeatForever(spin)
        slotGlow.run(foreverSpin)
    }
    
    private func collisionBetween(ball: SKNode, object: SKNode) {
        if object.name == "Good" {
            destroy(ball: ball)
            score += 1
        } else if object.name == "Bad" {
            destroy(ball: ball)
            score -= 1
        } else if object.name == "box" && countBalls >= 5 {
            object.removeFromParent()
            score += 1
        }
    }
    
    private func destroy(ball: SKNode) {
        if let fireParticles = SKEmitterNode(fileNamed: "FireParticles") {
            fireParticles.position = ball.position
            addChild(fireParticles)
        }
        ball.removeFromParent()
        countBalls += 1
    }
    
    private func restartGame() {
        self.countBalls = 0
        self.score = 0
        for node in children {
            if node.name == "box" || node.name == "Ball"{
                node.removeFromParent()
            }
        }
    }
    
    private func showAlert() {
        let alert = UIAlertController(title: "SCORE = \(score)", message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Restart Game", style: .default) { [weak self] _ in
            self?.restartGame()
        })
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        self.view?.window?.rootViewController?.present(alert, animated: true, completion: nil)
    }
}
