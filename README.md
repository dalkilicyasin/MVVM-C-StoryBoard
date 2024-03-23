# MVVM-C Storyboard 

* Created simple project for developer if they want to use MCCM-C with Storyboard Coordinator Desing Pattern. And aslo combined with Alamofire Library for data parsing.
* Wanted to show how to use Storyboard in MVVM-C Coordinator Desing Pattern and Alamofire Library HTTP request.
* Also you can use URLSession for HTTP request. This has been shown in this project. This optional and you can use easly.
* Dependency Injection.
* Used GitHub REST API for users. 

## Overview

MVVM-C (Model-View-ViewModel-Coordinator) is a design pattern widely used in iOS/macOS development to achieve separation of concerns, modularity, and maintainability. Alamofire is a powerful Swift-based HTTP networking library for handling networking tasks in iOS/macOS applications. Integrating MVVM-C with Alamofire and Storyboard-based navigation allows for a structured and efficient development process.

## Components

## Model
The Model represents the data and business logic of the application. It encapsulates data structures and methods related to the application's domain.

## View
The View displays the user interface and handles user interactions. It observes the ViewModel and updates its appearance based on the data provided.

## ViewModel
The ViewModel retrieves data from the Model and prepares it for presentation in the View. It contains business logic related to the presentation layer and interacts with the Model to fetch and transform data.

## Coordinator
The Coordinator manages the navigation flow within the application. It abstracts away the details of navigation and handles transitions between different screens. In a Storyboard-based architecture, Coordinators instantiate and present view controllers defined in the storyboard.

## Alamofire
Alamofire simplifies networking tasks by providing a clear and concise API for making HTTP requests, handling responses, and managing authentication.

## Advantages
* Separation of Concerns: MVVM-C promotes a clear separation between the data, presentation logic, and navigation logic, making code easier to understand and maintain.
* Testability: Each component in MVVM-C can be easily unit tested in isolation, leading to more robust and reliable code.
* Scalability: MVVM-C scales well with the size and complexity of the application. It allows for easy addition of new features and modification of existing ones without introducing tight coupling.
* Reusability: Components such as ViewModels and Coordinators can be reused across different parts of the application, reducing duplication of code and promoting consistency.

## Demo

![Uploading GifGithub.gif…]()


## Implementation

## Example Code
  In Coordinator file i created basic Coordinator protocol. Then implemented all Coordinator files.
  
```swift
// Coordinator
public protocol BaseRoute{
}
public protocol Coordinator: AnyObject {
    associatedtype Route: BaseRoute
    var childCoordinators: [any Coordinator] {get set}
    func start()
    func navigateTo(to route: Route, data: AnyObject?)
}

public extension Coordinator {
    func finish(){}
    
    func addChildCoordinator(_ coordinator:  any Coordinator) {
        self.childCoordinators.append(coordinator)
    }
    
    func removeChildCoordinator(_ coordinator:  any Coordinator) {
        guard let index = childCoordinators.firstIndex(
            where: { $0 === coordinator }) else {
            print("Child coordinator not found")
            return
        }
    }
    func removeAllChildCoordinators(){}
}
```

AppCoordinator is main Coordinator this project. In this point user rotate UserList or AdminPanel Pages. In below how to implemented Coordinator Protocol and handle Memory leaks for using other methots. It is too important to remove all childCoordinator when swicth another Coordinator file.
```swift
//AppCoordinator

import Foundation
import UIKit

public enum HomeRoute: BaseRoute {
    case second
    case third
}

class AppCoordinator: Coordinator {
    lazy var networkService: NetworkManager = {
        return NetworkService()
    }()
    
    var childCoordinators: [ any Coordinator] = []
    
    var navigationController: UINavigationController
   
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {        
        let controller = HomeViewController.instantiate(name: .main)
        controller.coordinator = self
        navigationController.setViewControllers([controller], animated: false)
    }
    
    func navigateTo(to route: HomeRoute, data: AnyObject?) {
        switch route {
        case .second:
            //let viewController = UserListViewController.instantiate(name: .main)
            //navigationController.show(viewController, sender: nil)
            let userList = UserListCoordinator(navigationController: self.navigationController, networkManager: networkService)
            userList.userListDelegate = self
            addChildCoordinator(userList)
            userList.start()
            
        case .third:
            let adminInfo = AdminPanelCoordinator(navigationController: self.navigationController)
            adminInfo.adminPanelCoordinatorDelegate = self
            addChildCoordinator(adminInfo)
            adminInfo.start()
        }
    }
}

extension AppCoordinator: UserListCoordinatorDelegate {
    func didFinish(from coordinator: UserListCoordinator) {
       removeChildCoordinator(coordinator)
    }
}

extension AppCoordinator: AdminPanelCoordinatorDelegate {
    func didFinish(from coordinator: AdminPanelCoordinator) {
       removeChildCoordinator(coordinator)
    }
}
```
It is important to add Storyboarded file and implement to UIViewController. It is shown below code how to implemented. Storyboarded Protocol file abstract and simplify define UIViewController in Storyboard and ViewConroller class. 
You can use more then one Storyboard file like "Main". 
Note: Remember you need to give Storyboard ID to your ViewControoler in Main Storyboard.

```swift
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

//ViewController

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

```
