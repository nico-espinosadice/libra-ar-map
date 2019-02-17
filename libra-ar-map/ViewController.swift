/*
See LICENSE folder for this sample’s licensing information.

Abstract:
Main view controller for the AR experience.
*/

import ARKit
import SceneKit
import UIKit

class ViewController: UIViewController, ARSCNViewDelegate, UITextFieldDelegate {
    
    @IBOutlet var sceneView: ARSCNView!
    
    @IBOutlet weak var blurView: UIVisualEffectView!
    
    /// The view controller that displays the status and "restart experience" UI.
    lazy var statusViewController: StatusViewController = {
        return childViewControllers.lazy.compactMap({ $0 as? StatusViewController }).first!
    }()
    
    /// A serial queue for thread safety when modifying the SceneKit node graph.
    let updateQueue = DispatchQueue(label: Bundle.main.bundleIdentifier! +
        ".serialSceneKitQueue")
    
    /// Convenience accessor for the session owned by ARSCNView.
    var session: ARSession {
        return sceneView.session
    }
    
    // MARK: - View Controller Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sceneView.delegate = self
        sceneView.session.delegate = self

        // Hook up status view controller callback(s).
        statusViewController.restartExperienceHandler = { [unowned self] in
            self.restartExperience()
        }
        
        let scene = SCNScene()
        //let currentCameraPosition = sceneView.pointOfView?.position
        
        
        
        /*let vertcount = 48;
        let verts: [Float] = [ -1.4923, 1.1824, 2.5000, -6.4923, 0.000, 0.000, -1.4923, -1.1824, 2.5000, 4.6077, -0.5812, 1.6800, 4.6077, -0.5812, -1.6800, 4.6077, 0.5812, -1.6800, 4.6077, 0.5812, 1.6800, -1.4923, -1.1824, -2.5000, -1.4923, 1.1824, -2.5000, -1.4923, 0.4974, -0.9969, -1.4923, 0.4974, 0.9969, -1.4923, -0.4974, 0.9969, -1.4923, -0.4974, -0.9969 ];
        
        let facecount = 13;
        let faces: [CInt] = [  3, 4, 3, 3, 3, 4, 4, 4, 4, 4, 4, 4, 4, 0, 1, 2, 3, 4, 5, 6, 7, 1, 8, 8, 1, 0, 2, 1, 7, 9, 8, 0, 10, 10, 0, 2, 11, 11, 2, 7, 12, 12, 7, 8, 9, 9, 5, 4, 12, 10, 6, 5, 9, 11, 3, 6, 10, 12, 4, 3, 11 ];
        
        let vertsData  = NSData(
            bytes: verts,
            length: MemoryLayout<Float>.size * vertcount
        )
        
        let vertexSource = SCNGeometrySource(data: vertsData as Data,
                                             semantic: .vertex,
                                             vectorCount: vertcount,
                                             usesFloatComponents: true,
                                             componentsPerVector: 3,
                                             bytesPerComponent: MemoryLayout<Float>.size,
                                             dataOffset: 0,
                                             dataStride: MemoryLayout<Float>.size * 3)
        
        let polyIndexCount = 61;
        let indexPolyData  = NSData( bytes: faces, length: MemoryLayout<CInt>.size * polyIndexCount )
        
        let element1 = SCNGeometryElement(data: indexPolyData as Data,
                                          primitiveType: .polygon,
                                          primitiveCount: facecount,
                                          bytesPerIndex: MemoryLayout<CInt>.size)
        
        let geometry = SCNGeometry(sources: [vertexSource], elements: [element1])
        
        let material1 = geometry.firstMaterial!
        
        material1.diffuse.contents = UIColor(red: 0.14, green: 0.82, blue: 0.95, alpha: 1.0)
        material1.lightingModel = .lambert
        material1.transparency = 1.00
        material1.transparencyMode = .dualLayer
        material1.fresnelExponent = 1.00
        material1.reflective.contents = UIColor(white:0.00, alpha:1.0)
        material1.specular.contents = UIColor(white:0.00, alpha:1.0)
        material1.shininess = 1.00
        
        //Assign the SCNGeometry to a SCNNode, for example:
        let aNode1 = SCNNode()
        aNode1.geometry = geometry
        aNode1.rotation = SCNVector4(0, 1, 0, 3.14) //Read Me: last number changes angle in radians
        aNode1.scale = SCNVector3(0.1, 0, 0.1) //Changes size of arrow
        aNode1.position = SCNVector3(20.2/2, 0, 0)
        scene.rootNode.addChildNode(aNode1)
        
        let aNode2 = SCNNode()
        aNode2.geometry = geometry
        aNode2.rotation = SCNVector4(0, 1, 0, 3.14) //Read Me: last number changes angle in radians
        aNode2.scale = SCNVector3(0.1, 0, 0.1) //Changes size of arrow
        aNode2.position = SCNVector3(20.2, 0, 0)
        scene.rootNode.addChildNode(aNode2)
        
        let aNode3 = SCNNode()
        aNode3.geometry = geometry
        aNode3.rotation = SCNVector4(0, 1, 0, 3.14) //Read Me: last number changes angle in radians
        aNode3.scale = SCNVector3(0.1, 0, 0.1) //Changes size of arrow
        aNode3.position = SCNVector3(20.2, 0, -80.1/2)
        scene.rootNode.addChildNode(aNode3)
        
        let aNode4 = SCNNode()
        aNode4.geometry = geometry
        aNode4.rotation = SCNVector4(0, 1, 0, 3.14) //Read Me: last number changes angle in radians
        aNode4.scale = SCNVector3(0.1, 0, 0.1) //Changes size of arrow
        aNode4.position = SCNVector3(20.2, 0, -80.1)
        scene.rootNode.addChildNode(aNode4)
        
        let aNode5 = SCNNode()
        aNode5.geometry = geometry
        aNode5.rotation = SCNVector4(0, 1, 0, 3.14) //Read Me: last number changes angle in radians
        aNode5.scale = SCNVector3(0.1, 0, 0.1) //Changes size of arrow
        aNode5.position = SCNVector3(2.33/2, 0, -80.1)
        scene.rootNode.addChildNode(aNode5)
        
        let aNode6 = SCNNode()
        aNode6.geometry = geometry
        aNode6.rotation = SCNVector4(0, 1, 0, 3.14) //Read Me: last number changes angle in radians
        aNode6.scale = SCNVector3(0.1, 0, 0.1) //Changes size of arrow
        aNode6.position = SCNVector3(2.33, 0, -80.1)
        scene.rootNode.addChildNode(aNode6)
        */
        
        
        // make meterial
        let material = SCNMaterial()
        material.diffuse.contents = UIImage.init(named: "pokestop")
        material.diffuse.contents = UIColor.blue
        
