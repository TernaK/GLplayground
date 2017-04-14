//
//  MoveBehaviour.swift
//  GLplayground
//
//  Created by Terna Kpamber on 4/14/17.
//  Copyright © 2017 Terna Kpamber. All rights reserved.
//

import SceneKit
import GameplayKit

class MoveBehaviour: GKBehavior {
  
  init(targetSpeed: Float, seek: GKAgent3D, avoid: [GKAgent3D]) {
    super.init()
    
    if targetSpeed > 0 {
      setWeight(0.5, for: GKGoal(toReachTargetSpeed: targetSpeed))
      setWeight(0.5, for: GKGoal(toSeekAgent: seek))
//      print("seek: \(seek.position)")
      setWeight(1.0, for: GKGoal(toAvoid: avoid, maxPredictionTime: 1.0))
    }
  }
}
