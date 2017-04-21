//
//  Properties+CollectionView.swift
//  Reactant
//
//  Created by Filip Dolnik on 15.02.17.
//  Copyright © 2017 Brightify. All rights reserved.
//

import UIKit

extension Properties.Style {
    
    public struct CollectionView {
        
        public static let collectionView = Properties.Style.style(for: UICollectionView.self)
        public static let refreshControl = Properties.Style.style(for: UIRefreshControl.self)
        public static let emptyLabel = Properties.Style.style(for: UILabel.self)
        public static let loadingIndicator = Properties.Style.style(for: UIActivityIndicatorView.self)
        public static let reusableViewWrapper = Properties.Style.style(for: UICollectionReusableView.self)
        public static let cellWrapper = Properties.Style.style(for: UICollectionViewCell.self)
        public static let pageControl = Properties.Style.style(for: UIPageControl.self)
    }
}
