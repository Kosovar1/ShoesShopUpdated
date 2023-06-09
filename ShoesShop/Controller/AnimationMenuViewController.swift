//
//  AnimationMenuViewController.swift
//  ShoesShop
//
//  Created by Kosovar Latifi on 23/04/2023.
//

import UIKit
import WebKit
import NVActivityIndicatorView


class AnimationMenuViewController: UIViewController {
    
    @IBOutlet weak var topBarView: UIView!
    @IBOutlet var menuView: UIView!
    @IBOutlet weak var menuTable: UITableView!
    @IBOutlet weak var webView: WKWebView!
    
    @IBOutlet weak var loader: NVActivityIndicatorView!
    
    @IBOutlet weak var loaderAlpa: UIView!
    
    var isMenuOpen: Bool = false
    var pagesArray: [Page] = []
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // Show the popup notification
        let alertController = UIAlertController(title: "Notification", message: "Please choose a website", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        
        // Set the position of the alert controller
        alertController.popoverPresentationController?.sourceView = view
        alertController.popoverPresentationController?.sourceRect = CGRect(x: 16, y: 32, width: 1, height: 1)
        alertController.popoverPresentationController?.permittedArrowDirections = []
        
        present(alertController, animated: true, completion: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupMenuView()
        createPages()
        setupTable()
        
        loader.startAnimating()
        loaderAlpa.alpha = 0.5
    }
    
    func createPages() {
        let page1 = Page(name: "Bambi", url: "https://bambi.shoes")
        pagesArray.append(page1)

        let page2 = Page(name: "Gentli", url: "https://gentli.com")
        pagesArray.append(page2)

        let page3 = Page(name: "LinkedIn", url: "https://www.linkedin.com/")
        pagesArray.append(page3)

        let page4 = Page(name: "Intersport", url: "https://intersportks.com/kategoria/femra/")
        pagesArray.append(page4)
    }
 
    @IBAction func menuButtonPressed(_ sender: Any) {
        if isMenuOpen == false {
            showMenu()
            isMenuOpen = true
        } else {
            hideMenu()
            isMenuOpen = false
        }
    }
  

}

// MARK: Menu Methods
extension AnimationMenuViewController {
    func setupMenuView() {
        menuView.frame = CGRect(x: 0,
                                y: -menuView.frame.height,
                                width: 0,
                                height: self.view.frame.height - topBarView.frame.height)
        self.view.addSubview(menuView)
    }
    
    func showMenu() {
        UIView.animate(withDuration: 0.5) {
            self.menuView.frame = CGRect(x: 0,
                                         y: self.topBarView.frame.height,
                                    width: 0.5 * self.view.frame.width,
                                         height: self.view.frame.height - self.topBarView.frame.height)
            self.menuView.backgroundColor = UIColor.systemBlue
        }
    }
    
    func hideMenu() {
        UIView.animate(withDuration: 5) {
            self.menuView.frame = CGRect(x: 0,
                                         y: -self.topBarView.frame.height,
                                    width: 0,
                                         height: self.view.frame.height - self.topBarView.frame.height)
        }
    }
}

// MARK: Table View
extension AnimationMenuViewController: UITableViewDelegate, UITableViewDataSource, WKUIDelegate, WKNavigationDelegate {
    func setupTable() {
        menuTable.delegate = self
        menuTable.dataSource = self
        webView.uiDelegate = self
        loadUrl(urlString: pagesArray[0].url)
        webView.navigationDelegate = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pagesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PageCell")!
        cell.textLabel?.text = pagesArray[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // load page url
        loadUrl(urlString: pagesArray[indexPath.row].url)
        
        //hide menu
        hideMenu()
        isMenuOpen = false
    }
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        loader.stopAnimating()
        loader.isHidden = true
    }
    
    func loadUrl(urlString: String) {
        // Set the desired animation type
        
        loader.type = .orbit

        // Change this to the desired animation style
        loader.color = UIColor.green
        
        loader.startAnimating()
        loader.isHidden = false
        
        let pageURL = URL(string: urlString)!
        let urlRequest = URLRequest(url: pageURL)
        self.webView.load(urlRequest)
    }
}
