//
//  ViewController.swift
//  DoodleBug
//
//  Created by Shivam on 15/04/19.
//  Copyright © 2019 Shivam. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    
    var swiped = false
    var lastPoint = CGPoint.zero
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        swiped = false
        
        if let touch = touches.first as UITouch? {
            
            lastPoint = touch.location(in: self.view)
            
            
        }
        
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        swiped = true
        
        if let touch = touches.first as UITouch? {
            
            let currentPoint = touch.location(in: view)
            drawLine(lastPoint, toPoint: currentPoint)
            
            lastPoint = currentPoint
            
        }
        
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if !swiped {
            
            drawLine(lastPoint, toPoint: lastPoint)
        }
        
        
    }
    
    func drawLine(_ fromPoint: CGPoint, toPoint: CGPoint) {
        
        
        
        
        
        
    }
    
    
    
    
}

