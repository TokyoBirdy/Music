import UIKit

extension String {
    func image() -> UIImage? {

        let size = CGSize(width:40, height:40)
        let rct = CGRect(origin: CGPoint.zero, size: size)
        let renderer = UIGraphicsImageRenderer(size:size)
        let img = renderer.image { renderContext in
            (self as AnyObject).draw(in: rct)
        }
        return img
    }
}
