import Foundation

extension String {
    func stringByAppendingPathComponent(path:String) -> String {
        let nsSt = self as NSString
        return nsSt.appendingPathComponent(path)
    }
}
