/* Copyright 2017 Tua Rua Ltd.
 
 Licensed under the Apache License, Version 2.0 (the "License");
 you may not use this file except in compliance with the License.
 You may obtain a copy of the License at
 
 http://www.apache.org/licenses/LICENSE-2.0
 
 Unless required by applicable law or agreed to in writing, software
 distributed under the License is distributed on an "AS IS" BASIS,
 WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 See the License for the specific language governing permissions and
 limitations under the License.
 
 Additional Terms
 No part, or derivative of this Air Native Extensions's code is permitted
 to be sold as the basis of a commercially packaged Air Native Extension which
 undertakes the same purpose as this software. That is an ARKit wrapper for iOS.
 All Rights Reserved. Tua Rua Ltd.
 */

import Foundation
import ARKit

public extension SCNCapsule {
    convenience init?(_ freObject: FREObject?) {
        guard
            let rv = freObject,
            let capRadius = CGFloat(rv["capRadius"]),
            let height = CGFloat(rv["height"]),
            let radialSegmentCount = Int(rv["radialSegmentCount"]),
            let heightSegmentCount = Int(rv["heightSegmentCount"]),
            let capSegmentCount = Int(rv["capSegmentCount"])
            else {
                return nil
        }
        
        self.init()
        
        self.capRadius = capRadius
        self.height = height
        self.radialSegmentCount = radialSegmentCount
        self.heightSegmentCount = heightSegmentCount
        self.capSegmentCount = capSegmentCount
        
        if let freMaterials = rv["materials"] {
            let freArray = FREArray.init(freMaterials)
            for i in 0..<freArray.length {
                if let freMat = freArray[i], let mat = SCNMaterial.init(freMat) {
                    self.materials[Int(i)] = mat
                }
            }
        }
    }
    
    func setProp(name:String, value:FREObject) {
        switch name {
        case "capRadius":
            self.capRadius = CGFloat(value) ?? self.capRadius
            break
        case "height":
            self.height = CGFloat(value) ?? self.height
            break
        case "radialSegmentCount":
            self.radialSegmentCount = Int(value) ?? self.radialSegmentCount
            break
        case "heightSegmentCount":
            self.heightSegmentCount = Int(value) ?? self.heightSegmentCount
            break
        case "capSegmentCount":
            self.capSegmentCount = Int(value) ?? self.capSegmentCount
            break
        default:
            break
        }
    }
    
}
