//
//  ViewController.swift
//  MagicalColorsGrid
//
//  Created by Mohamed Abd ElNasser on 5/27/20.
//  Copyright © 2020 MohamedAENasser. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    var screenWidth: CGFloat = 0
    var screenHeight: CGFloat = 0
    var pixelsWidth: CGFloat = 0
    let pixelsPerRow: CGFloat = 30

    override func viewDidLoad() {
        super.viewDidLoad()

        screenWidth = UIScreen.main.bounds.width
        screenHeight = UIScreen.main.bounds.height
        pixelsWidth = screenWidth / pixelsPerRow

        let customLayout = CustomFlowLayout()
        customLayout.delegate = self
        collectionView.collectionViewLayout = customLayout
    }
}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let pixelsPerColumn: CGFloat = screenHeight + 1 / pixelsWidth
        return Int(pixelsPerRow * pixelsPerColumn)
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        let redRandom =  CGFloat(drand48())
        let greenRandom = CGFloat(drand48())
        let blueRandom = CGFloat(drand48())
        cell.backgroundColor = UIColor(red: redRandom, green: greenRandom, blue: blueRandom, alpha: 1)
        cell.layer.borderWidth = 1
        cell.layer.borderColor = UIColor.black.cgColor

        return cell
    }
}

extension ViewController: CustomFlowLayoutDelegate {
    func collectionView(_ collectionView: UICollectionView, getSizeAtIndexPath: IndexPath) -> CGSize {
        let width = screenWidth/pixelsPerRow
        return CGSize(width: width, height: width)
    }
}
