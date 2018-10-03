//
//  Box.swift
//  GreenBox
//
//  Created by Edwin Cloud on 9/25/18.
//  Copyright © 2018 Edwin Cloud. All rights reserved.
//

import UIKit
import SpriteKit

class Box: SKSpriteNode {
    
    let boxSize = 40
    let boxColor = UIColor.green
    let boxZPosition:CGFloat = 100
    

    init(screenSize:CGSize, currentLevel:Int) {
        super.init(texture: nil, color: boxColor, size: CGSize(width: boxSize, height: boxSize))
        name = "box"
        zPosition = boxZPosition
        let randomX = Int.random(in: Int(size.width/2) ... Int(screenSize.width-size.width/2))
        position = CGPoint(x: randomX, y: 0)
        
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
