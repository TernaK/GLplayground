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
  
  init(scene: SCNScene) {
    self.scene = scene
    self.entities = Set<GKEntity>()
  }
  
  func add(entity: GKEntity) {
    if let node = entity.component(ofType: NodeComponent.self)?.node {
      scene.rootNode.addChildNode(node)
    }
    
    entities.insert(entity)
  }
  
  func remove(entity: GKEntity) {
    
    if let node = entity.component(ofType: NodeComponent.self)?.node {
      node.removeFromParentNode()
    }
    
    entities.remove(entity)
  }
}
