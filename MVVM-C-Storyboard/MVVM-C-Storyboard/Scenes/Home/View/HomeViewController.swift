//
//  ViewController.swift
//  MVVM-C-Storyboard
//
//  Created by yasin on 11.02.2024.
//

import UIKit

class HomeViewController: UIViewController, Storyboarded {
        
    var coordinator: AppCoordinator?
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.navigationItem.title = "Home"
    }

    @IBAction func toSecondVC(_ sender: Any) {
        coordinator?.navigateTo(to: .second)
        
    }
    
    @IBAction func toThirdVC(_ sender: Any) {
        coordinator?.navigateTo(to: .third)
    }
}

