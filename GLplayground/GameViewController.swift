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
  
  var scene: SCNScene!
  var rootNode:SCNNode!
  var lightNode:SCNNode!
  var cameraNode:SCNNode!
  var spawnTime: TimeInterval = 0
  let spin = SCNAction.repeatForever(SCNAction.rotateBy(x: 1, y: 0, z: 1, duration: 2))
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // create a new scene
    self.scene = GameScene()
    
    let sceneView = self.view as! SCNView
    sceneView.showsStatistics = true
    sceneView.scene = scene
    sceneView.allowsCameraControl = true
    sceneView.delegate = self
    sceneView.delegate = (scene as! GameScene)
    sceneView.isPlaying = true
    rootNode = scene.rootNode
    
    setupLight()
    setupCamera()
    createFloor()
  }
  
  func setupCamera() {
    cameraNode = SCNNode()
    let camera = SCNCamera()
    camera.zNear = 0.1
    camera.zFar = 50
    cameraNode.camera = camera
    cameraNode.position = vec3(0,6,10)
    cameraNode.rotation = vec4(1,0,0, -0.54)
    rootNode.addChildNode(cameraNode)
  }
  
  func createFloor() {
    let floorNode = SCNNode()
    floorNode.geometry = SCNFloor()
    floorNode.geometry?.firstMaterial?.diffuse.contents = UIColor.purple
    floorNode.position.y = -0.75
    rootNode.addChildNode(floorNode)
  }
  
  func createXYPlane() {
    let planeNode = SCNNode()
    planeNode.geometry = SCNPlane(width: 100, height: 100)
    planeNode.geometry?.firstMaterial?.diffuse.contents = UIColor.white
    planeNode.geometry?.firstMaterial?.specular.contents = UIColor(white: 0.4, alpha: 1.0)
    planeNode.geometry?.firstMaterial?.shininess = 0.9
    planeNode.position.z = -6.0
    rootNode.addChildNode(planeNode)
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
    omniLight.color = UIColor(white: 0.8, alpha: 1.0)
    let omniLightNode = SCNNode()
    omniLightNode.light = omniLight
    omniLightNode.position = vec3(20,10,50)
    lightNode.addChildNode(omniLightNode)
    lightNode.name = "light"
    
    rootNode.addChildNode(lightNode)
  }
}
