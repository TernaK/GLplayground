//
//  GameScene.swift
//  GLplayground
//
//  Created by Terna Kpamber on 4/11/17.
//  Copyright © 2017 Terna Kpamber. All rights reserved.
//

import SceneKit
import GameplayKit

class GameScene: SCNScene, SCNSceneRendererDelegate {
  var entityManager: EntityManager!
  var player: Player!
  var enemy: Enemy!
  var spawned = false
  
  override init() {
    super.init()
    self.entityManager = EntityManager(scene: self)
    self.background.contents = UIColor.white
    
    addPlayer()
    addEnemy()
    
    if spawned == false {
      entityManager.spawnMinion(team: .enemy)
      entityManager.spawnMinion(team: .player)
      spawned = true
    }
    
  }
  
  func addPlayer() {
    player = Player(entityManager: entityManager)
    player.component(ofType: NodeComponent.self)?.node.position = vec3(0,0,5)
    entityManager.add(entity: player)
  }
  
  func addEnemy() {
    enemy = Enemy(entityManager: entityManager)
    enemy.component(ofType: NodeComponent.self)?.node.position = vec3(0,0,-5)
    entityManager.add(entity: enemy)
  }
  
  func renderer(_ renderer: SCNSceneRenderer, updateAtTime time: TimeInterval) {
    entityManager.update(time)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}
