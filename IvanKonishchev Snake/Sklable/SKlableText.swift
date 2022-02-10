//
//  SKlableText.swift
//  IvanKonishchev Snake
//
//  Created by Ivan Konishchev on 10.02.2022.
//

import UIKit
import SpriteKit

class SKLlableText: SKLabelNode {
    init(position: CGPoint) {
        super.init()
        self.position = position
        self.fontSize = 19
        self.fontColor = SKColor.black
      
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

