//
//  MoveComponent.swift
//  GLplayground
//
//  Created by Terna Kpamber on 4/14/17.
//  Copyright © 2017 Terna Kpamber. All rights reserved.
//

import SceneKit
import GameplayKit

extension float3 {
  var length: Float {
    return sqrt(x*x + y*y + z*z)
  }
}

class MoveComponent: GKAgent3D, GKAgentDelegate {
  let entityManager: EntityManager!
  
  init(maxSpeed: Float, maxAcceleration: Float, radius: Float, entityManager: EntityManager) {
    self.entityManager = entityManager
    super.init()
    self.delegate = self
    self.maxSpeed = maxSpeed
    self.maxAcceleration = maxAcceleration
    self.radius = radius
    self.mass = 0.01
  }
  
  func agentWillUpdate(_ agent: GKAgent) {
    guard let nodeComponent = entity?.component(ofType: NodeComponent.self) else {
      return
    }
    let pos = nodeComponent.node.presentation.position
    self.position = float3(pos)
  }
  
  func agentDidUpdate(_ agent: GKAgent) {
    guard let nodeComponent = entity?.component(ofType: NodeComponent.self) else {
      return
    }
    nodeComponent.node.position = vec3(self.position)
  }
  
  func closestMoveComponentForTeam(_ team: Team) -> GKAgent3D? {
    let moveComponents = entityManager.moveComponentsForTeam(team)
    var closestMoveComponent: GKAgent3D? = nil
    var closestDistance: Float = MAXFLOAT
    
    for component in moveComponents {
      let distance = (self.position - component.position).length
      if distance < closestDistance {
        closestDistance = distance
        closestMoveComponent = component
      }
    }
    
    return closestMoveComponent
  }
  
  override func update(deltaTime seconds: TimeInterval) {
    super.update(deltaTime: seconds)
    
    guard
      let entity = entity,
      let teamComponent = entity.component(ofType: TeamComponent.self) else {
        return
    }
    
    guard let enemyComponent = self.closestMoveComponentForTeam(teamComponent.team.opposite) else {
      return
    }
    
    let allies = entityManager.moveComponentsForTeam(teamComponent.team)
    
    self.behavior = MoveBehaviour(targetSpeed: self.maxSpeed, seek: enemyComponent, avoid: allies)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
