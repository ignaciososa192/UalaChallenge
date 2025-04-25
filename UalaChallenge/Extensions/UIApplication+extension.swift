//
//  UIApplication+extension.swift
//  UalaChallenge
//
//  Created by Ignacio Sosa on 25/04/2025.
//

import UIKit

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
