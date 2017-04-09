//
//  GameViewController.swift
//  GLplayground
//
//  Created by Terna Kpamber on 4/7/17.
//  Copyright © 2017 Terna Kpamber. All rights reserved.
//

import UIKit
import QuartzCore
import SceneKit
import GLKit

class GameViewController: UIViewController, SCNSceneRendererDelegate {
  
  var rootNode:SCNNode!
  var lightNode:SCNNode!
  var cameraNode:SCNNode!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // create a new scene
    let scene = SCNScene()
    
    let sceneView = self.view as! GameView
    sceneView.scene = scene
    sceneView.showsStatistics = true
    sceneView.allowsCameraControl = true
//    sceneView.autoenablesDefaultLighting = true
    
    rootNode = scene.rootNode
    
    setupLight()
    setupCamera()
    createFloor()

    let spin = SCNAction.repeatForever(SCNAction.rotateBy(x: 0, y: 0, z: 1, duration: 2))
    
    let box = Shapes.BoxNode()
    box.runAction(spin)
    
    let pyramid = Shapes.PyramidNode()
    pyramid.runAction(spin)
    pyramid.position.x = -1.5
    
    let torrus = Shapes.TorusNode()
    torrus.runAction(spin)
    torrus.position.x = 1.5
    
    let cylinder = Shapes.CylinderNode()
    cylinder.runAction(spin)
    cylinder.position.z = -1.5
    
    let tube = Shapes.TubeNode()
    tube.runAction(spin)
    tube.position.z = -1.5
    tube.position.x = 1.5
    
    
    rootNode.addChildNode(box)
    rootNode.addChildNode(pyramid)
    rootNode.addChildNode(torrus)
    rootNode.addChildNode(cylinder)
    rootNode.addChildNode(tube)
  }
  
  func setupCamera() {
    cameraNode = SCNNode()
    let camera = SCNCamera()
    camera.zNear = 0.1
    camera.zFar = 100
    cameraNode.camera = camera
    cameraNode.position = vec3(0,3,3)
    cameraNode.rotation = vec4(1,0,0,-Float.pi/4)
    rootNode.addChildNode(cameraNode)
  }
  
  func createFloor() {
    let floorNode = SCNNode()
    floorNode.geometry = SCNFloor()
    floorNode.geometry?.firstMaterial?.diffuse.contents = UIColor.purple
    floorNode.position.y = -1.0
    rootNode.addChildNode(floorNode)
  }
  
  func setupLight() {
    lightNode = SCNNode()
    
    let ambientLight = SCNLight()
    ambientLight.type = .ambient
    ambientLight.color = UIColor(white: 0.3, alpha: 1.0)
    let ambientLightNode = SCNNode()
    ambientLightNode.light = ambientLight
    lightNode.addChildNode(ambientLightNode)
    
    let omniLight = SCNLight()
    omniLight.type = .omni
    omniLight.color = UIColor(white: 1.0, alpha: 1.0)
    let omniLightNode = SCNNode()
    omniLightNode.light = omniLight
    omniLightNode.position = vec3(20,50,50)
    lightNode.addChildNode(omniLightNode)
    lightNode.name = "light"
    
    rootNode.addChildNode(lightNode)
  }
}
