//
//  RotatingLayout.swift
//  Icicle
//
//  Created by Kevin McGladdery on 1/14/17.
//  Copyright © 2017 Kevin McGladdery. All rights reserved.
//

import UIKit

class RotatingLayout: UICollectionViewFlowLayout {
    var animator:UIDynamicAnimator!
    
    override init() {
        super.init()
        self.scrollDirection = .horizontal
        self.minimumInteritemSpacing = 8
        self.animator = UIDynamicAnimator(collectionViewLayout: self)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func addSpringyness() {
        guard let view = collectionView else { return }
        let size = CGRect(x: view.bounds.origin.x,
                          y: view.bounds.origin.y,
                          width: 20000,
                          height: 300)
        let items = super.layoutAttributesForElements(in: size)
        print(items?.count)
        items?.forEach { item in
            if item.representedElementCategory == .cell {
                let attachment = UIAttachmentBehavior(item: item, attachedToAnchor: item.center)
                attachment.length = 0.1
                attachment.damping = 0.6
                attachment.frequency = 1.0
                print("adding attachment")
                animator.addBehavior(attachment)
            }
        }
    }
    
    override func prepare() {
        super.prepare()
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return animator.items(in: rect) as? [UICollectionViewLayoutAttributes]
    }

    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return animator.layoutAttributesForCell(at: indexPath)
    }
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        guard let view = self.collectionView else { return false }
        let delta = newBounds.origin.x - view.bounds.origin.x
        let touch = Float(view.panGestureRecognizer.location(in: view).x)
        self.animator.behaviors.forEach { behavior in
            if let attachment = behavior as? UIAttachmentBehavior {
                let point = Float(attachment.anchorPoint.x)
                let distance = fabsf(touch - point)
                let resist = distance / 500
                let item = attachment.items.first!
                var center = item.center
                center.x += delta * CGFloat(resist)
                item.center = center
                self.animator.updateItem(usingCurrentState: item)
            }
        }
        return false
    }
}
