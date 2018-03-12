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
        currentPageIndx -= 1
        if (currentPageIndx < 0) {
            return nil
        }
        return vcs[currentPageIndx]
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        currentPageIndx += 1
        if (currentPageIndx >= totalPageIndex) {
            return nil
        }
         return vcs[currentPageIndx]
    }

    //Mark:UIPageViewControllerDelegate
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {

        guard completed else {
            return
        }
        // currentViewController

        let currentVC = pageViewController.viewControllers?.first as! VideoViewController
        if (currentVC.player?.status == .readyToPlay) {
            currentVC.player? .seek(to: kCMTimeZero)
            currentVC.player?.play()
            
        }

    }


}
