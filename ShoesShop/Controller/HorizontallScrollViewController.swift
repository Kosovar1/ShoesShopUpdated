//
//  HorizontallScrollViewController.swift
//  ShoesShop
//
//  Created by Kosovar Latifi on 27/04/2023.
//

import UIKit

class HorizontallScrollViewController: UIViewController {
    
    
    var newsArray: [String] = ["my1", "my2", "my4", "my5", "my6"]
    let colors: [UIColor] = [.red, .blue, .darkGray, .purple, .cyan, .red]
    
    @IBOutlet weak var horizontalScrollView: UIScrollView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupScrollView()
    }
    func setupScrollView() {
        for i in 0..<newsArray.count {
            let stackView = UIStackView()
            stackView.axis = .vertical
            stackView.alignment = .center
            stackView.distribution = .fill
            stackView.spacing = 8
            
            // Add imageView for each element
            let imageView = UIImageView()
            imageView.image = UIImage(named: newsArray[i])
            imageView.contentMode = .scaleAspectFill
            imageView.clipsToBounds = true
            stackView.addArrangedSubview(imageView)
            imageView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                imageView.widthAnchor.constraint(equalToConstant: self.view.frame.width),
                imageView.heightAnchor.constraint(equalToConstant: 200)
            ])

            // Add headline label for each element
            let headlineLabel = UILabel()
            headlineLabel.backgroundColor = .systemPink
            headlineLabel.text = "Top Rated Shoes \(i+1)"
            headlineLabel.textAlignment = .center
            stackView.addArrangedSubview(headlineLabel)
            headlineLabel.translatesAutoresizingMaskIntoConstraints = false
            headlineLabel.widthAnchor.constraint(equalToConstant: self.view.frame.width).isActive = true
            headlineLabel.heightAnchor.constraint(equalToConstant: 60).isActive = true
            
            stackView.frame = CGRect(x: CGFloat(i) * self.view.frame.width, y: 0, width: self.view.frame.width, height: 430)
            horizontalScrollView.addSubview(stackView)
        }
        horizontalScrollView.contentSize = CGSize(width: CGFloat(newsArray.count) * self.view.frame.width, height: 260)
    }

}

extension UIColor {
    static var random: UIColor {
        return UIColor(
            red: .random(in: 0...1),
            green: .random(in: 0...1),
            blue: .random(in: 0...1),
            alpha: 1.0
        )
    }
}

