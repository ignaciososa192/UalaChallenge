//
//  Debouncer.swift
//  UalaChallenge
//
//  Created by Ignacio Sosa on 24/04/2025.
//

import Foundation

class Debouncer {
    private let delay: TimeInterval
    private var workItem: DispatchWorkItem?
    
    init(delay: TimeInterval) { self.delay = delay }
    
    func schedule(_ action: @escaping ()->Void) {
        workItem?.cancel()
        let item = DispatchWorkItem(block: action)
        workItem = item
        DispatchQueue.main.asyncAfter(deadline: .now()+delay, execute: item)
    }
}
