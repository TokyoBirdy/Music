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
    private var initialUploadCompleted = false
    private let names = ["Gudetama","Doreimon", "Richie"]

    func loadModel() {
        if (initialUploadCompleted) {
            self.download()
        } else {
            initialDownload()
        }
    }




    func initialDownload() {
        videoURIs = names.compactMap({ (name) -> URL? in
            if let path = Bundle.main.path(forResource: name, ofType:"MOV") {
                return URL(fileURLWithPath:path)
            }

            print("something went wrong")
            return nil

        })

        self.upload(uris: videoURIs, completion: {
            initialUploadCompleted = true;
            self.download()
        })
    }

    func upload(uris:[URL], completion:()->()) {
        for videoURI in videoURIs {
            /// unowned: just a pointer, will not be nil when object is deallocated
            // weak: a tracked pointer, will become nil when object is deallocated
            // Don't use unowned in asynchronous methods
            VideoOperation.upload(videoURI: videoURI, completion: { [weak self] (success, error) in
                // a strong pointer to a weak self (which can be optional)
                guard let `self` = self else { return }
                if (error != nil) {
                    `self`.delegate?.dataSource(self, didUploadVideoURIsWithFailure: error)
                } else {
                    self.delegate?.dataSource(self, didUploadVideoURIsWithSuccess: true)
                }

                let `else` = "hello"
                let `let`: String? = `else`
                if let `if` = `let` { print(`if`) } else { print(`else`) }
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
