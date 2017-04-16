//
//  ActorComponent.swift
//  GLplayground
//
//  Created by Terna Kpamber on 4/11/17.
//  Copyright © 2017 Terna Kpamber. All rights reserved.
//

import SceneKit
import GameplayKit

class ActorComponent: GKComponent {
  var points: Int = 0
  var elapsed = TimeInterval(0)
  var lastPointPackage = TimeInterval(0)
  
  override init() {
    super.init()
  }
  
  override func update(deltaTime seconds: TimeInterval) {
    super.update(deltaTime: seconds)
    
    lastPointPackage += seconds
    if lastPointPackage > TimeInterval(1.0) {
      lastPointPackage = 0
      points += 10
    }
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
