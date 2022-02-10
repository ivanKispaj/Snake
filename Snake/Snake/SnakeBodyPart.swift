//
//  SnakeBodyPart.swift
//  Snake
//
//  Created by Ivan Konishchev on 10.02.2022.
//

import UIKit
import SpriteKit

class SnakeBodyPart: SKShapeNode {
    init(atPoint point: CGPoint){
        super.init()
        path = UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: 10, height: 10)).cgPath
        fillColor = .red
        strokeColor = .red
        lineWidth = 5
        self.position = point
        self.physicsBody = SKPhysicsBody(circleOfRadius: CGFloat(6), center: CGPoint(x: 5, y: 5))
        self.physicsBody?.isDynamic = true
        self.physicsBody?.categoryBitMask = CollisionCategories.snake
        self.physicsBody?.contactTestBitMask = CollisionCategories.edgeBody | CollisionCategories.apple
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("Init(coder:) has not been Implemented")
    }
}
