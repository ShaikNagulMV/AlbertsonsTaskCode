//
//  DynamicBinding.swift
//  Meaning
//
//  Created by 1212199 on 25/11/21.
//

import Foundation
import UIKit

final class Dynamic<T> {
    
    typealias Listener = (T) -> Void
    var listener: Listener?
    
    var value:T {
        didSet {
            listener?(value)
        }
    }
    
    init(_ value: T) {
        self.value = value
    }

    func bind(listener: Listener?) {
        self.listener = listener
        listener?(value)
    }
}
