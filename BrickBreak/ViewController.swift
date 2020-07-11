//
//  ViewController.swift
//  BrickBreak
//
//  Created by Cole Michaels on 7/3/20.
//  Copyright © 2020 cmichaelsd. All rights reserved.
//

import MetalKit

enum Colors {
    static let green = MTLClearColor(
        red: 0.0,
        green: 0.4,
        blue: 0.21,
        alpha: 1.0
    )
    static let skyBlue = MTLClearColor(
        red: 0.66,
        green: 0.9,
        blue: 0.96,
        alpha: 1.0
    )
}

class ViewController: UIViewController {
    
    var metalView: MTKView {
        return view as! MTKView
    }
    
    var renderer: Renderer!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        metalView.device = MTLCreateSystemDefaultDevice()
        guard let device = metalView.device else {
            fatalError("device not created")
        }
        
        metalView.clearColor = Colors.green
        metalView.depthStencilPixelFormat = .depth32Float
        
        renderer = Renderer(device: device)
        renderer?.scene = LightingScene(device: device, size: view.bounds.size)
        
        metalView.delegate = renderer
    }
}
