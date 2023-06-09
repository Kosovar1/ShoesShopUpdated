//
//  FramesBoundsController.swift
//  ShoesShop
//
//  Created by Kosovar Latifi on 21/04/2023.
//
import UIKit

class FramesAndBoundsViewController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var view2: UIView!
    @IBOutlet weak var view1Slider: UISlider!
    @IBOutlet weak var view2Slider: UISlider!
    @IBOutlet weak var view1Label: UILabel!
    @IBOutlet weak var view2Label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set up the scroll view
        scrollView.isPagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.contentSize = CGSize(width: view.bounds.width * 2, height: view.bounds.height)
        
        // Set up the initial positions of the views
        view1.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height)
        view2.frame = CGRect(x: view.bounds.width, y: 0, width: view.bounds.width, height: view.bounds.height)
        
        // Add the views to the scroll view
        scrollView.addSubview(view1)
        scrollView.addSubview(view2)
        
        // Set the initial values of the sliders
        view1Slider.value = Float(view1.frame.origin.x)
        view2Slider.value = Float(view2.frame.origin.x)
        
        // Update the labels
        updateLabels()
    }
    
    @IBAction func view1SliderChanged(_ sender: UISlider) {
        let x = CGFloat(sender.value)
        view1.frame.origin.x = x
        scrollView.contentOffset.x = x
        
        updateLabels()
    }
    
    @IBAction func view2SliderChanged(_ sender: UISlider) {
        let x = CGFloat(sender.value)
        view2.frame.origin.x = x
        scrollView.contentOffset.x = x
        
        updateLabels()
    }
    
    private func updateLabels() {
        view1Label.text = "View 1: \(Int(view1.frame.origin.x))"
        view2Label.text = "View 2: \(Int(view2.frame.origin.x))"
    }
}
