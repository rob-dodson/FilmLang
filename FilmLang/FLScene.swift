//
//  FLScene.swift
//  FilmLang
//
//  Created by Robert Dodson on 10/7/20.
//  Copyright © 2020 Robert Dodson. All rights reserved.
//

import Foundation
import Cocoa
import SceneKit
import SceneKit.ModelIO

import RobToolsLibrary

class FLScene : Block
{
    var scene:SCNScene!
    var sceneView      : SCNView!
    var cameraNode     : SCNNode!
    var objFileURL     : URL!
    var objectPosition : SCNVector3!
    var objectScale    : SCNVector3!
    var cameraPosition : SCNVector3!
    var lightPosition  : SCNVector3!
    var objectColor    : NSColor!
    
    override func parseBlock(dict:NSDictionary)
    {
        super.parseBlock(dict: dict)
        
        if let objfilepath   = dict["objectFilePath"] as? String
        {
            self.objFileURL = RFile.makeFilePathURL(rootPath: Javascript.runFolder!.absoluteString, filePath: objfilepath)
        }
        
        if let objectscale    = dict["objectScale"]    as? NSDictionary { self.objectScale = vectorFromDict(dict: objectscale) }
        if let objectposition = dict["objectPosition"] as? NSDictionary { self.objectPosition = vectorFromDict(dict: objectposition) }
        if let objectcolor    = dict["objectColor"]    as? NSDictionary { self.objectColor = Block.colorFromDict(dict: objectcolor) }
        if let cameraposition = dict["cameraPosition"] as? NSDictionary { self.cameraPosition = vectorFromDict(dict: cameraposition) }
        if let lightposition  = dict["lightPosition"]  as? NSDictionary { self.lightPosition = vectorFromDict(dict: lightposition) }
    }
    
    
    override func draw()
    {
        preDraw()
        
        if scene == nil
        {
            buildscene()
            
            sceneView = SCNView()
            sceneView.scene = scene
            sceneView.allowsCameraControl = true
           //sceneView.showsStatistics = true
            sceneView.backgroundColor = fillColor ?? NSColor.black
            
            Block.view.addSubview(sceneView)
        }
        
        sceneView.setFrameOrigin(NSPoint(x: boundingRect!.origin.x, y: boundingRect!.origin.y))
        sceneView.setFrameSize(NSSize(width: boundingRect!.width, height: boundingRect!.height))
        
        postDraw()
        
    }
    
    func vectorFromDict(dict:NSDictionary) -> SCNVector3
    {
        let x = CGFloat.init(dict["x"] as! Double)
        let y = CGFloat.init(dict["y"] as! Double)
        let z = CGFloat.init(dict["z"] as! Double)
        
        return SCNVector3(x:x,y:y,z:z)
    }
    
    func buildscene()
    {
        //
        // create a new scene
        //
        scene = SCNScene()


        //
        // create and add a camera to the scene
        //
        cameraNode = SCNNode()
        cameraNode.camera = SCNCamera()
        scene?.rootNode.addChildNode(cameraNode)
        cameraNode.position = cameraPosition
        cameraNode.camera?.automaticallyAdjustsZRange = true


        //
        // create and add a light to the scene
        //
        let lightNode = SCNNode()
        lightNode.light = SCNLight()
        lightNode.light!.type = .omni
        lightNode.position = lightPosition
        lightNode.light!.color = NSColor.orange
        scene?.rootNode.addChildNode(lightNode)

        //
        // create and add an ambient light to the scene
        //
        let ambientLightNode = SCNNode()
        ambientLightNode.light = SCNLight()
        ambientLightNode.light!.type = .ambient
        ambientLightNode.light!.color = NSColor.darkGray
        scene?.rootNode.addChildNode(ambientLightNode)
        
        
        //
        // load object
        //
        let asset = MDLAsset(url: objFileURL)
        let object = asset.object(at: 0)
        let node = SCNNode(mdlObject: object)
        node.position = objectPosition
        node.scale = objectScale
        let mat = SCNMaterial()
        mat.diffuse.contents =  objectColor
        node.geometry?.materials = [mat]
        scene?.rootNode.addChildNode(node)
          
    }
    
    func runscene()
    {
        //
        // time wait action
        //
        let actionwait = SCNAction.wait(duration:0.1)

        //
        // run action: colorwar animation is done in this action
        //
        let run = SCNAction.run
        { _ in
            self.draw()
        }

        //
        // the sequence is an array of two actions
        //
        let moveSequence = SCNAction.sequence([actionwait, run])
        let forever = SCNAction.repeatForever(moveSequence)

        //
        // attach colorwar animation to the root node
        //
        scene?.rootNode.runAction(forever)
    }
}
