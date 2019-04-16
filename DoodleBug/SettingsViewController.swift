//
//  SettingsViewController.swift
//  DoodleBug
//
//  Created by Shivam on 16/04/19.
//  Copyright © 2019 Shivam. All rights reserved.
//

import UIKit


protocol SettingsViewControllerDelegate: class {
    
    func settingsViewControllerFinished(_ settingsViewController: SettingsViewController) 
    
}

class SettingsViewController: UIViewController {

    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var brushLabel: UILabel!
    @IBOutlet weak var brushSlider: UISlider!
    @IBOutlet weak var opacityLabel: UILabel!
    @IBOutlet weak var opacitySlider: UISlider!
    
    @IBOutlet weak var redSlider: UISlider!
    @IBOutlet weak var greenSlider: UISlider!
    @IBOutlet weak var blueSlider: UISlider!
    
    @IBOutlet weak var redLabel: UILabel!
    @IBOutlet weak var greenLabel: UILabel!
    @IBOutlet weak var blueLabel: UILabel!
    
    var brushWidth: CGFloat = 40.0
    
    var red: CGFloat = 0.0
    var green: CGFloat = 0.0
    var blue: CGFloat = 0.0
    
    var delegate: SettingsViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.updatePreview()
        
        
        brushLabel.text = String(format: "Brush Size: %.0f", brushWidth)
        brushSlider.value = Float(brushWidth)
        redSlider.value = Float(red * 255)
        greenSlider.value = Float(green * 255)
        blueSlider.value = Float(blue * 255)
        
        redLabel.text = String(format: "%.0f", redSlider.value)
        greenLabel.text = String(format: "%.0f", greenSlider.value)
        blueLabel.text = String(format: "%.0f", blueSlider.value)
        
        
        
    }
    
    
    
    
    @IBAction func exitView(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
        self.delegate?.settingsViewControllerFinished(self)
        
    }
    
    @IBAction func brushSize(_ sender: Any) {
        
        brushWidth = CGFloat(round(brushSlider.value))
        brushLabel.text = String(format: "Brush Size: %.0f", brushWidth)
        self.updatePreview()
        
    }
    @IBAction func opacityChange(_ sender: Any) {
        
        
        
    }
    @IBAction func redColor(_ sender: Any) {
        
        red = CGFloat(redSlider.value/255)
        redLabel.text = String(format: "%.0f", redSlider.value)
        self.updatePreview()
        
    }
    @IBAction func greenColor(_ sender: Any) {
        
        green = CGFloat(greenSlider.value/255)
        greenLabel.text = String(format: "%.0f", greenSlider.value)
        self.updatePreview()
        
    }
    
    @IBAction func blueColor(_ sender: Any) {
        
        blue = CGFloat(blueSlider.value/255)
        blueLabel.text = String(format: "%.0f", blueSlider.value)
        self.updatePreview()
        
    }
    
    func updatePreview() {
        
        UIGraphicsBeginImageContext(imageView.frame.size)
        let context = UIGraphicsGetCurrentContext()
        
        context?.setLineCap(CGLineCap.round)
        context?.setLineWidth(brushWidth)
        context?.setStrokeColor(red: red, green: green, blue: blue, alpha: 1)
        context?.setBlendMode(CGBlendMode.normal)
        context?.move(to: CGPoint(x: imageView.frame.width / 2, y: imageView.frame.height / 2))
        context?.addLine(to: CGPoint(x: imageView.frame.width / 2, y: imageView.frame.height / 2))
        
        context?.strokePath()
        
        imageView.image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        
        
        
        
    }
    
    
    

}
