//
//  Enemy.swift
//  GLplayground
//
//  Created by Terna Kpamber on 4/11/17.
//  Copyright © 2017 Terna Kpamber. All rights reserved.
//


import SceneKit
import GameplayKit

class Enemy: GKEntity {
  override init() {
    super.init()
    
    let nodeComponent = NodeComponent(shape: .sphere, color: .red)
    addComponent(nodeComponent)
    
    let teamComponent = TeamComponent(team: .enemy)
    addComponent(teamComponent)
    
    let actorComponent = ActorComponent()
    self.addComponent(actorComponent)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
