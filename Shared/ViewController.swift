//
//  ViewController.swift
//  macOSMetal
//
//  Created by Rudolf Farkas on 16.08.19.
//  Copyright © 2019 Zach Eriksen. All rights reserved.
//

import MetalKit

class ViewController: NUViewController {
    var mtkView: MTKView!
    var renderer: Renderer!

    override func viewDidLoad() {
        super.viewDidLoad()

        printClassAndFunc()

        mtkView = MTKView()
        view.addSubview(mtkView)

        mtkView.translatesAutoresizingMaskIntoConstraints = false
        mtkView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        mtkView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        mtkView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        mtkView.heightAnchor.constraint(equalTo: mtkView.widthAnchor, multiplier: 1.0).isActive = true

        renderer = Renderer(mtkView: mtkView)
    }
}
