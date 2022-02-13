//
//  GameScene.swift
//  Snake
//
//  Created by Ivan Konishchev on 10.02.2022.
//

import SpriteKit
import GameplayKit


struct CollisionCategories {
    static let snake: UInt32 = 0x1 << 0
    static let snakeHead: UInt32 = 0x1 << 1
    static let apple: UInt32 = 0x1 << 2
    static let edgeBody: UInt32 = 0x1 << 3
}
class GameScene: SKScene {
    var score: Int = 0
    var lifeCount = 3
    var snake: Snake?
    var scoreLable: SKLlableText?
    var lifeLable: SKLlableText?
    var gameOver: SKLlableText?
    
    override func didMove(to view: SKView) {
      

        backgroundColor = SKColor.yellow
        self.physicsWorld.gravity = CGVector(dx: 0, dy: 0)
        self.physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
        self.physicsBody?.allowsRotation = false
        view.showsPhysics = true
        

        
        
        let counterClockWiseButton = SKShapeNode()
        counterClockWiseButton.path = UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: 45, height: 45)).cgPath
        counterClockWiseButton.position = CGPoint(x: view.scene!.frame.minX + 30, y: view.scene!.frame.minY + 50)
        counterClockWiseButton.fillColor = .black
        counterClockWiseButton.strokeColor = .gray
        counterClockWiseButton.lineWidth = 5
        counterClockWiseButton.name = "counterClockWiseButton"
        self.addChild(counterClockWiseButton)
        
        let counterClockWiseSecondButton = SKShapeNode()
        counterClockWiseSecondButton.path = UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: 45, height: 45)).cgPath
        counterClockWiseSecondButton.position = CGPoint(x: view.scene!.frame.maxX - 80, y: view.scene!.frame.minY + 50)
        counterClockWiseSecondButton.fillColor = .black
        counterClockWiseSecondButton.strokeColor = .gray
        counterClockWiseSecondButton.lineWidth = 5
        counterClockWiseSecondButton.name = "counterClockWiseSecondButton"
        self.addChild(counterClockWiseSecondButton)
        
        snake = Snake(atPoint: CGPoint(x: view.scene!.frame.midX, y: view.scene!.frame.midY))
        self.addChild(snake!)
        createApple()
        
        lifeLable = SKLlableText(position: CGPoint(x: view.scene!.frame.maxX - 60, y: view.scene!.frame.maxY - 90))
        lifeLable?.text = "Life: \(self.lifeCount)"
        self.addChild(lifeLable!)
        scoreLable = SKLlableText(position: CGPoint(x: view.scene!.frame.minX + 60, y: view.scene!.frame.maxY - 90))
        scoreLable?.text = "Score: \(self.score)"
        self.addChild(scoreLable!)
        
        self.physicsWorld.contactDelegate = self
        self.physicsBody?.categoryBitMask = CollisionCategories.edgeBody
        self.physicsBody?.categoryBitMask = CollisionCategories.snake | CollisionCategories.snakeHead
        self.physicsBody?.categoryBitMask = CollisionCategories.edgeBody | CollisionCategories.snakeHead
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let touchLocation = touch.location(in: self)
            guard let touchNode = self.atPoint(touchLocation) as? SKShapeNode,
                  touchNode.name == "counterClockWiseButton" || touchNode.name == "counterClockWiseSecondButton" else {return }
            touchNode.fillColor = .green
            
            if touchNode.name == "counterClockWiseSecondButton" {
                snake!.moveClockWise()
            }else if touchNode.name == "counterClockWiseButton" {
                snake!.moveCounterClockWise()
            }
        }
    }
    
//    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
//
//    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let touchLocation = touch.location(in: self)
            guard let touchNode = self.atPoint(touchLocation) as? SKShapeNode,
                  touchNode.name == "counterClockWiseButton" || touchNode.name == "counterClockWiseSecondButton" else {return }
            touchNode.fillColor = .black
        }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
       // for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        snake!.move()
        if gameOver != nil {
            sleep(5)
            gameOver?.removeFromParent()
            gameOver = nil
        }
        

       
    }
    
    func createApple() {
        let randX = CGFloat(arc4random_uniform(UInt32(view!.scene!.frame.maxX - 10)))
        let randY = CGFloat(arc4random_uniform(UInt32(view!.scene!.frame.maxY - 10)))
        let apple = Apple(position: CGPoint(x: randX, y: randY))
        self.addChild(apple)
    }

    
    
}

extension GameScene: SKPhysicsContactDelegate {
    
    func didBegin(_ contact: SKPhysicsContact) {
        let bodyes = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask
        let collisionObject = bodyes - CollisionCategories.snakeHead
        switch collisionObject {
            
        case CollisionCategories.apple:
            let apple = contact.bodyA.node is Apple ? contact.bodyA.node : contact.bodyB.node
            snake?.addBodyPart()
            apple?.removeFromParent()
            self.score += 1
            self.scoreLable?.removeFromParent()
            self.scoreLable = SKLlableText(position: CGPoint(x: view!.scene!.frame.minX + 60, y: view!.scene!.frame.maxY - 90))
            scoreLable?.text = "Score: \(self.score)"
            self.addChild(scoreLable!)
            createApple()
            
        case CollisionCategories.edgeBody:
            self.snake?.removeFromParent()
            self.snake = Snake(atPoint: CGPoint(x: (self.view!.scene!.frame.midX), y: self.view!.scene!.frame.midY))
            self.addChild(self.snake!)
            self.lifeCount -= 1
            if self.lifeCount == 0 {
                self.gameOver = SKLlableText(position: CGPoint(x: view!.scene!.frame.midX , y: view!.scene!.frame.midY - 90))
                gameOver?.text = "Game Over! You Scroe: \(self.score)"
                self.addChild(gameOver!)
                self.lifeCount = 3
                self.score = 0
                self.scoreLable?.removeFromParent()
                self.scoreLable = SKLlableText(position: CGPoint(x: view!.scene!.frame.minX + 60, y: view!.scene!.frame.maxY - 50))
                scoreLable?.text = "Score: \(self.score)"
                self.addChild(scoreLable!)
                
            }
            
            self.lifeLable?.removeFromParent()
            self.lifeLable = SKLlableText(position: CGPoint(x: view!.scene!.frame.maxX - 60, y: view!.scene!.frame.maxY - 90))
            lifeLable?.text = "Life: \(self.lifeCount)"
            self.addChild(lifeLable!)

        default:
            break
        }
    }
}
