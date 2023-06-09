//
//  RateTableViewCell.swift
//  ShoesShop
//
//  Created by Kosovar Latifi on 10/05/2023.
//
protocol RecipeDelegate {
    func addToFavorites(recipe: Recipe)
    func rate(recipe: Recipe)
    func getStarted(recipe: Recipe)
}

import UIKit

class RateTableViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var timeToPrepareLabel: UILabel!
    
    @IBOutlet weak var addToFavoriteButton: UIButton!
    @IBOutlet weak var rateButton: UIButton!
    
    var delegate: RecipeDelegate?
    var recipe: Recipe?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        // add long press gesture recognizer to the image view
        let longPressRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress(_:)))
        imageView.addGestureRecognizer(longPressRecognizer)
    }
    
    func setDetails(_ recipe: Recipe) {
        imageView.isUserInteractionEnabled = true
        self.recipe = recipe
        imageView.image = UIImage(named: recipe.image)
        
        timeToPrepareLabel.text = recipe.timeToPrepare
        
        addToFavoriteButton.setImage(UIImage(systemName: recipe.isFavorite ? "heart.fill" : "heart"), for: .normal)
        
        rateButton.setImage(UIImage(systemName: recipe.isRated ? "star.fill" : "star"), for: .normal)
        rateButton.setTitle(recipe.isRated ? "\(recipe.rateValue)" : "", for: .normal)
        rateButton.isUserInteractionEnabled = recipe.isRated ? false : true
    }
    
    @IBAction func favoriteButtonPressed(_ sender: Any) {
        if let recipe = recipe {
            delegate?.addToFavorites(recipe: recipe)
        }
    }
    
    @IBAction func rateButtonPressed(_ sender: Any) {
        if let recipe = recipe {
            delegate?.rate(recipe: recipe)
        }
    }
    
    @IBAction func getStartedPressed(_ sender: UIButton) {
        guard let collectionView = superview as? UICollectionView else { return }
        guard let indexPath = collectionView.indexPath(for: self) else { return }
        
        if let cell = collectionView.cellForItem(at: indexPath) as? RateTableViewCell {
            cell.imageView.isHidden = false // show the image
            
            // add long press gesture recognizer to the image view
            let longPressRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress(_:)))
            cell.imageView.addGestureRecognizer(longPressRecognizer)
        }
    }
    @objc func handleLongPress(_ recognizer: UILongPressGestureRecognizer) {
        guard let imageView = recognizer.view as? UIImageView else {
            return
        }

        if recognizer.state == .began {
            // user started holding the image
            imageView.layer.removeAllAnimations() // cancel the timer animation
            UIView.animate(withDuration: 0.3) {
                imageView.transform = CGAffineTransform(scaleX: 1.2, y: 1.2) // make the image view larger
            }
        } else if recognizer.state == .ended {
            // user released the long press gesture
            UIView.animate(withDuration: 0.3) {
                imageView.transform = .identity // reset the image view to its original size
            } completion: { _ in
                UIView.animate(withDuration: 0.3) {
                    imageView.frame = CGRect(x: 16, y: 16, width: 343, height: 343)
                }
            }
        }
    }
    
    @objc func handleTap(_ recognizer: UITapGestureRecognizer) {
        guard let imageView = recognizer.view as? UIImageView else {
            return
        }
        
        let collectionView = superview as? UICollectionView
        let indexPath = collectionView?.indexPath(for: self)
        
        if let cell = collectionView?.cellForItem(at: indexPath!) as? RateTableViewCell {
            cell.imageView.isHidden = true // hide the image
            
            // create a new view to display the image
            let popupView = UIView(frame: CGRect(x: 0, y: 0, width: 300, height: 400))
            popupView.backgroundColor = .white
            popupView.layer.cornerRadius = 10
            popupView.layer.shadowOpacity = 0.5
            popupView.layer.shadowRadius = 5
            
            let popupImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 300, height: 500))
            popupImageView.image = imageView.image
            popupImageView.contentMode = .scaleAspectFill
            popupImageView.clipsToBounds = true
            popupView.addSubview(popupImageView)
            
            let closeButton = UIButton(frame: CGRect(x: 0, y: 350, width: 300, height: 50))
            closeButton.setTitle("Close", for: .normal)
            closeButton.setTitleColor(.blue, for: .normal)
            closeButton.addTarget(self, action: #selector(closeButtonPressed), for: .touchUpInside)
            popupView.addSubview(closeButton)
            
            let window = UIApplication.shared.windows.first { $0.isKeyWindow }
            let centerPoint = window?.center ?? CGPoint(x: UIScreen.main.bounds.width/2, y: UIScreen.main.bounds.height/2)
            
            popupView.center = centerPoint
            
            window?.addSubview(popupView)
        }
    }
    
    @objc func closeButtonPressed() {
        let window = UIApplication.shared.windows.first { $0.isKeyWindow }
        if let popupView = window?.subviews.first(where: { $0 is UIImageView }) {
            popupView.removeFromSuperview()
        }
    }
}
