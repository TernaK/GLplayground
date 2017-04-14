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
  
  init(entityManager: EntityManager) {
    super.init()
    
    let nodeComponent = NodeComponent(shape: .sphere, color: .green)
    self.addComponent(nodeComponent)
    
    let teamComponent = TeamComponent(team: .player)
    self.addComponent(teamComponent)
    
    let actorComponent = ActorComponent()
    self.addComponent(actorComponent)
    
    let moveComponent = MoveComponent(maxSpeed: -1, maxAcceleration: 0, radius: 1.0, entityManager: entityManager)
    self.addComponent(moveComponent)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
