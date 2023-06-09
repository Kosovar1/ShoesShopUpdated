//
//  ShoesGalleryViewController.swift
//  ShoesShop
//
//  Created by Kosovar Latifi on 24/04/2023.
//

import UIKit
//

class ShoesGalleryViewController: UIViewController {
    
    var gallery = [#imageLiteral(resourceName: "beyaz-kadin-klasik-topuklu-ayakkabi-k0-02905d.jpg"), #imageLiteral(resourceName: "istockphoto-486719842-612x612.jpg"), #imageLiteral(resourceName: "ryan-plomp-jvoZ-Aux9aw-unsplash"), #imageLiteral(resourceName: "michael-dam-mEZ3PoFGs_k-unsplash"), #imageLiteral(resourceName: "IMG_3545.jpeg")]
    
    @IBOutlet weak var trashImageView: UIImageView!
    //to ceep track of current image that is been displayed
    var nextIndex = 0
    //hold current image view thats displayed
    var currentPicture: UIImageView?
    //constant its gonna hold the current dimension of ich of our images
    let originalSize: CGFloat = 300
    var isActive = false
    //lets activate computet property
    var activeSize: CGFloat {
        return originalSize + 10
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        showNextPicture()
    }
    //a method that calls both function,  whenever i want to create a picture
    func showNextPicture() {
        if let newPicture = createPicture() {
            currentPicture = newPicture
            //animated format
            showPicture(newPicture)
            let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap))
            newPicture.addGestureRecognizer(tap)
            let swipe = UISwipeGestureRecognizer(target: self, action: #selector(self.handleSwipe(_:)))
            newPicture.addGestureRecognizer(swipe)
            //adding direction
            swipe.direction = .up
            let pan = UIPanGestureRecognizer(target: self, action: #selector(self.handlePan(_:)))
            pan.delegate = self
            newPicture.addGestureRecognizer(pan)
            
        } else {
            nextIndex = 0
            showNextPicture()
        }
    }
    @objc func handlePan(_ sender: UIPanGestureRecognizer) {
        guard let view = currentPicture, isActive else { return }
        
        switch sender.state {
        case .began, .changed:
            processPictureMovment(sender: sender, view: view)
        case .ended:
            if view.frame.intersects(trashImageView.frame) {
                deletePicture(imageView: view)
            }
          
            
            
        default: break
            
        }
    }
    func processPictureMovment(sender: UIPanGestureRecognizer, view: UIImageView) {
        let translation = sender.translation(in: view)
        view.center = CGPoint(x: view.center.x + translation.x, y: view.center.y + translation.y)
        sender.setTranslation(.zero, in: view)
        if view.frame.intersects(trashImageView.frame) {
            view.layer.borderColor = UIColor.red.cgColor
        } else {
            view.layer.borderColor = UIColor.green.cgColor
        }
    }
    func deletePicture(imageView: UIImageView) {
        self.gallery.remove(at: nextIndex - 1)
        isActive = false
        UIView.animate(withDuration: 0.4, animations: {
            imageView.alpha = 0
        }) { (_) in
            imageView.removeFromSuperview()
            
            
        }
        showNextPicture()
        
    }
    
    @objc func handleSwipe(_ sender: UISwipeGestureRecognizer) {
        //this guard is only to be able to swipe whenever the picture is not active
        guard !isActive else { return }
        hidePicture(currentPicture!)
        showNextPicture()
        
    }
    @objc func handleTap() {
        //it will toggle it if is active if is true, inverte
        isActive = !isActive
        if isActive {
            activateCurrentPicture()
        } else {
            deactivateCurrentPicture()
        }
    }
    //activate with GestureRecognizer
    func activateCurrentPicture() {
        UIView.animate(withDuration: 0.3) {
            self.currentPicture?.frame.size = CGSize(width: self.activeSize, height: self.activeSize)
            self.currentPicture?.layer.shadowOpacity = 0.5
            self.currentPicture?.layer.borderColor = UIColor.green.cgColor
        }
    }
    func deactivateCurrentPicture() {
        UIView.animate(withDuration: 0.3) {
            self.currentPicture?.frame.size = CGSize(width: self.originalSize, height: self.originalSize)
            self.currentPicture?.layer.shadowOpacity = 0
            self.currentPicture?.layer.borderColor = UIColor.darkGray.cgColor
        }
    }
    //1
    func createPicture() -> UIImageView? {
        guard nextIndex < gallery.count else { return nil }
        let imageView = UIImageView(image: gallery[nextIndex])
        
        imageView.frame = CGRect(x: self.view.frame.width, y: self.view.center.y - (originalSize / 2), width: originalSize, height: originalSize)
        //is enabled tapGesture
        imageView.isUserInteractionEnabled = true
        
        //shadow
        imageView.layer.shadowColor = UIColor.black.cgColor
        //shadow when you tap the image grow the size of image
        imageView.layer.shadowOpacity = 0
        imageView.layer.shadowOffset = .zero
        imageView.layer.shadowRadius = 10
        
        //Frame
        imageView.layer.borderWidth = 2
        imageView.layer.borderColor = UIColor.darkGray.cgColor
        
        
        nextIndex += 1
        return imageView
    }
    //2
    func showPicture(_ imageView: UIImageView) {
        //this gone make our image visible
        
        self.view.addSubview(imageView)
        UIView.animate(withDuration: 0.4) {
            imageView.center = self.view.center
            
        }
    }
    func hidePicture(_ imageView: UIImageView) {
        UIView.animate(withDuration: 0.4, animations: {
            self.currentPicture?.frame.origin.y = -self.originalSize
            
            
        }) { (_) in
            imageView.removeFromSuperview()
        }
       
    }
}
//our swipeGesture is conflicting  with our panGesture,
//so iám gone fix by extention
extension UIViewController: UIGestureRecognizerDelegate {
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    }

