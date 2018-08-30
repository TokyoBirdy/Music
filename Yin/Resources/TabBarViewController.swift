import UIKit

class TabBarViewController: UITabBarController, UploadViewControllerDelegate {

    var homeViewController = ScrollPageViewController()
    var uploadViewController = UploadViewController()

    override func viewDidLoad() {
        super.viewDidLoad()
//        homeViewController = ScrollPageViewController()
//        uploadViewController = UploadViewController()
        homeViewController.tabBarItem = UITabBarItem(title: "Home", image: nil, tag: 0)

        uploadViewController.tabBarItem = UITabBarItem(title: "Upload", image: nil, tag: 1)
        uploadViewController.delegate = self

        let tabControllers: [UIViewController] = [homeViewController, uploadViewController]
        self.setViewControllers(tabControllers, animated: false)
    }

    func viewCnotroller(_:UploadViewController, didFinishUpLoadingWithSuccess success:Bool) {
        //navigate to home
       // self.selectedIndex = 0
        if (success) {
            homeViewController.refresh()
        }
    }



}
