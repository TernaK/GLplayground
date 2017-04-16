//
//  EntityManager.swift
//  GLplayground
//
//  Created by Terna Kpamber on 4/11/17.
//  Copyright © 2017 Terna Kpamber. All rights reserved.
//

import SceneKit
import GameplayKit

class EntityManager {
  
  var entities: Set<GKEntity>
  
  let scene: SCNScene
  
  var garbage = Set<GKEntity>()
  
  lazy var componentSystems: [GKComponentSystem] = {
    let actorSystem = GKComponentSystem(componentClass: ActorComponent.self)
    let moveSystem = GKComponentSystem(componentClass: MoveComponent.self)
    return [actorSystem, moveSystem]
  }()
  
  init(scene: SCNScene) {
    self.scene = scene
    self.entities = Set<GKEntity>()
  }
  
  func add(entity: GKEntity) {
    if let node = entity.component(ofType: NodeComponent.self)?.node {
      scene.rootNode.addChildNode(node)
    }
    for system in componentSystems {
      system.addComponent(foundIn: entity)
    }
    entities.insert(entity)
  }
  
  func remove(entity: GKEntity) {
    
    if let node = entity.component(ofType: NodeComponent.self)?.node {
      node.removeFromParentNode()
    }
    entities.remove(entity)
  }
  
  func update(_ deltaTime: TimeInterval) {
    // tell all systems to update
    for system in componentSystems {
      system.update(deltaTime: deltaTime)
    }
    
    spawnMinion(team: .enemy)
    spawnMinion(team: .player)
    
    // cleanup
    for entity in garbage {
      for system in componentSystems {
        system.removeComponent(foundIn: entity)
      }
    }
  }
  
  func entityForTeam(_ team: Team) -> GKEntity! {
    for entity in self.entities {
      if
        let _ = entity.component(ofType: ActorComponent.self),
        let teamComponent = entity.component(ofType: TeamComponent.self) {
        if team == teamComponent.team {
        	return entity
        }
      }
    }
    return nil
  }
  
  func entitiesForTeam(_ team: Team) -> [GKEntity] {
    var entities = [GKEntity]()
    
    for entity in self.entities {
      if
        let teamComponent = entity.component(ofType: TeamComponent.self) {
        if team == teamComponent.team {
          entities.append(entity)
        }
      }
    }
    
    return entities
  }
  
  func moveComponentsForTeam(_ team: Team) -> [MoveComponent] {
    
    let entitiesToMove = entitiesForTeam(team)
    
    var moveComponents = [MoveComponent]()
    for entity in entitiesToMove {
      if let moveComponent = entity.component(ofType: MoveComponent.self) {
        moveComponents.append(moveComponent)
      }
    }
    
    return moveComponents
  }
  
  func spawnMinion(team: Team) {
    guard let entity = entityForTeam(team) else {
      return
    }
    let cost = 50
    if let points = entity.component(ofType: ActorComponent.self)?.points {
      if cost > points {
        return
      }
    }
    
    entity.component(ofType: ActorComponent.self)?.points -= cost
    
    let minion = Minion(onTeam: team, entityManager: self)
    let minionNode = (minion.component(ofType: NodeComponent.self)?.node)!
    let entityNode = (entity.component(ofType: NodeComponent.self)?.node)!
    minionNode.position = entityNode.position
    minionNode.position.y += 0.75
    minionNode.opacity = 0
    add(entity: minion)
    minionNode.runAction(.fadeIn(duration: 0.3))
    minionNode.runAction(SCNAction.repeatForever(.rotateBy(x: 0, y: CGFloat(Float.pi * 2), z: 0, duration: 3)))
  }
}
