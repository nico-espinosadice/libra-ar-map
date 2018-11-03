//
//  ViewController.swift
//  libra-ar-map
//
//  Created by Nico A. Espinosa Dice on 11/2/18.
//  Copyright © 2018 Nico A. Espinosa Dice. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {
    
    @IBOutlet var sceneView: ARSCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
        
        let scene = SCNScene()
        
        // make meterial
        let material = SCNMaterial()
        material.diffuse.contents = UIImage.init(named: "pokestop")
        material.diffuse.contents = UIColor.blue
        
        // make shape of node
        let box1 = SCNBox(width: 0.1, height: 0.1, length: 0.1, chamferRadius: 0)
        let box2 = SCNBox(width: 0.1, height: 0.1, length: 0.1, chamferRadius: 0)
        let box3 = SCNBox(width: 0.1, height: 0.1, length: 0.1, chamferRadius: 0)
        let box4 = SCNBox(width: 0.1, height: 0.1, length: 0.1, chamferRadius: 0)
        
        box2.firstMaterial?.diffuse.contents  = UIColor(red: 255.0 / 255.0, green: 0.0 / 255.0, blue: 0.0 / 255.0, alpha: 1)
        box3.firstMaterial?.diffuse.contents  = UIColor(red: 0.0 / 255.0, green: 255.0 / 255.0, blue: 0.0 / 255.0, alpha: 1)
        box4.firstMaterial?.diffuse.contents  = UIColor(red: 0.0 / 255.0, green: 0.0 / 255.0, blue: 255.0 / 255.0, alpha: 1)
        
        //let box1Node = SCNNode()
        //box1Node.geometry = box1
        //box1Node.position = SCNVector3(0, 0, 0)
        
        let box2Node = SCNNode()
        box2Node.geometry = box2
        box2Node.position = SCNVector3(0, 0, -17)
        
        let box3Node = SCNNode()
        box3Node.geometry = box3
        box3Node.position = SCNVector3(-21, 0, -17)
        
        let box4Node = SCNNode()
        box4Node.geometry = box4
        box4Node.position = SCNVector3(-21, 0, -12)
        
        
        //scene.rootNode.addChildNode(box1Node)
        scene.rootNode.addChildNode(box2Node)
        scene.rootNode.addChildNode(box3Node)
        scene.rootNode.addChildNode(box4Node)
        sceneView.scene = scene
        
        // TODO: Add more nodes!
        
        // Set the scene to the view
        self.sceneView.scene = scene
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()
        
        // Run the view's session
        sceneView.session.run(configuration)
    }
}
