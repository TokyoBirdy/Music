import Foundation
import UIKit
import CoreMedia
class PageViewModel: NSObject, UIPageViewControllerDataSource, UIPageViewControllerDelegate {

    var currentPageIndx: Int
    var totalPageIndex: Int = 10
    open var vcs = [UIViewController]()

    init(currentPageIndex:NSInteger) {
        currentPageIndx = currentPageIndex
        for index in 0..<totalPageIndex {
            let viewController = VideoViewController(pageIndex: index)
            vcs.append(viewController)
        }
    }


    //Mark:UIPageViewControllerDataSource
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        var currentIdx = (viewController as! VideoViewController).pageIndex
        if (currentIdx <= 0) {
            return nil
        }

        currentIdx -= 1
        return vcs[currentIdx]
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        var currentIdx = (viewController as! VideoViewController).pageIndex

        if (currentIdx >= totalPageIndex - 1) {
            return nil
        }

         currentIdx += 1
         return vcs[currentIdx]
    }

    //Mark:UIPageViewControllerDelegate
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {

        guard completed else {
            return
        }
        // currentViewController


    }


}
