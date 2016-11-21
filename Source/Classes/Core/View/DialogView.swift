//
//  DialogView.swift
//  Reactant
//
//  Created by Filip Dolnik on 09.11.16.
//  Copyright © 2016 Brightify. All rights reserved.
//

import UIKit

internal final class DialogView: ViewBase<Void> {
    
    private let contentContainer = ContainerView()
    private let content: UIView
    
    init(content: UIView) {
        self.content = content
        
        super.init()
        
        ReactantConfiguration.global.dialogStyle(self)
        ReactantConfiguration.global.dialogContentContainerStyle(contentContainer)
    }
    
    override func loadView() {
        children(
            contentContainer.children(
                content
            )
        )
    }
    
    override func setupConstraints() {
        contentContainer.snp.makeConstraints { make in
            make.leading.greaterThanOrEqualTo(snp.leadingMargin)
            make.top.greaterThanOrEqualTo(snp.topMargin)
            make.trailing.greaterThanOrEqualTo(snp.trailingMargin)
            make.bottom.lessThanOrEqualTo(snp.bottomMargin)
            make.center.equalTo(self)
        }
        
        content.snp.makeConstraints { make in
            make.edges.equalTo(contentContainer)
        }
    }
}
