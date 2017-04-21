//
//  Array+Utils.swift
//  Reactant
//
//  Created by Filip Dolnik on 20.11.16.
//  Copyright © 2016 Brightify. All rights reserved.
//

extension Array {
    
    public func arrayByAppending(_ elements: Element...) -> Array<Element> {
        return arrayByAppending(elements)
    }
    
    public func arrayByAppending(_ elements: [Element]) -> Array<Element> {
        var mutableCopy = self
        mutableCopy.append(contentsOf: elements)
        return mutableCopy
    }
}
