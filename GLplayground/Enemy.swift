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
  init(entityManager: EntityManager) {
    super.init()
    
    let nodeComponent = NodeComponent(shape: .sphere, color: .red)
    addComponent(nodeComponent)
    
    let teamComponent = TeamComponent(team: .enemy)
    addComponent(teamComponent)
    
    let actorComponent = ActorComponent()
    self.addComponent(actorComponent)
    
    let moveComponent = MoveComponent(maxSpeed: -1, maxAcceleration: 0, radius: 1.0, entityManager: entityManager)
    self.addComponent(moveComponent)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
