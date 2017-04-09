//
//  Obstacles.swift
//  GLplayground
//
//  Created by Terna Kpamber on 4/7/17.
//  Copyright © 2017 Terna Kpamber. All rights reserved.
//

import SceneKit

class Obstacles {
  
  class func PyramidNode() -> SCNNode {
    let pyramid = SCNPyramid(width: 10, height: 20, length: 10)
    let pyramidNode = SCNNode(geometry: pyramid)
    pyramidNode.geometry?.firstMaterial?.diffuse.contents = UIColor.blue
    pyramidNode.geometry?.firstMaterial?.shininess = 1.0
    pyramidNode.position.z = -100;
    pyramidNode.position.x = -20;
    
    let rotation = CABasicAnimation(keyPath: "rotation")
    rotation.fromValue = NSValue(scnVector4: vec4(0.0, 0, 0, 0))
    rotation.toValue =  NSValue(scnVector4: vec4(0, 1, 0, 2.0 * Double.pi))
    rotation.duration = 5
    rotation.repeatCount = .infinity
    pyramidNode.addAnimation(rotation, forKey: "rotation")
    
    return pyramidNode
  }
  
  class func BoxNode() -> SCNNode {
    let box = SCNBox(width: 10, height: 10, length: 10, chamferRadius: 0)
    let boxNode = SCNNode(geometry: box)
    boxNode.geometry?.firstMaterial?.diffuse.contents = UIColor.brown
    boxNode.position = SCNVector3Make(0, 10, -20)
    return boxNode
  }
  
  class func TubeNode() -> SCNNode {
    let tube = SCNTube(innerRadius: 10, outerRadius: 14, height: 20)
    let tubeNode = SCNNode(geometry: tube)
    tubeNode.geometry?.firstMaterial?.diffuse.contents = UIColor.yellow
    tubeNode.position = SCNVector3Make(-10, 0, -75)
    return tubeNode
  }
  
  class func CylinderNode() -> SCNNode {
    let cylinderNode = SCNNode(geometry:SCNCylinder(radius: 3, height: 12))
    cylinderNode.geometry?.firstMaterial?.diffuse.contents = UIColor.green
    cylinderNode.position = SCNVector3Make(14, 0, -25)
    return cylinderNode
  }
  
  class func TorusNode() -> SCNNode {
    let torus = SCNTorus(ringRadius: 12, pipeRadius: 5)
    let torusNode = SCNNode(geometry: torus)
    torusNode.geometry?.firstMaterial?.diffuse.contents = UIColor.orange
    torusNode.position = SCNVector3Make(50, 10, -50)
    return torusNode
  }

  class func createStartingText() -> SCNNode {
    let startText = SCNText(string: "Start!", extrusionDepth: 5)
    startText.chamferRadius = 0.5
    startText.flatness = 0.3
    startText.font = UIFont(name: "Copperplate", size: 30)
    startText.firstMaterial?.specular.contents = UIColor.blue
    startText.firstMaterial?.shininess = 0.4
    let textNode = SCNNode(geometry: startText)
    textNode.scale = SCNVector3Make(0.75, 0.75, 0.75)
    textNode.position = SCNVector3Make(200, 0, 1000);
    return textNode
  }
}
