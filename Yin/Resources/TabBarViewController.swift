import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let homeViewController = PageViewController()
        homeViewController.tabBarItem = UITabBarItem(title: "Home", image: nil, tag: 0)

        let uploadViewController = UploadViewController()
        uploadViewController.tabBarItem = UITabBarItem(title: "Upload", image: nil, tag: 1)

        let tabControllers = [homeViewController, uploadViewController]
        self.setViewControllers(tabControllers, animated: false)

    }



}
