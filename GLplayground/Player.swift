//
//  Player.swift
//  GLplayground
//
//  Created by Terna Kpamber on 4/10/17.
//  Copyright © 2017 Terna Kpamber. All rights reserved.
//

import SceneKit
import GameplayKit

class Player: GKEntity {
  override init() {
    super.init()
    
    let nodeComponent = NodeComponent(shape: .box, color: .blue)
    addComponent(nodeComponent)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
