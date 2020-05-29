//
//  ViewController.swift
//  MagicalColorsGrid
//
//  Created by Mohamed Abd ElNasser on 5/27/20.
//  Copyright © 2020 MohamedAENasser. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    var screenWidth: CGFloat = 0
    var screenHeight: CGFloat = 0
    var pixelsWidth: CGFloat = 0
    var pixelsPerColumn: CGFloat = 0
    let pixelsPerRow: CGFloat = 20

    var currentCell: UICollectionViewCell?

    override func viewDidLoad() {
        super.viewDidLoad()

        screenWidth = UIScreen.main.bounds.width
        screenHeight = UIScreen.main.bounds.height
        pixelsWidth = screenWidth / pixelsPerRow
        pixelsPerColumn = (screenHeight * 2) / pixelsWidth

        let customLayout = CustomFlowLayout()
        customLayout.delegate = self
        collectionView.collectionViewLayout = customLayout

        collectionView.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(handleMove(_:))))
    }

    @objc func handleMove(_ gesture: UIGestureRecognizer) {
        let currentLocation = gesture.location(in: collectionView)
        let xPoint = Int(currentLocation.x / pixelsWidth)
        let yPoint = Int(currentLocation.y / pixelsWidth)

        let currentCellRow = xPoint + (yPoint * Int(pixelsPerRow))

        guard let cell = collectionView.cellForItem(at: IndexPath(row: currentCellRow, section: 0)) else { return }
        collectionView.bringSubviewToFront(cell)

        if cell != currentCell {
            currentCell?.minimize()
        }
        currentCell = cell
        cell.maximize()

        if gesture.state == .ended || gesture.state == .cancelled {
            cell.minimize()
        }
    }
}

extension UICollectionViewCell {
    func maximize() {
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseIn, animations: {
            self.transform3D = CATransform3DMakeScale(5, 5, 5)
        }, completion: nil)
    }

    func minimize() {
        // minimize the value of usingSpringWithDamping to increase bounce effect
        UIView.animate(withDuration: 0.8, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.5, options: .curveEaseIn, animations: {
            self.transform3D = CATransform3DIdentity
        }, completion: nil)
    }
}
