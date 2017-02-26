//
//  FutureControllerProvider.swift
//  Reactant
//
//  Created by Filip Dolnik on 09.11.16.
//  Copyright © 2016 Brightify. All rights reserved.
//

import UIKit

public final class FutureControllerProvider<T: UIViewController> {
    
    public internal(set) weak var controller: T?
    
    public var navigation: UINavigationController? {
        return controller?.navigationController
    }
}
