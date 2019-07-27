//
//  Renderer.swift
//  macOSMetal
//
//  Created by Zach Eriksen on 4/30/18.
//  Copyright © 2018 Zach Eriksen. All rights reserved.
//

import MetalKit

class Renderer: NSObject {
    let device: MTLDevice
    var commandQueue: MTLCommandQueue!
    var counter = 0
    var scenes: [Scene] = []

    init(mtkView: MTKView) {
        guard let device = MTLCreateSystemDefaultDevice() else {
            fatalError("failed to create MTLDevice")
        }
        scenes.append(CubeScene(device: device))

        mtkView.device = device
        self.device = device

        mtkView.depthStencilPixelFormat = .depth32Float
        mtkView.colorPixelFormat = .bgra8Unorm
        mtkView.clearColor = MTLClearColor(red: 0.1, green: 0.57, blue: 0.25, alpha: 1)

        // Create command queue to send commands to the GPU
        commandQueue = device.makeCommandQueue()
        super.init()
        printClassAndFunc()
        mtkView.delegate = self
    }
}

extension Renderer: MTKViewDelegate {
    func mtkView(_ view: MTKView, drawableSizeWillChange size: CGSize) {
        printClassAndFunc(info: "\(view) \(size)")
    }

    func draw(in view: MTKView) {
        // printClassAndFunc()
        // Create the commandBuffer for the queue
        guard let commandBuffer = commandQueue.makeCommandBuffer() else {
            printClassAndFunc(info: "makeCommandBuffer failed")
            return
        }
        // Create the interface for the pipeline
        guard let renderDescriptor = view.currentRenderPassDescriptor else {
            printClassAndFunc(info: "view.currentRenderPassDescriptor missing")
            return
        }
        // Set a new background color
        renderDescriptor.colorAttachments[0].clearColor = MTLClearColorMake(0.5, 0.5, 1, 1)

        // Create the command encoder, or the "inside" of the pipeline
        guard let renderCommandEncoder = commandBuffer.makeRenderCommandEncoder(descriptor: renderDescriptor) else {
            printClassAndFunc(info: "makeRenderCommandEncoder failed")
            return
        }

        let deltaTime = 1 / Float(view.preferredFramesPerSecond)

        scenes.forEach { $0.render(commandEncoder: renderCommandEncoder,
                                   deltaTime: deltaTime) }

        renderCommandEncoder.endEncoding()
        commandBuffer.present(view.currentDrawable!)
        commandBuffer.commit()
    }
}
