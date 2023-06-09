//
//  TetrrisViewController.swift
//  ShoesShop
//
//  Created by Kosovar Latifi on 30/05/2023.
//
//import UIKit
//
//class TetrisViewController: UIViewController {
//
//
//    let numColumns = 10
//    let numRows = 20
//    let blockSize: CGFloat = 30.0
//
//    @IBOutlet weak var tetrisView: TetrisView!
//    var timer: Timer?
//
//    var currentShape: Shape?
//    var currentShapeView: UIView?
//    var grid: [[UIColor?]] = Array(repeating: Array(repeating: nil, count: 10), count: 20)
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        tetrisView.frame = CGRect(x: 0, y: 0, width: blockSize * CGFloat(numColumns), height: blockSize * CGFloat(numRows))
//        tetrisView.center = view.center
//
//        startNewGame()
//    }
//
//    func startNewGame() {
//        timer?.invalidate()
//        grid = Array(repeating: Array(repeating: nil, count: numColumns), count: numRows)
//        tetrisView.clear()
//        spawnShape()
//        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(update), userInfo: nil, repeats: true)
//    }
//
//    @objc func update() {
//        moveDown()
//    }
//
//    func spawnShape() {
//        let shape = Shape.randomShape()
//        currentShape = shape
//
//        guard let currentShape = currentShape else { return }
//
//        let startX = (numColumns - currentShape.width) / 2
//        let startY = numRows - currentShape.height
//
//        currentShapeView = UIView(frame: CGRect(x: CGFloat(startX) * blockSize, y: CGFloat(startY) * blockSize, width: CGFloat(currentShape.width) * blockSize, height: CGFloat(currentShape.height) * blockSize))
//        currentShapeView?.backgroundColor = currentShape.color
//        tetrisView.addSubview(currentShapeView!)
//
//        drawShape(shape: currentShape, xOffset: startX, yOffset: startY)
//    }
//
//    func moveDown() {
//        guard let currentShape = currentShape, let currentShapeView = currentShapeView else { return }
//
//        let newX = currentShapeView.frame.origin.x
//        let newY = currentShapeView.frame.origin.y + blockSize
//
//        if isValidPosition(xOffset: Int(newX / blockSize), yOffset: Int(newY / blockSize), shape: currentShape) {
//            currentShapeView.frame.origin.y = newY
//        } else {
//            freezeShape()
//            clearLines()
//            spawnShape()
//        }
//    }
//
//    func moveLeft() {
//        guard let currentShape = currentShape, let currentShapeView = currentShapeView else { return }
//
//        let newX = currentShapeView.frame.origin.x - blockSize
//        let newY = currentShapeView.frame.origin.y
//
//        if isValidPosition(xOffset: Int(newX / blockSize), yOffset: Int(newY / blockSize), shape: currentShape) {
//            currentShapeView.frame.origin.x = newX
//        }
//    }
//
//    func moveRight() {
//        guard let currentShape = currentShape, let currentShapeView = currentShapeView else { return }
//
//        let newX = currentShapeView.frame.origin.x + blockSize
//        let newY = currentShapeView.frame.origin.y
//
//        if isValidPosition(xOffset: Int(newX / blockSize), yOffset: Int(newY / blockSize), shape: currentShape) {
//            currentShapeView.frame.origin.x = newX
//        }
//    }
//
//    func rotate() {
//        guard let currentShape = currentShape, let currentShapeView = currentShape
//    }
//}
