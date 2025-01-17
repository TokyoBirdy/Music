import UIKit

class PageViewController: UIPageViewController {

    var pageViewModel = PageViewModel()
    //TODO: maybe use macro or put it somewhere else
    init() {
        super.init(transitionStyle: .scroll, navigationOrientation: .vertical, options: nil)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        //self.pageViewModel.delegate = self
        self.pageViewModel.loadModel()
      //  self.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func refresh() {
        self.pageViewModel.reload()
//        self.dataSource = nil
//        self.dataSource = self
    }



    //Mark:UIPageViewControllerDataSource
//    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
//        guard let viewController = viewController as? UIViewController  else {
//            return nil
//        }
//        var currentIdx = viewController.pageIndex
//
//        currentIdx -= 1
//
//        if (currentIdx < 0) {
//            return nil
//        }
//
//
//        return self.pageViewModel.vcs[currentIdx]
//    }
//
//    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
//        var currentIdx = (viewController as! VideoViewController).pageIndex
//        if (currentIdx >= self.pageViewModel.videoURIs.count - 1) {
//            return nil
//        }
//
//        currentIdx += 1
//        return self.pageViewModel.vcs[currentIdx]
//    }
//
//
//    func viewModel(viewModel:PageViewModel, didUpdateWithVideoURIs videoURIs:[URL]?) {
//        if let firstVC = self.pageViewModel.vcs.first {
//            self.setViewControllers([firstVC], direction: .forward, animated: false, completion: nil)
//        }
//    }
//
//    func viewModel(viewModel:PageViewModel, didUpdateWithError error:Error?) {
//        let alert = AlertControllerHelper.alert(title: "Failure", message: "Could not download videos from Document directory")
//        self.present(alert, animated: true, completion: nil)
//
//    }

}