        // make shape of node
        let box1 = SCNBox(width: 0.5, height: 0.5, length: 0.5, chamferRadius: 0)
        let box2 = SCNBox(width: 0.5, height: 0.5, length: 0.5, chamferRadius: 0)
        let box3 = SCNBox(width: 0.5, height: 0.5, length: 0.5, chamferRadius: 0)
        let box4 = SCNBox(width: 0.5, height: 0.5, length: 0.5, chamferRadius: 0)
        let box5 = SCNBox(width: 0.5, height: 0.5, length: 0.5, chamferRadius: 0)
        let box6 = SCNBox(width: 0.5, height: 0.5, length: 0.5, chamferRadius: 0.5)
        let box7 = SCNBox(width: 0.5, height: 0.5, length: 0.5, chamferRadius: 0)
        
        
        box1.firstMaterial?.diffuse.contents  = UIColor(red: 0.0 / 255.0, green: 0.0 / 255.0, blue: 255.0 / 255.0, alpha: 1)
        box2.firstMaterial?.diffuse.contents  = UIColor(red: 0.0 / 255.0, green: 255.0 / 255.0, blue: 255.0 / 255.0, alpha: 1)
        box3.firstMaterial?.diffuse.contents  = UIColor(red: 0.0 / 255.0, green: 0.0 / 255.0, blue: 255.0 / 255.0, alpha: 1)
        box4.firstMaterial?.diffuse.contents  = UIColor(red: 0.0 / 255.0, green: 0.0 / 255.0, blue: 255.0 / 255.0, alpha: 1)
        box5.firstMaterial?.diffuse.contents  = UIColor(red: 0.0 / 255.0, green: 0.0 / 255.0, blue: 255.0 / 255.0, alpha: 1)
        box6.firstMaterial?.diffuse.contents  = UIColor(red: 0.0 / 255.0, green: 255.0 / 255.0, blue: 0.0 / 255.0, alpha: 1)
        box7.firstMaterial?.diffuse.contents  = UIColor(red: 0.0 / 255.0, green: 255.0 / 255.0, blue: 0.0 / 255.0, alpha: 1)
    
