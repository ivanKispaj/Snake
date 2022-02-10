//
//  GameViewController.swift
//  Snake
//
//  Created by Ivan Konishchev on 10.02.2022.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {

   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let scen = GameScene(size: view.bounds.size)
        let skView = view as! SKView
        skView.showsFPS = true
        skView.showsNodeCount = true
        skView.ignoresSiblingOrder = true
        scen.scaleMode = .resizeFill
        skView.presentScene(scen)
       
    }


}
