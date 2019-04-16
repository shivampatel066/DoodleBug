//
//  ViewController.swift
//  DoodleBug
//
//  Created by Shivam on 15/04/19.
//  Copyright © 2019 Shivam. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var revealButton: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var minusButton: UIButton!
    @IBOutlet weak var plusButton: UIButton!
    @IBOutlet weak var secondImage: UIImageView!
    @IBOutlet weak var stack1: UIStackView!
    @IBOutlet weak var stack2: UIStackView!
    
    
    
    var swiped = false
    var lastPoint = CGPoint.zero
    
    var red: CGFloat = 0.0
    var green: CGFloat = 0.0
    var blue: CGFloat = 0.0
    
    var brushWidth: CGFloat = 40.0
    var opacity: CGFloat = 1.0
    
    
   var hideState = false
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.brushSize()
        
        revealButton.isHidden = true
        revealButton.alpha = 0.25
        
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
        UIGraphicsBeginImageContext(secondImage.frame.size)
        
        imageView.image?.draw(in: CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height), blendMode: CGBlendMode.normal, alpha: 1.0)
        secondImage.image?.draw(in: CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height), blendMode: CGBlendMode.normal, alpha: opacity)
        
        imageView.image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        
        secondImage.image = nil
        
        
    }
    
    func drawLine(_ fromPoint: CGPoint, toPoint: CGPoint) {
        
        UIGraphicsBeginImageContext(view.frame.size)
        let context = UIGraphicsGetCurrentContext()
        
        secondImage.image?.draw(in: CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height))
        
        context?.move(to: CGPoint(x: fromPoint.x, y: fromPoint.y))
        context?.addLine(to: CGPoint(x: fromPoint.x, y: fromPoint.y))
        
        context?.setLineCap(CGLineCap.round)
        context?.setLineWidth(brushWidth)
        context?.setStrokeColor(red: red, green: green, blue: blue, alpha: opacity)
        context?.setBlendMode(CGBlendMode.normal)
        
        context?.strokePath()
        
        secondImage.image = UIGraphicsGetImageFromCurrentImageContext()
        secondImage.alpha = opacity
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
        settingsVC.opacity = opacity
        
        
        
    }
    
    
    @IBAction func saveImage(_ sender: Any) {
        
        UIGraphicsBeginImageContext(imageView.bounds.size)
        imageView.image?.draw(in: CGRect(x: 0, y: 0, width: imageView.frame.size.width, height: imageView.frame.size.height))
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        let activity = UIActivityViewController(activityItems: [image!], applicationActivities: nil)
        present(activity, animated: true, completion: nil)
        
        
        
    }
    
    
    @IBAction func hide(_ sender: Any) {
        
        stack1.isHidden = true
        stack2.isHidden = true
        revealButton.isHidden = false
        
        
        
    }
    
    @IBAction func reveal(_ sender: Any) {
        
        stack1.isHidden = false
        stack2.isHidden = false
        revealButton.isHidden = true
        
    }
    
    
}


extension ViewController: SettingsViewControllerDelegate {
    
    func settingsViewControllerFinished(_ settingsViewController: SettingsViewController) {
        
        self.brushWidth = settingsViewController.brushWidth
        self.red = settingsViewController.red
        self.green = settingsViewController.green
        self.blue = settingsViewController.blue
        self.opacity = settingsViewController.opacity
        
        self.brushSize()
    }
    
}

