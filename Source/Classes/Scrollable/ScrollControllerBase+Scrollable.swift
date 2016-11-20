//
//  ScrollControllerBase+Scrollable.swift
//  Reactant
//
//  Created by Filip Dolnik on 16.11.16.
//  Copyright © 2016 Brightify. All rights reserved.
//

extension ScrollControllerBase: Scrollable {
    
    public func scrollToTop(animated: Bool) {
        scrollView.scrollToTop(animated: animated)
    }
}