        let box1Node = SCNNode()
        box1Node.geometry = box1
        box1Node.position = SCNVector3(10, 0, 0)
        
        let box2Node = SCNNode()
        box2Node.geometry = box2
        box2Node.position = SCNVector3(20, 0, 0)
        
        let box3Node = SCNNode()
        box3Node.geometry = box3
        box3Node.position = SCNVector3(20, 0, -27)
        
        let box4Node = SCNNode()
        box4Node.geometry = box4
        box4Node.position = SCNVector3(20, 0, -80)
        
        let box5Node = SCNNode()
        box5Node.geometry = box5
        box5Node.position = SCNVector3(1, 0, -80)
        
        let box6Node = SCNNode()
        box6Node.geometry = box6
        box6Node.position = SCNVector3(2, 0, -80)
        
        let box7Node = SCNNode()
        box7Node.geometry = box7
        box7Node.position = SCNVector3(20, 0, -53)
        
        
        scene.rootNode.addChildNode(box1Node)
        scene.rootNode.addChildNode(box2Node)
        scene.rootNode.addChildNode(box3Node)
        scene.rootNode.addChildNode(box4Node)
        scene.rootNode.addChildNode(box5Node)
        scene.rootNode.addChildNode(box6Node)
        
        sceneView.scene = scene

        
        // TODO: Add more nodes!
        
        // Set the scene to the view
        self.sceneView.scene = scene
    }

	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		
		// Prevent the screen from being dimmed to avoid interuppting the AR experience.
		UIApplication.shared.isIdleTimerDisabled = true

        // Start the AR experience
        resetTracking()
	}
	
	override func viewWillDisappear(_ animated: Bool) {
		super.viewWillDisappear(animated)

        session.pause()
	}

    // MARK: - Session management (Image detection setup)
    
    /// Prevents restarting the session while a restart is in progress.
    var isRestartAvailable = true

    /// Creates a new AR configuration to run on the `session`.
    /// - Tag: ARReferenceImage-Loading
	func resetTracking() {
        
        guard let referenceImages = ARReferenceImage.referenceImages(inGroupNamed: "AR Resources", bundle: nil) else {
            fatalError("Missing expected asset catalog resources.")
        }
        
        let configuration = ARWorldTrackingConfiguration()
        configuration.detectionImages = referenceImages
        session.run(configuration, options: [.resetTracking, .removeExistingAnchors])

        statusViewController.scheduleMessage("Begin walking.", inSeconds: 7.5, messageType: .contentPlacement)
	}

    // MARK: - ARSCNViewDelegate (Image detection results)
    /// - Tag: ARImageAnchor-Visualizing
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        guard let imageAnchor = anchor as? ARImageAnchor else { return }
        let referenceImage = imageAnchor.referenceImage
        updateQueue.async {
            
            // Create a plane to visualize the initial position of the detected image.
            let plane = SCNPlane(width: referenceImage.physicalSize.width,
                                 height: referenceImage.physicalSize.height)
            let planeNode = SCNNode(geometry: plane)
            planeNode.opacity = 0.25
            
            /*
             `SCNPlane` is vertically oriented in its local coordinate space, but
             `ARImageAnchor` assumes the image is horizontal in its local space, so
             rotate the plane to match.
             */
            planeNode.eulerAngles.x = -.pi / 2
            
            /*
             Image anchors are not tracked after initial detection, so create an
             animation that limits the duration for which the plane visualization appears.
             */
            planeNode.runAction(self.imageHighlightAction)
            
            // Add the plane visualization to the scene.
            node.addChildNode(planeNode)
        }

        DispatchQueue.main.async {
            self.statusViewController.cancelAllScheduledMessages()
            self.statusViewController.showMessage("You have arrived!")
        }
    }

    var imageHighlightAction: SCNAction {
        return .sequence([
            .wait(duration: 0.25),
            .fadeOpacity(to: 0.85, duration: 0.25),
            .fadeOpacity(to: 0.15, duration: 0.25),
            .fadeOpacity(to: 0.85, duration: 0.25),
            .fadeOut(duration: 0.5),
            .removeFromParentNode()
        ])
    }
}
