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

class FLScene : Block
{
    var scene:SCNScene!
    var sceneView : SCNView!
    
    override func parseBlock(dict:NSDictionary)
    {
        super.parseBlock(dict: dict)
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
            sceneView.backgroundColor = NSColor.black
            Block.view.addSubview(sceneView)
        }
        
        sceneView.setFrameOrigin(NSPoint(x: boundingRect!.origin.x, y: boundingRect!.origin.y))
        sceneView.setFrameSize(NSSize(width: boundingRect!.width, height: boundingRect!.height))
        
        postDraw(rect: boundingRect)
        
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
        let cameraNode = SCNNode()
        cameraNode.camera = SCNCamera()
        scene?.rootNode.addChildNode(cameraNode)
        let xcam = width / 2
        let ycam = height / 2
        cameraNode.position = SCNVector3(x: CGFloat(xcam), y: CGFloat(ycam), z: 250)
        cameraNode.camera?.automaticallyAdjustsZRange = true


        //
        // create and add a light to the scene
        //
        let lightNode = SCNNode()
        lightNode.light = SCNLight()
        lightNode.light!.type = .omni
        lightNode.position = SCNVector3(x: 50, y: height, z: 100)
        scene?.rootNode.addChildNode(lightNode)

        //
        // create and add an ambient light to the scene
        //
        let ambientLightNode = SCNNode()
        ambientLightNode.light = SCNLight()
        ambientLightNode.light!.type = .ambient
        ambientLightNode.light!.color = NSColor.darkGray
        scene?.rootNode.addChildNode(ambientLightNode)
        
        let url = NSURL.fileURL(withPath: "/Users/robertdodson/Desktop/FILM/teapot.obj")
        let asset = MDLAsset(url: url)
        let object = asset.object(at: 0)
        let node = SCNNode(mdlObject: object)
        node.position = SCNVector3(x:CGFloat(width / 2), y:CGFloat(height / 3), z:0)
        node.scale = SCNVector3(x:50, y:50, z:50)

        let mat = SCNMaterial()
        mat.diffuse.contents =  NSColor.red
        node.geometry?.materials = [mat]
        scene?.rootNode.addChildNode(node)
        
          
    }
    
    func runscene()
    {
        //
        // time wait action
        //
        let actionwait = SCNAction.wait(duration:0.001)

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
