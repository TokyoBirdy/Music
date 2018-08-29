import UIKit

class ScrollpageViewBinder: NSObject {
    private var pageNumber: Int = 0
    
}

extension ScrollpageViewBinder: UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        pageNumber = Int(scrollView.contentOffset.y / scrollView.frame.height)
    }
}

