//
//  Minion.swift
//  GLplayground
//
//  Created by Terna Kpamber on 4/11/17.
//  Copyright © 2017 Terna Kpamber. All rights reserved.
//

import SceneKit
import GameplayKit

class Minion: GKEntity {
  
  init(onTeam team: Team) {
    super.init()
    
    let teamComponent = TeamComponent(team: team)
    addComponent(teamComponent)
    
    let nodeComponent = NodeComponent(shape: .box, color: team == .player ? .green : .red)
    let scale = 0.15
    nodeComponent.node.scale = vec3(scale, scale, scale)
    addComponent(nodeComponent)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
