//
//  Shapes.swift
//  GLplayground
//
//  Created by Terna Kpamber on 4/7/17.
//  Copyright © 2017 Terna Kpamber. All rights reserved.
//

import SceneKit

class Shapes {
  
  class func PyramidNode() -> SCNNode {
    let pyramid = SCNPyramid(width: 1, height: 1, length: 1)
    let pyramidNode = SCNNode(geometry: pyramid)
    pyramidNode.geometry?.firstMaterial?.diffuse.contents = UIColor.blue
    pyramidNode.geometry?.firstMaterial?.shininess = 1.0
    pyramidNode.position = vec3(0,0,0)
    
    return pyramidNode
  }
  
  class func BoxNode() -> SCNNode {
    let box = SCNBox(width: 1, height: 1, length: 1, chamferRadius: 0.1)
    box.firstMaterial?.diffuse.contents = UIColor.red
    box.firstMaterial?.specular.contents = UIColor.darkGray
    box.firstMaterial?.shininess = 0.4
    let boxNode = SCNNode(geometry: box)
    boxNode.position = vec3(0,0,0)
    return boxNode
  }
  
  class func TubeNode() -> SCNNode {
    let tube = SCNTube(innerRadius: 0.35, outerRadius: 0.5, height: 1)
    let tubeNode = SCNNode(geometry: tube)
    tubeNode.geometry?.firstMaterial?.diffuse.contents = UIColor.yellow
    tubeNode.position = vec3(0,0,0)
    return tubeNode
  }
  
  class func CylinderNode() -> SCNNode {
    let cylinderNode = SCNNode(geometry:SCNCylinder(radius: 0.5, height: 1))
    cylinderNode.geometry?.firstMaterial?.diffuse.contents = UIColor.green
    cylinderNode.position = vec3(0,0,0)
    return cylinderNode
  }
  
  class func TorusNode() -> SCNNode {
    let torus = SCNTorus(ringRadius: 0.4, pipeRadius: 0.1)
    let torusNode = SCNNode(geometry: torus)
    torusNode.geometry?.firstMaterial?.diffuse.contents = UIColor.orange
    torusNode.position = vec3(0,0,0)
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
