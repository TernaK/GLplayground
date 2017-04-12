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
    scene = SCNScene()
    
    let sceneView = self.view as! GameView
    sceneView.showsStatistics = true
    sceneView.scene = scene
    sceneView.allowsCameraControl = true
    sceneView.delegate = self
//    sceneView.autoenablesDefaultLighting = true
    
    rootNode = scene.rootNode
    
    setupLight()
    setupCamera()
    createXYPlane()
//    createFloor()
    
  }
  
  func setupCamera() {
    cameraNode = SCNNode()
    let camera = SCNCamera()
    camera.zNear = 0.1
    camera.zFar = 50
    cameraNode.camera = camera
    cameraNode.position = vec3(0,0,5)
    rootNode.addChildNode(cameraNode)
  }
  
  func createFloor() {
    let floorNode = SCNNode()
    floorNode.geometry = SCNFloor()
    floorNode.geometry?.firstMaterial?.diffuse.contents = UIColor.purple
    floorNode.position.y = -1.0
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
  
  func spawnShape() {
    let body: SCNNode
    let chance = Float.random
    if chance < 0.2 {
      body = Shapes.BoxNode()
    } else if chance < 0.4 {
      body = Shapes.SphereNode()
    } else if chance < 0.6 {
      body = Shapes.PyramidNode()
    } else if chance < 0.8 {
      body = Shapes.TubeNode()
    } else {
      body = Shapes.CylinderNode()
    }
    body.physicsBody = SCNPhysicsBody(type: .dynamic, shape: nil)
    body.physicsBody?.isAffectedByGravity = true
    body.physicsBody?.applyForce(vec3(2*(Float.random-0.5) * 3, 8, 2*(Float.random-0.5)), asImpulse: true)
    body.physicsBody?.applyTorque(vec4(1, 0, 1, Float.random), asImpulse: true)
    body.position.x = Float.random - 0.5
    body.position.y = -2
    body.name = "body"
    body.geometry?.firstMaterial?.diffuse.contents = UIColor(red: CGFloat(Float.random), green: CGFloat(Float.random), blue: CGFloat(Float.random), alpha: 1.0)
    rootNode.addChildNode(body)
  }
  
  func cleanUp() {
    let list = ["body"]
    for node in rootNode.childNodes(passingTest: { node, _ in return list.contains(node.name ?? "") }) {
      if node.presentation.position.y < -3.0 {
        node.removeFromParentNode()
      }
    }
  }
  
  func explode() {
    // find nodes with the name body and blow them up!
    for node in rootNode.childNodes(passingTest: { node, _ in return node.name == "body" }) {
      if (node.physicsBody?.velocity.y)! < Float(0.5) {
        let nodePosition = node.presentation.position
        let color = node.geometry?.firstMaterial?.diffuse.contents as! UIColor
        let spice = createSpice(color: color, geometry: node.geometry!) // the particle system
        
        // place at node's position
        let transform = SCNMatrix4MakeTranslation(nodePosition.x, nodePosition.y, nodePosition.z)
      	self.scene.addParticleSystem(spice, transform: transform)
        
        // destroy the old guy
        node.removeFromParentNode()
      }
    }
  }
  
  func renderer(_ renderer: SCNSceneRenderer, updateAtTime time: TimeInterval) {
    if time > spawnTime {
      spawnShape()
      spawnTime = time + TimeInterval(1 + 2 * Float.random)
    }
    explode()
//    cleanUp() // not necessary when explode it called
  }
  
  func createSpice(color: UIColor = UIColor.white, geometry: SCNGeometry = SCNSphere(radius: 0.5)) -> SCNParticleSystem {
    let particleSystem = SCNParticleSystem(named: "Spice", inDirectory: nil)!
    particleSystem.particleColor = color
    particleSystem.emitterShape = geometry
    
    return particleSystem
  }
}
