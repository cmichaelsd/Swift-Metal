//
//  LandscapeScene.swift
//  BrickBreak
//
//  Created by Cole Michaels on 7/9/20.
//  Copyright © 2020 cmichaelsd. All rights reserved.
//

import MetalKit

class LandscapeScene: Scene {
    
    let sun: Model
    let ground: Plane
    let grass: Instance
    let mushroom: Model
    
    override init(device: MTLDevice, size: CGSize) {
        sun = Model(device: device, modelName: "sun")
        ground = Plane(device: device)
        grass = Instance(device: device, modelName: "grass", instances: 10000)
        mushroom = Model(device: device, modelName: "mushroom")
        super.init(device: device, size: size)
        add(childNode: sun)
        add(childNode: ground)
        add(childNode: grass)
        add(childNode: mushroom)
        setupScene()
    }
    
    override func update(deltaTime: Float) {}
    
    func setupScene() {
        sun.materialColor = float4(arrayLiteral: 1, 1, 0, 1)
    
        ground.materialColor = float4(arrayLiteral: 0.4, 0.3, 0.1, 1)
        ground.scale = float3(repeating: 20)
        ground.rotation.x = radians(fromDegrees: 90)
        
        let greens = [
            float4(arrayLiteral: 0.34, 0.51, 0.01, 1),
            float4(arrayLiteral: 0.5, 0.5, 0, 1),
            float4(arrayLiteral: 0.29, 0.36, 0.14, 1)
        ]
        for row in 0..<100 {
            for column in 0..<100 {
                var position = float3(repeating: 0)
                position.x = (Float(row)) / 4
                position.z = (Float(column)) / 4

                let blade = grass.nodes[row * 100 + column]
                blade.scale = float3(repeating: 0.5)
                blade.position = position

                blade.materialColor = greens[Int(arc4random_uniform(3))]
                blade.rotation.y = radians(fromDegrees: Float(arc4random_uniform(360)))
            }
        }
        
        grass.position.x = -12
        grass.position.z = -12
        
        mushroom.position.x = -6
        mushroom.position.z = -8
        mushroom.scale = float3(repeating: 2)
        
        sun.position.y = 7
        sun.position.x = 6
        sun.scale = float3(repeating: 2)

        camera.fovDegrees = 25
        camera.rotation.x = radians(fromDegrees: -10)
        camera.position.z = -20
        camera.position.y = -2
        
    }
}
