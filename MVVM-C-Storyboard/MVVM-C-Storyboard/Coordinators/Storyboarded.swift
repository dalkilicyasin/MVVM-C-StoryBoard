//
//  Storyboarded.swift
//  MVVM-C-Storyboard
//
//  Created by yasin on 11.02.2024.
//

import Foundation
import UIKit

enum StoryboardName: String {
    case main = "Main"
}

protocol Storyboarded {
    //static func instantiate(name: StoryboardName) -> Self
}

extension Storyboarded where Self: UIViewController {
    static func instantiate(name: StoryboardName) -> Self {
        let id = String(describing: self)
        let storyboard = UIStoryboard(name: name.rawValue, bundle: Bundle.main)
        
        return storyboard.instantiateViewController(withIdentifier: id) as! Self
    }
}
 
