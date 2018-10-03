//
//  GameScene.swift
//  GreenBox
//
//  Created by Edwin Cloud on 9/20/18.
//  Copyright © 2018 Edwin Cloud. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var score: Int = 0
    var level: Int = 1
    
    override func didMove(to view: SKView) {
        headerBox()
        scoreLabel()
        levelLabel()
        let wait = SKAction.wait(forDuration: TimeInterval(3-(Double(level)*0.50)))
        let makeBox = SKAction.run {
            self.makeBox()
        }
        let stopGame = SKAction.run {
            if(self.score == 5 && self.level < 2) {
                self.level += 1
                self.backgroundColor = UIColor.blue
            }
            if(self.score == 10 && self.level < 3) {
                self.level += 1
                self.backgroundColor = UIColor.purple
            }
            if(self.score == 15 && self.level < 4) {
                self.level += 1
                self.backgroundColor = UIColor.yellow
                
            }
            if(self.score == 20 && self.level < 5) {
                self.level += 1
                self.backgroundColor = UIColor.orange
                
            }
            if(self.score < 0) {
                self.gameOverLabel()
                self.isPaused = true
            }
        }
        let sequence = SKAction.sequence([makeBox, wait])
        let group = SKAction.group([sequence, stopGame])
        let action = SKAction.repeatForever(group)
        run(action)

        
    }
    
    func gameOverLabel() {
        let gameOverText = SKLabelNode(text: "Game Over")
        gameOverText.name = "gameOverText"
        gameOverText.color = SKColor.white
        gameOverText.fontSize = 30
        gameOverText.zPosition = 1000
        gameOverText.position = CGPoint(x: size.width/2, y: size.height/2)
        addChild(gameOverText)
    }
    
    func makeBox() {
        let box = Box(screenSize: size, currentLevel: level)
        addChild(box)

        // Create action to move box up the screen and destroy after 4 seconds
        let moveUp = SKAction.moveTo(y: size.height, duration: TimeInterval(4-(Double(level)*0.30)))
        let removeBox = SKAction.run {
            self.removeFromParent()
            self.score -= 1
            let scoreText = self.childNode(withName: "scoreText") as! SKLabelNode
            scoreText.text = "Score: \(self.score)"
        }
        let sequence = SKAction.sequence([moveUp, removeBox])
        box.run(sequence)
    }
    
    func scoreLabel() {
        let scoreText = SKLabelNode(text: "Score: \(score)")
        scoreText.name = "scoreText"
        scoreText.color = SKColor.white
        scoreText.fontSize = 30
        scoreText.zPosition = 1000
        scoreText.position = CGPoint(x: size.width-75, y: size.height-35)
        addChild(scoreText)
    }
    
    func levelLabel() {
        let labelText = SKLabelNode(text: "Level: \(level)")
        labelText.name = "labelText"
        labelText.color = SKColor.white
        labelText.fontSize = 30
        labelText.zPosition = 1000
        labelText.position = CGPoint(x: 75, y: size.height-35)
        addChild(labelText)
    }
    
    func headerBox() {
        let headerBox = SKSpriteNode(color: .black, size: CGSize(width: size.width, height: 50))
        headerBox.zPosition = 900
        headerBox.position = CGPoint(x: size.width/2, y: size.height-25)
        addChild(headerBox)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // Get our touch and location
        let touch = touches.first!
        let location = touch.location(in: self)
        
        // Check if node touched is named box
        if atPoint(location).name == "box" {
            for node in nodes(at: location) {
                if node.name == "box" {
                    node.removeFromParent()
                    score += 1
                    let scoreText = childNode(withName: "scoreText") as! SKLabelNode
                    let labelText = childNode(withName: "labelText") as! SKLabelNode
                    scoreText.text = "Score: \(score)"
                    labelText.text = "Level: \(level)"
                }
            }
        }
        
        if isPaused {
            if let view = self.view {
                // Load the SKScene from 'GameScene.sks'
                let scene = GameScene(size: view.bounds.size)
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFill
                
                // Present the scene
                view.presentScene(scene)
            }
        }
    }
}
