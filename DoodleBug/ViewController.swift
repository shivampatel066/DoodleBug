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
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var minusButton: UIButton!
    @IBOutlet weak var plusButton: UIButton!
    
    var swiped = false
    var lastPoint = CGPoint.zero
    
    var red: CGFloat = 0.0
    var green: CGFloat = 0.0
    var blue: CGFloat = 0.0
    
    var brushWidth: CGFloat = 40.0
    
    
   
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.brushSize()
        
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
        
        UIGraphicsBeginImageContext(view.frame.size)
        let context = UIGraphicsGetCurrentContext()
        
        imageView.image?.draw(in: CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height))
        
        context?.move(to: CGPoint(x: fromPoint.x, y: fromPoint.y))
        context?.addLine(to: CGPoint(x: fromPoint.x, y: fromPoint.y))
        
        context?.setLineCap(CGLineCap.round)
        context?.setLineWidth(brushWidth)
        context?.setStrokeColor(red: red, green: green, blue: blue, alpha: 1)
        context?.setBlendMode(CGBlendMode.normal)
        
        context?.strokePath()
        
        imageView.image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        
        
        
        
        
        
        
        
        
        
    }
    
    
    
    @IBAction func red(_ sender: Any) {
        
        (red, green, blue) = (255, 0, 0)
        
    }
    
    @IBAction func green(_ sender: Any) {
       
        (red, green, blue) = (0, 255, 0)
    
    }
    
    
    @IBAction func blue(_ sender: Any) {
    
        (red, green, blue) = (0, 0, 255)
    
    }
    
    @IBAction func black(_ sender: Any) {
        
        (red, green, blue) = (0, 0, 0)
        
    }
    
    @IBAction func white(_ sender: Any) {
        
        (red, green, blue) = (255, 255, 255)
        
    }
    
    
    @IBAction func smallBrush(_ sender: Any) {
    
        brushWidth -= 1
        self.brushSize()
    
    }
    
    @IBAction func largeBrush(_ sender: Any) {
    
        brushWidth += 1
        self.brushSize()
        
    
    }
    
    func brushSize() {
        
        label.text = String(format: "%0.0f",brushWidth)
        
        if brushWidth == 100 {
            
            plusButton.isEnabled = false
            plusButton.alpha = 0.25
            
        } else if brushWidth == 1 {
            
            minusButton.isEnabled = false
            minusButton.alpha = 0.25
            
        } else {
            
            plusButton.isEnabled = true
            plusButton.alpha = 1
            minusButton.isEnabled = true
            minusButton.alpha = 1
            
        }
        
    }
    
    @IBAction func resetButton(_ sender: Any) {
        
        imageView.image = nil
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let settingsVC = segue.destination as! SettingsViewController
        settingsVC.delegate = self
        settingsVC.brushWidth = brushWidth
        settingsVC.red = red
        settingsVC.green = green
        settingsVC.blue = blue
        
        
        
    }
    
    
    
    
    
}


extension ViewController: SettingsViewControllerDelegate {
    
    func settingsViewControllerFinished(_ settingsViewController: SettingsViewController) {
        
        self.brushWidth = settingsViewController.brushWidth
        self.red = settingsViewController.red
        self.green = settingsViewController.green
        self.blue = settingsViewController.blue
        
        self.brushSize()
    }
    
}

