//
//  CustomFlowLayout.swift
//  MagicalColorsGrid
//
//  Created by Mohamed Abd ElNasser on 5/27/20.
//  Copyright © 2020 MohamedAENasser. All rights reserved.
//

import UIKit

protocol CustomFlowLayoutDelegate: class {
    func collectionView(_ collectionView: UICollectionView, getSizeAtIndexPath: IndexPath) -> CGSize
}

class CustomFlowLayout: UICollectionViewLayout {

    weak var delegate: CustomFlowLayoutDelegate?

    private var cache: [UICollectionViewLayoutAttributes] = []

    private var contentWidth: CGFloat {
        guard let collectionView = collectionView else { return 0 }
        return collectionView.bounds.width - collectionView.contentInset.left + collectionView.contentInset.right
    }

    private var contentHeight: CGFloat = 0

    override var collectionViewContentSize: CGSize {
        CGSize(width: contentWidth, height: contentHeight)
    }

    // MARK: Prepare
    override func prepare() {
        super.prepare()
        guard let collectionView = collectionView else { return }

        cache.removeAll()

        var xOrigin: CGFloat = 0
        var yOrigin: CGFloat = 0

        let defaultSize: CGFloat = collectionView.bounds.width/20
        let sectionIndex = 0

        for itemIndex in 0..<collectionView.numberOfItems(inSection: sectionIndex) {
            let indexPath = IndexPath(row: itemIndex, section: sectionIndex)
            let itemSize = delegate?.collectionView(collectionView, getSizeAtIndexPath: indexPath) ??
                CGSize(width: defaultSize, height: defaultSize)

            if xOrigin + itemSize.width > contentWidth {
                xOrigin = 0
                yOrigin += itemSize.height
            }

            let frame = CGRect(x: xOrigin,
                               y: yOrigin,
                               width: itemSize.width,
                               height: itemSize.height)
            xOrigin += itemSize.width

            let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            attributes.frame = frame

            if indexPath.row % 2 != 0 {
                attributes.alpha = 0.5
                attributes.frame.size.height = 25
                attributes.frame.size.width = 25
            }
            cache.append(attributes)
            contentHeight = max(contentHeight, yOrigin + itemSize.height)
        }
    }

    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        cache
    }
}
