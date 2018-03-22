import UIKit

class PageViewController: UIPageViewController, UIPageViewControllerDataSource,PageViewModelDelegate {

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
        self.pageViewModel.delegate = self
        self.pageViewModel.loadModel()
        self.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }



    //Mark:UIPageViewControllerDataSource
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        /// here you could do an `as?` and `if let` in case the ViewController is not what was expected, but it's good to crash sometimes as well
        var currentIdx = (viewController as! VideoViewController).pageIndex
        
        /// this is true when `currentIdx` is equal to `0`.
        if (currentIdx <= 0) {
            return nil
        }
        /// if `currentIdx` was `0`
        currentIdx -= 1
        /// it will crash here
        return self.pageViewModel.vcs[currentIdx]
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        var currentIdx = (viewController as! VideoViewController).pageIndex
        if (currentIdx >= self.pageViewModel.videoURIs.count - 1) {
            return nil
        }

        currentIdx += 1
        return self.pageViewModel.vcs[currentIdx]
    }


    func viewModel(viewModel:PageViewModel, didUpdateWithVideoURIs videoURIs:[URL]?) {
        //TODO: there maybe is a better way
        // you could check that there is a first item in the `vcs` like this
        //if let firstVc = self.pageViewModel.vcs.first {
        if let uris = videoURIs, uris.count > 0 {
            // and use firstVc instead
//            self.setViewControllers([firstVc], direction: .forward, animated: false, completion: nil)
            self.setViewControllers([self.pageViewModel.vcs.first!], direction: .forward, animated: false, completion: nil)
        }
        
        // I just looked up what to call this "if let" thing. "Optional binding" apparently
        //        https://developer.apple.com/library/content/documentation/Swift/Conceptual/Swift_Programming_Language/TheBasics.html#//apple_ref/doc/uid/TP40014097-CH5-ID333

    }
    
    func viewModel(viewModel:PageViewModel, didUpdateWithError error:Error?) {
        let alert = AlertControllerHelper.alert(title: "Failure", message: "Could not download videos from Document directory")
        self.present(alert, animated: true, completion: nil)

    }

}

