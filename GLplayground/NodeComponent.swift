//
//  NodeComponent.swift
//  GLplayground
//
//  Created by Terna Kpamber on 4/10/17.
//  Copyright © 2017 Terna Kpamber. All rights reserved.
//

import SceneKit
import GameplayKit

enum Shape {
  case pyramid
  case box
  case torrus
  case cylinder
  case tube
  case sphere
}

class NodeComponent: GKComponent {
  let node: SCNNode
  
  init(shape: Shape, color: UIColor) {
    switch shape {
    case .pyramid:
      node = Shapes.PyramidNode()
    case .box:
      node = Shapes.BoxNode()
    case .torrus:
      node = Shapes.TorusNode()
    case .cylinder:
      node = Shapes.CylinderNode()
    case .tube:
      node = Shapes.TubeNode()
    case .sphere:
      node = Shapes.SphereNode()
    }
    node.geometry?.firstMaterial?.diffuse.contents = color
    node.geometry?.firstMaterial?.specular.contents = UIColor(white: 0.3, alpha: 1.0)
    
    super.init()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
