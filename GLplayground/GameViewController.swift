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
    
    let sceneView = self.view as! SCNView
    sceneView.scene = scene
    sceneView.showsStatistics = true
    sceneView.allowsCameraControl = true
    
    rootNode = scene.rootNode
    
    setupLight()
    setupCamera()
    createFloor()
    
    let body = SCNBox(width: 15, height: 15, length: 15, chamferRadius: 1.0)
    body.firstMaterial?.diffuse.contents = UIColor(red: 0.8, green: 0, blue: 0, alpha: 1)
    body.firstMaterial?.ambient.contents = UIColor(red: 0.1, green: 0, blue: 0, alpha: 1)
    body.firstMaterial?.specular.contents = UIColor.darkGray
    body.firstMaterial?.shininess = 0.4
    body.firstMaterial?.lightingModel = .phong
    let bodyNode = SCNNode(geometry: body)
    bodyNode.position = vec3(0,30,0)
    bodyNode.runAction(SCNAction.repeatForever(SCNAction.sequence([
      SCNAction.move(by: vec3(15,0,0), duration: 1.0),
      SCNAction.move(by: vec3(-15,0,0), duration: 1.0)
      ])))
    bodyNode.runAction(SCNAction.repeatForever(SCNAction.rotateBy(x: 0, y: 1, z: 0, duration: 2)))
    rootNode.addChildNode(bodyNode)
  }
  
  func setupCamera() {
    cameraNode = SCNNode()
    let camera = SCNCamera()
    camera.zNear = 0.1
    camera.zFar = 300
    cameraNode.camera = camera
    cameraNode.position = vec3(0,50,70)
    cameraNode.rotation.x = -Float.pi/2
    rootNode.addChildNode(cameraNode)
  }
  
  func createFloor() {
    let floorNode = SCNNode()
    floorNode.geometry = SCNFloor()
    floorNode.geometry?.firstMaterial?.diffuse.contents = UIColor.blue
    rootNode.addChildNode(floorNode)
  }
  
  func setupLight() {
    lightNode = SCNNode()
    
    let ambientLight = SCNLight()
    ambientLight.type = .ambient
    ambientLight.color = UIColor.white
    let ambientLightNode = SCNNode()
    ambientLightNode.light = ambientLight
    lightNode.addChildNode(ambientLightNode)
    
    let omniLight = SCNLight()
    omniLight.type = .omni
    omniLight.color = UIColor(white: 0.75, alpha: 1.0)
    let omniLightNode = SCNNode()
    omniLightNode.light = omniLight
    omniLightNode.position = vec3(0,80,80)
    lightNode.addChildNode(omniLightNode)
    lightNode.name = "light"
    
    rootNode.addChildNode(lightNode)
  }
}
