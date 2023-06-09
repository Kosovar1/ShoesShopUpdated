//
//  RateViewController.swift
//  ShoesShop
//
//  Created by Kosovar Latifi on 10/05/2023.
//

import UIKit


class RateViewController: UIViewController {
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    

    var recipesArray: [Recipe] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        createRecipes()
        
    }
    
    func createRecipes() {
        let recipe1 = Recipe(id: 1, image: "my1", name: "Sandale", timeToPrepare: "Save with heart, rate with the star", stepsToPrepare: "Rate with star")
        let recipe2 = Recipe(id: 2, image: "my2", name: "Patike", timeToPrepare: "Save with heart, rate with the star")
        let recipe3 = Recipe(id: 3, image: "my4", name: " Shoes", timeToPrepare: "Save with heart, rate with the star", stepsToPrepare: "some steps")
        let recipe4 = Recipe(id: 4, image: "my6", name: "Shoes", timeToPrepare: "Save with heart, rate with the star", stepsToPrepare: "some steps")
        let recipe5 = Recipe(id: 5, image: "my7", name: "Shoes", timeToPrepare: "Save with heart, rate with the star", stepsToPrepare: "some steps")
        let recipe6 = Recipe(id: 6, image: "my8", name: "Shoes", timeToPrepare: "Save with heart, rate with the star", stepsToPrepare: "some steps")
        let recipe7 = Recipe(id: 7, image: "my9", name: "Shoes", timeToPrepare: "Save with heart, rate with the star", stepsToPrepare: "some steps")
        recipesArray = [recipe1, recipe2, recipe3, recipe4, recipe5, recipe6, recipe7]
    }
}

extension RateViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "RateTableViewCell", bundle: nil), forCellWithReuseIdentifier: "RateTableViewCell")
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return recipesArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RateTableViewCell", for: indexPath) as! RateTableViewCell
        cell.setDetails(recipesArray[indexPath.item])
        cell.delegate = self
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.item == 0 {
            return CGSize(width: self.view.frame.width, height: self.view.frame.width * 0.7)
        } else {
            return CGSize(width: (self.view.frame.width / 2) - 3, height: (self.view.frame.width / 1.8) - 3)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("selected recipe name = \(recipesArray[indexPath.item].name)")
        //DSH: kalo ne RecipeDetailsViewController dhe shfaq details te Recipe
    }
}

extension RateViewController: RecipeDelegate {
    func addToFavorites(recipe: Recipe) {
        for i in 0...recipesArray.count - 1 {
            if recipe.id == recipesArray[i].id {
                recipesArray[i].isFavorite = !recipesArray[i].isFavorite
            }
        }
        collectionView.reloadData()
    }
    
    func rate(recipe: Recipe) {
        showAlertFor(recipe: recipe)
    }
    
    func getStarted(recipe: Recipe) {
        print("get started with \(recipe.name)")
    }
}

extension RateViewController {
    func showAlertFor(recipe: Recipe) {
        let alert = UIAlertController(title: "Rate", message: "How do you rate \(recipe.name)?", preferredStyle: .alert)
        
        alert.addTextField { rateTextfield in
            rateTextfield.placeholder = "Enter your rate here"
            rateTextfield.keyboardType = .numberPad
        }
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel) { _ in
        }
        alert.addAction(cancel)
        
        let rate = UIAlertAction(title: "Rate", style: .default) { _ in
            let rateValue = Int(alert.textFields?[0].text ?? "")
        
            //zevendesim per iterim
//            let filteredRecipe = self.recipesArray.filter ({ $0.id == recipe.id }).first
            
            for i in 0...self.recipesArray.count - 1 {
                if recipe.id == self.recipesArray[i].id {
                    self.recipesArray[i].isRated = true
                    if let rateValue = rateValue {
                        self.recipesArray[i].rateValue = rateValue
                    }
                    self.collectionView.reloadData()
                }
            }
        }
        
        alert.addAction(rate)
        self.present(alert, animated: true)
    }
}
