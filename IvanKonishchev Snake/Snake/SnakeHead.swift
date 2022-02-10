//
//  SnakeHead.swift
//  Snake
//
//  Created by Ivan Konishchev on 10.02.2022.
//

import UIKit
import SpriteKit

class SnakeHead: SnakeBodyPart {
    
    override init(atPoint point: CGPoint){
        super.init(atPoint: point)
        
        self.physicsBody?.categoryBitMask = CollisionCategories.snakeHead
        self.physicsBody?.contactTestBitMask = CollisionCategories.edgeBody | CollisionCategories.snake | CollisionCategories.apple
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
