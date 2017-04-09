//
//  Utility.swift
//  GLplayground
//
//  Created by Terna Kpamber on 4/7/17.
//  Copyright © 2017 Terna Kpamber. All rights reserved.
//

import UIKit
import SceneKit

typealias vec3 = SCNVector3
typealias vec4 = SCNVector4
typealias mat4 = SCNMatrix4

extension vec3: CustomStringConvertible {
  public var description: String {
    return "[\(self.x), \(self.y), \(self.z)]"
  }
}


/* SCNVector3 / vec3 */

func *(left: SCNVector3, right: Float) -> SCNVector3 {
  return SCNVector3(left.x*right, left.y*right, left.z*right)
}

func *(left: SCNVector3, right: SCNVector3) -> SCNVector3 {
  return SCNVector3(left.x*right.x, left.y*right.y, left.z*right.z)
}

func *=(left: inout SCNVector3, right: Float) {
  left.x = left.x*right
  left.y = left.y*right
  left.z = left.z*right
}

func *=(left: inout SCNVector3, right: SCNVector3) {
  left.x = left.x*right.x
  left.y = left.y*right.y
  left.z = left.z*right.z
}

func /(left: SCNVector3, right: Float) -> SCNVector3 {
  return SCNVector3(left.x / right, left.y / right, left.z / right)
}

func /(left: SCNVector3, right: SCNVector3) -> SCNVector3 {
  return SCNVector3(left.x / right.x, left.y / right.y, left.z / right.z)
}

func /=(left: inout SCNVector3, right: Float) {
  left.x = left.x / right
  left.y = left.y / right
  left.z = left.z / right
}

func /=(left: inout SCNVector3, right: SCNVector3) {
  left.x = left.x / right.x
  left.y = left.y / right.y
  left.z = left.z / right.z
}

func +(left: SCNVector3, right: Float) -> SCNVector3 {
  return SCNVector3(left.x + right, left.y + right, left.z + right)
}

func +(left: SCNVector3, right: SCNVector3) -> SCNVector3 {
  return SCNVector3(left.x + right.x, left.y + right.y, left.z + right.z)
}

func +=(left: inout SCNVector3, right: Float) {
  left.x = left.x + right
  left.y = left.y + right
  left.z = left.z + right
}

func +=(left: inout SCNVector3, right: SCNVector3) {
  left.x = left.x + right.x
  left.y = left.y + right.y
  left.z = left.z + right.z
}

func -(left: SCNVector3, right: Float) -> SCNVector3 {
  return SCNVector3(left.x - right, left.y - right, left.z - right)
}

func -(left: SCNVector3, right: SCNVector3) -> SCNVector3 {
  return SCNVector3(left.x - right.x, left.y - right.y, left.z - right.z)
}

func -=(left: inout SCNVector3, right: Float) {
  left.x = left.x - right
  left.y = left.y - right
  left.z = left.z - right
}

func -=(left: inout SCNVector3, right: SCNVector3) {
  left.x = left.x - right.x
  left.y = left.y - right.y
  left.z = left.z - right.z
}
