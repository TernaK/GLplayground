//
//  TeamComponent.swift
//  GLplayground
//
//  Created by Terna Kpamber on 4/11/17.
//  Copyright © 2017 Terna Kpamber. All rights reserved.
//

import SceneKit
import GameplayKit

enum Team {
  case player
  case enemy
  
  var opposite:Team {
    switch self {
    case .player:
      return .enemy
    case .enemy:
      return .player
    }
  }
}

class TeamComponent: GKComponent {
  var team: Team!
  
  init(team: Team) {
    self.team = team
    super.init();
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
