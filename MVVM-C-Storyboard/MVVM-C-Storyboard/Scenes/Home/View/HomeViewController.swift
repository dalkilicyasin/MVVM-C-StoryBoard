//
//  ViewController.swift
//  MVVM-C-Storyboard
//
//  Created by yasin on 11.02.2024.
//

import UIKit

class HomeViewController: UIViewController, Storyboarded {
    @IBOutlet weak var buttonUserList: UIButton!
    @IBOutlet weak var buttonDeveloper: UIButton!
    
    var coordinator: AppCoordinator?
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.navigationItem.title = "Home"
        self.buttonUserList.layer.cornerRadius = 10
        self.buttonDeveloper.layer.cornerRadius = 10
    }

    @IBAction func toSecondVC(_ sender: Any) {
        coordinator?.navigateTo(to: .second, data: nil)
        
    }
    
    @IBAction func toThirdVC(_ sender: Any) {
        coordinator?.navigateTo(to: .third, data: nil)
    }
}

