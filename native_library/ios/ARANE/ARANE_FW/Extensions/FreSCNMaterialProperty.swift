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

public extension SCNMaterialProperty {
    convenience init?(_ freObject: FREObject?) {
        guard let rv = freObject,
            let freContents = rv["contents"],
            let intensity = CGFloat(rv["intensity"]),
            let minificationFilter = Int(rv["minificationFilter"]),
            let magnificationFilter = Int(rv["magnificationFilter"]),
            let wrapS = Int(rv["wrapS"]),
            let wrapT = Int(rv["wrapT"]),
            let mappingChannel = Int(rv["mappingChannel"]),
            let maxAnisotropy = CGFloat(rv["maxAnisotropy"]),
            let mipFilter = Int(rv["mipFilter"])
            else {
                return nil
        }

        self.init()
        
        switch freContents.type {
        case .bitmapdata:
            self.contents = UIImage.init(freObject: freContents)
            break
        case .string:
            if let file = String(freContents) {
                self.contents = UIImage.init(contentsOfFile: file)
            }
            break
        case .int:
            self.contents = UIColor.init(freObject: freContents)
            break
        default:
            return nil
        }
        
        self.intensity = intensity
        self.magnificationFilter = SCNFilterMode.init(rawValue: magnificationFilter) ?? .linear
        self.minificationFilter = SCNFilterMode.init(rawValue: minificationFilter) ?? .linear
        self.mipFilter = SCNFilterMode.init(rawValue: mipFilter) ?? .nearest
        self.wrapS = SCNWrapMode.init(rawValue: wrapS) ?? .clamp
        self.wrapT = SCNWrapMode.init(rawValue: wrapT) ?? .clamp
        self.mappingChannel = mappingChannel
        self.maxAnisotropy = maxAnisotropy
    }
    
    func setProp(name:String, value:FREObject) {
        switch name {
        case "contents":
            switch value.type {
            case .bitmapdata:
                self.contents = UIImage.init(freObject: value)
                break
            case .string:
                if let file = String(value) {
                    self.contents = UIImage.init(contentsOfFile: file)
                }
                break
            case .int:
                self.contents = UIColor.init(freObject: value)
                break
            default:
                return
            }
            break
        case "intensity":
            self.intensity = CGFloat(value) ?? self.intensity
            break
        case "minificationFilter":
            if let minificationFilter = Int(value) {
                self.magnificationFilter = SCNFilterMode.init(rawValue: minificationFilter) ?? .linear
            }
            break
        case "magnificationFilter":
            if let magnificationFilter = Int(value) {
                self.magnificationFilter = SCNFilterMode.init(rawValue: magnificationFilter) ?? .linear
            }
            break
        case "mipFilter":
            if let mipFilter = Int(value) {
                self.mipFilter = SCNFilterMode.init(rawValue: mipFilter) ?? .nearest
            }
            break
        case "wrapS":
            if let wrapS = Int(value) {
                self.wrapS = SCNWrapMode.init(rawValue: wrapS) ?? .clamp
            }
            break
        case "wrapT":
            if let wrapT = Int(value) {
                self.wrapT = SCNWrapMode.init(rawValue: wrapT) ?? .clamp
            }
            break
        case "mappingChannel":
            self.mappingChannel = Int(value) ?? 0
            break
        case "maxAnisotropy":
            self.maxAnisotropy = CGFloat(value) ?? 1.0
            break
        default:
            break
        }
    }
    
}
