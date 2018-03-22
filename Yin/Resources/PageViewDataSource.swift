import UIKit

protocol  PageViewDataSourceDelegate: class {

    func dataSource(_ dataSource: PageViewDataSource, didDownloadVideoURIs uris:[URL]?)
    func dataSource(_ dataSource: PageViewDataSource, didDownloadVideoWithFailure error:Error?)
    func dataSource(_ dataSource: PageViewDataSource, didUploadVideoURIsWithSuccess success:Bool)
    func dataSource(_ dataSource: PageViewDataSource, didUploadVideoURIsWithFailure error:Error?)
}

class PageViewDataSource: NSObject {

    weak var delegate:PageViewDataSourceDelegate?

    private var videoURIs = [URL]()
    private let names = ["Gudetama","Doreimon", "Richie"]

    func loadModel() {
        // In PageViewModel I wrote about `map`. You can use it here too.
        // But because path is an optional, this is a good place to use flatMap.
        // flatMap does 2 things
        //  1: If the array is nested, the returned array will not be (it will be "flattened", that's where "flat" in flatMap comes from)
        //   Example: [[1, 2, 3], [4, 5, 6]]).flatMap{$0} // returns [1, 2, 3, 4, 5, 6]
        //  2: If the array contains optionals, the returned array will not contain optionals, and any item that is nil will be excluded
        //   Example: let a: [Int?] = [1, nil, 3, nil];
        //            a.flatMap{$0} // returns [1, 3] with the type [Int] instead of [Int?]
//        let newUris = names.flatMap { name in
//            if let path = Bundle.main.path(forResource: name, ofType:"MOV") {
//                return URL(fileURLWithPath: path)
//            }
//            print("Did not find file for video named '\(name)'")
//            return nil
//        }
//        self.videoURIs = newUris
        for name in names {
            let path = Bundle.main.path(forResource: name, ofType:"MOV")
            let videoURI = URL(fileURLWithPath:path!)
            videoURIs.append(videoURI)
        }
        self.upload(uris: videoURIs, completion: {
            self.download()
        })
    }


    func upload(uris:[URL], completion:()->()) {
        for videoURI in videoURIs {
            //TODO: unowned self vs weak self
            // unowned: just a pointer, will not be nil when object is deallocated
            // weak: a tracked pointer, will become nil when object is deallocated
            // Don't use unowned in asynchronous methods
            VideoOperation.upload(videoURI: videoURI, completion: { [weak self] (success, error) in
                // a trick is to use `[weak self]` and in the block unwrap it with a `guard`
                guard let `self` = self else { return }
                
                // The backticks around `self` is needed when you want to use symbols that are otherwise reserved by the language.
                let `else` = "hello"
                let `let`: String? = `else`
                if let `if` = `let` { print(`if`) } else { print(`else`) }
                
                if (error != nil) {
                    self.delegate?.dataSource(self, didUploadVideoURIsWithFailure: error)
                } else {
                    self.delegate?.dataSource(self, didUploadVideoURIsWithSuccess: true)
                }
            })
        }
        completion()
    }

    func download() {
        // Get it from document directory
        VideoOperation.download { (uris, error) in
            if (error != nil) {
                self.delegate?.dataSource(self, didDownloadVideoWithFailure : error)
            } else {
                self.delegate?.dataSource(self, didDownloadVideoURIs : uris)
            }
        }
    }



}
