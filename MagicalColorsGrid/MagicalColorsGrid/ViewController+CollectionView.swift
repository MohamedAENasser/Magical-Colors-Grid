//
//  ViewController+CollectionView.swift
//  MagicalColorsGrid
//
//  Created by Mohamed Abd ElNasser on 5/29/20.
//  Copyright © 2020 MohamedAENasser. All rights reserved.
//

import UIKit

// MARK: DataSource
extension MainViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
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

// MARK: Delegate
extension MainViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) else { return }
        collectionView.bringSubviewToFront(cell)
        cell.maximize()
    }

    func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) else { return }
        cell.minimize()
    }
}

// MARK: CustomFlowLayoutDelegate
extension MainViewController: CustomFlowLayoutDelegate {
    func collectionView(_ collectionView: UICollectionView, getSizeAtIndexPath: IndexPath) -> CGSize {
        let width = screenWidth/pixelsPerRow
        return CGSize(width: width, height: width)
    }
}
