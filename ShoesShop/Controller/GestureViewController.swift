//
//  GestureViewController.swift
//  ShoesShop
//
//  Created by Kosovar Latifi on 20/04/2023.
//
import ObjectiveC
import UIKit
import Photos

class GestureViewController: UIViewController {
    
    
    @IBOutlet weak var saveImage: UIImageView!
    
    @IBOutlet weak var dirtyShoes: UIImageView!
    
    @IBOutlet weak var trashImage: UIImageView!
    
    
    @IBOutlet weak var continueOutlet: UIButton!
    
    var shoesViewOrigin: CGPoint!
    var currentShoesImageIndex = 0
    
    let shoesImage: [UIImage] = [UIImage(named: "beyaz-kadin-klasik-topuklu-ayakkabi-k0-02905d")!,UIImage(named: "dirtyShoes#")!]
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        dirtyShoes.image = shoesImage[currentShoesImageIndex]
    
       addPanGesture(view: dirtyShoes)
        shoesViewOrigin = dirtyShoes.frame.origin
        continueOutlet.layer.cornerRadius = 5
        dirtyShoes.layer.cornerRadius = 10
        trashImage.layer.cornerRadius = 10
        dirtyShoes.layer.cornerRadius = dirtyShoes.frame.height / 2
        dirtyShoes.clipsToBounds = true
        
    }
    
    func addPanGesture(view: UIView) {
        let pan = UIPanGestureRecognizer(target: self, action: #selector(GestureViewController.handlePan(sender:)))
        view.addGestureRecognizer(pan)
    }
    @objc func handlePan(sender: UIPanGestureRecognizer) {
        let shoesView = sender.view!
        let translation = sender.translation(in: view)
        
        switch sender.state {
        case .began, .changed:
            shoesView.center = CGPoint(x: shoesView.center.x + translation.x, y: shoesView.center.y + translation.y)
            sender.setTranslation(CGPoint.zero, in: view)
            
        case .ended:
            if shoesView.frame.intersects(trashImage.frame) {
                // Image intersects with the "trash" imageView
                // Implement the logic for deleting the image if desired
                UIView.animate(withDuration: 0.3, animations: {
                    self.dirtyShoes.alpha = 0.0
                }, completion: { _ in
                    self.changeShoesImage()
                    self.dirtyShoes.alpha = 1.0
                    shoesView.frame.origin = self.shoesViewOrigin // Reset the position
                })
                print("ended to trashImage ")
            } else if shoesView.frame.intersects(saveImage.frame) {
                // Image intersects with the "save" imageView
                UIView.animate(withDuration: 0.3, animations: {
                    self.dirtyShoes.alpha = 0.0
                }, completion: { _ in
                    self.changeShoesImage()
                    self.saveImageAction()
                    self.dirtyShoes.alpha = 1.0
                    shoesView.frame.origin = self.shoesViewOrigin // Reset the position
                })
                print("ended to saveimage ")
            } else {
                print("ended to else ")
                // Image is not intersecting with either imageView
                UIView.animate(withDuration: 0.4, animations: {
                    shoesView.frame.origin = self.shoesViewOrigin
                })
            }
            
        default:
            break
        }
    }




    func changeShoesImage() {
        currentShoesImageIndex += 1
        if currentShoesImageIndex >= shoesImage.count {
            currentShoesImageIndex = 0
        }
        let nextImage = shoesImage[currentShoesImageIndex]
        UIView.transition(with: dirtyShoes, duration: 0.3, options: .transitionCrossDissolve, animations: { self.dirtyShoes.image = nextImage
        } , completion: nil)
    }
    
    
    func saveImageAction() {
        // Get the image from the dirtyShoes imageView
        guard let image = dirtyShoes.image else {
            return
        }

        // Perform the save image logic here
        // For example, you can save the image to the photo library:
        PHPhotoLibrary.requestAuthorization { status in
        }
        
        if PHPhotoLibrary.authorizationStatus() == .authorized {
            UIImageWriteToSavedPhotosAlbum(image, self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)
        }
    }

    @objc func image(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            // Error occurred while saving the image
            print("Error saving image: \(error.localizedDescription)")
        } else {
            // Image saved successfully
            print("Image saved successfully.")
        }
    }
}
