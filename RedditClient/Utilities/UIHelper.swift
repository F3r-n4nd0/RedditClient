//
//  UIHelper.swift
//  RedditClient
//
//  Created by Fernando Luna on 10/5/20.
//

import UIKit

enum UIHelper {
    
    static func createColumnFlowLayout(with columns: Int) -> UICollectionViewFlowLayout {
        return RCColumnFlowLayout(cellsPerRow: columns,
                                  minimumInteritemSpacing: 10,
                                  minimumLineSpacing: 10,
                                  sectionInset:
                                    UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
    }
    
}
