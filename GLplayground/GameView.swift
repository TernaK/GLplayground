//
//  GameView.swift
//  GLplayground
//
//  Created by Terna Kpamber on 4/8/17.
//  Copyright © 2017 Terna Kpamber. All rights reserved.
//

import SceneKit

class GameView: SCNView {
  var touchCount:Int = 0
  
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    let taps = event?.allTouches
    self.touchCount = (taps?.count)!
  }
  
  override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
    self.touchCount = 0
  }
}
