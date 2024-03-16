//
//  AdminPanelViewController.swift
//  MVVM-C-Storyboard
//
//  Created by yasin on 16.03.2024.
//

import UIKit

class AdminPanelViewController: UIViewController, Storyboarded {
    @IBOutlet weak var adminImage: UIImageView!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    
    let viewModel: AdminPanelViewModel
    
    init(viewModel: AdminPanelViewModel){
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.viewModel = AdminPanelViewModel()
       super.init(coder: aDecoder)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel.callAdminIfo()
        self.viewModel.adminPanelViewModelDelegate = self
        self.navigationItem.title = "Admin Screen"
    }
}

extension AdminPanelViewController: AdminPanelViewModelDelegate {
    func observedData() {
            do {
                let data = try Data.init(contentsOf: URL.init(string:"\(self.viewModel.adminInfo?.avatar_url ?? "")")!)
                  DispatchQueue.main.async {
                      let image: UIImage = UIImage(data: data)!
                      self.adminImage.image = image
                      self.nameLabel.text = self.viewModel.adminInfo?.login
                      self.typeLabel.text = self.viewModel.adminInfo?.bio
                  }
            } catch {
                print("error")
            }
    }
}
