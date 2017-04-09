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
  
  var lightNode:SCNNode!
  var rootNode:SCNNode!
  var cameraNode:SCNNode!
  var spacemanNode:SCNNode!
  var moveSpeed:Float = 1.0
  var movePace:Float = 10.0
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // create a new scene
    let scene = SCNScene(named: "art.scnassets/hero.dae")!
    
    let sceneView = self.view as! SCNView
    sceneView.scene = scene
    sceneView.showsStatistics = true
    sceneView.allowsCameraControl = true
    sceneView.delegate = self
    
    rootNode = scene.rootNode
    
    setupLighting(scene: scene)
    setupCameras(scene: scene)
    
    spacemanNode = rootNode.childNode(withName: "hero", recursively: true)!
    spacemanNode.position.z = -200
    
    rootNode.addChildNode(createFloorNode())
    rootNode.addChildNode(Obstacles.PyramidNode())
    rootNode.addChildNode(Obstacles.createStartingText())
  }
  override var shouldAutorotate: Bool {
    return true
  }
  
  override var prefersStatusBarHidden: Bool {
    return true
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Release any cached data, images, etc that aren't in use.
  }
  
  func setupCameras(scene:SCNScene) {
    cameraNode = rootNode.childNode(withName: "camera", recursively: true)
    cameraNode.camera = SCNCamera()
    cameraNode.constraints = [SCNLookAtConstraint(target: spacemanNode)]
    cameraNode.camera!.zFar = 500
//    cameraNode.position = SCNVector3(x: 0.0, y: 200.0, z: 200.0)
    //cameraNode.rotation = SCNVector4(x: 1.0, y: 0.0, z: 0.0, w: -Float.pi/4*0.75)
    rootNode.addChildNode(cameraNode)
  }
  
  func createFloorNode() -> SCNNode {
    let floorNode = SCNNode()
    floorNode.geometry = SCNFloor()
    floorNode.geometry?.firstMaterial?.diffuse.contents = "Floor"
    floorNode.position.y = -1.0
    
    return floorNode
  }
  
  func setupLighting(scene:SCNScene) {
    let ambientLight = SCNNode()
    ambientLight.light = SCNLight()
    ambientLight.light!.type = .ambient
    ambientLight.light!.color = UIColor(white: 0.3, alpha: 1.0)
    scene.rootNode.addChildNode(ambientLight)
    lightNode = SCNNode()
    lightNode.light = SCNLight()
    lightNode.light!.type = .spot
    lightNode.light!.castsShadow = true
    lightNode.light!.color = UIColor(white: 0.8, alpha: 1.0)
//    lightNode.position = SCNVector3Make(0, 80, 30)
//    lightNode.rotation = SCNVector4Make(1, 0, 0, Float(-Double.pi/2.8))
    lightNode.light!.spotInnerAngle = 0
    lightNode.light!.spotOuterAngle = 50
    lightNode.light!.shadowColor = UIColor.black
    lightNode.light!.zFar = 500
    lightNode.light!.zNear = 50
    scene.rootNode.addChildNode(lightNode)
  }
  
  func renderer(_ renderer: SCNSceneRenderer, didSimulatePhysicsAtTime time: TimeInterval) {
    moveWithSpaceman()
    
    let numTouces = (self.view as! GameView).touchCount
    
    switch numTouces {
    case 1:
      spacemanNode.runAction(SCNAction.moveBy(x: 0, y: 0, z: CGFloat(movePace), duration: TimeInterval(moveSpeed)))
    case 2:
      spacemanNode.runAction(SCNAction.moveBy(x: 0, y: 0, z: CGFloat(-movePace), duration: TimeInterval(moveSpeed)))
    case 3:
      spacemanNode.runAction(SCNAction.move(to: vec3(0,0,0), duration: TimeInterval(moveSpeed)))
    default:
      break
    }
  }
  
  func moveWithSpaceman() {
    let spacemanPosition = spacemanNode.position
    let target = vec3(spacemanPosition.x, 30.0, spacemanPosition.z + 20.0)
    let damping:Float = 0.3
    cameraNode.position = cameraNode.position * (1 - damping) + target * damping
    lightNode.position = vec3(spacemanPosition.x, 90.0, spacemanPosition.z + 40.0)
    lightNode.rotation = vec4(1.0, 0.0, 0.0,-Float.pi/2.8)
  }
}
