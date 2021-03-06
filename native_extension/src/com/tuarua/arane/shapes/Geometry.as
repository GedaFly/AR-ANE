// Copyright 2017 Tua Rua Ltd.
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//  http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//
//  Additional Terms
//  No part, or derivative of this Air Native Extensions's code is permitted
//  to be sold as the basis of a commercially packaged Air Native Extension which
//  undertakes the same purpose as this software. That is an ARKit ANE for iOS.
//  All Rights Reserved. Tua Rua Ltd.

package com.tuarua.arane.shapes {
import com.tuarua.ARANEContext;
import com.tuarua.arane.materials.Material;
import com.tuarua.fre.ANEError;

public class Geometry {
    public var nodeId:String;
    private var _materials:Vector.<Material> = new Vector.<Material>();

    public function Geometry() {
    }

    //noinspection ReservedWordAsName
    protected function setANEvalue(type:String, name:String, value:*):void {
        if (nodeId) {
            var theRet:* = ARANEContext.context.call("setGeometryProp", type, nodeId, name, value);
            if (theRet is ANEError) throw theRet as ANEError;
        }
    }

    public function get firstMaterial():Material {
        if (_materials.length == 0) {
            _materials.push(new Material());
            setMaterialsNodeId();
        }
        return _materials[0];
    }

    public function get materials():Vector.<Material> {
        setMaterialsNodeId();
        return _materials;
    }

    private function setMaterialsNodeId():void {
        for each (var material:Material in _materials) {
            material.nodeId = nodeId;
        }
    }
}
}
