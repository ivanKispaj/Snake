//
//  Apple.swift
//  Snake
//
//  Created by Ivan Konishchev on 10.02.2022.
//

import UIKit
import SpriteKit


class Apple: SKShapeNode {
    init(position: CGPoint) {
        super.init()
        path = UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: 10, height: 10)).cgPath
        fillColor = UIColor.green
        strokeColor = UIColor.green
        lineWidth = 5
        self.position = position
        self.physicsBody = SKPhysicsBody(circleOfRadius: 10.0, center: CGPoint(x: 5, y: 5))
        
        self.physicsBody?.categoryBitMask = CollisionCategories.apple
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

