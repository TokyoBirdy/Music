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
            VideoOperation.upload(videoURI: videoURI, completion: { [unowned self] (success, error) in
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
