import UIKit

extension UIView {
    class func getAllSubviews<T: UIView>(view: UIView) -> [T] {
        return view.subviews.flatMap { (subview) -> [T] in
            var result = getAllSubviews(view: subview) as [T]
            if let view = subview  as? T {
                result.append(view)
            }
            return result
        }
    }

    func getAllSubviews<T: UIView>() -> [T] {
        return UIView.getAllSubviews(view: self) as [T]
    }
}
