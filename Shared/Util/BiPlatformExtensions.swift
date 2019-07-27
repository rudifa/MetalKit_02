//
//  BiPlatformExtensions.swift
//  HelloMetalIOS
//
//  Created by Rudolf Farkas on 27.07.19.
//  Copyright © 2019 Rudolf Farkas. All rights reserved.
//

import MetalKit

#if os(iOS)
    typealias NSUIViewController = UIViewController
    typealias NSUIGestureRecognizer = UIGestureRecognizer
    typealias NSUIPanGestureRecognizer = UIPanGestureRecognizer
    func positiveDeltaIsDownwards(delta: Float) -> Float { return delta }
#elseif os(OSX)
    typealias NSUIViewController = NSViewController
    typealias NSUIGestureRecognizer = NSGestureRecognizer
    typealias NSUIPanGestureRecognizer = NSPanGestureRecognizer
    func positiveDeltaIsDownwards(delta: Float) -> Float { return -delta }
#endif

#if os(iOS)
    extension UIViewController {
        open override func touchesBegan(_ touches: Set<UITouch>, with _: UIEvent?) {
            //        if let location = touches.first?.location(in: view) {
            //           handleInteraction(at: location)
            //        }
        }
    }

#elseif os(OSX)
    extension NSViewController {
        open override func mouseDown(with _: NSEvent) {
            //        var location = view.convert(event.locationInWindow, from: nil)
            //        location.y = view.bounds.height - location.y // Flip from AppKit default window coordinates to Metal viewport coordinates
            //        handleInteraction(at: location)
        }
    }
#endif

#if os(iOS)
    typealias NSUIImage = UIImage
#elseif os(OSX)
    typealias NSUIImage = NSImage
    extension NSImage {
        convenience init(cgImage: CGImage) {
            self.init(cgImage: cgImage, size: CGSize(width: cgImage.width, height: cgImage.height))
        }

        var cgImage: CGImage? {
            return self.cgImage(forProposedRect: nil, context: nil, hints: nil)
        }
    }
#endif
