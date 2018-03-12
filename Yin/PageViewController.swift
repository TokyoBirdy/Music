import UIKit

class PageViewController: UIPageViewController {
    
    var currentPageindex = 0
    var pageViewModel:PageViewModel?
    //TODO: maybe use macro or put it somewhere else
    required init?(coder aDecoder: NSCoder) {
        super.init(transitionStyle: .scroll, navigationOrientation: .vertical, options: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.pageViewModel = PageViewModel(currentPageIndex: currentPageindex)
        self.dataSource = self.pageViewModel
        self.delegate = self.pageViewModel
        
        self.setViewControllers([self.pageViewModel!.vcs.first!], direction: .forward, animated: false, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

