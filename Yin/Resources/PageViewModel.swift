import Foundation
import UIKit
import CoreMedia

protocol PageViewModelDelegate: class {
    func viewModel(viewModel:PageViewModel, didUpdateWithVideoURIs videoURIs:[URL]?)
    func viewModel(viewModel:PageViewModel, didUpdateWithError error:Error?)
}


class PageViewModel: NSObject, PageViewDataSourceDelegate {

    var vcs = [VideoViewController]()
    var dataSource = PageViewDataSource()
    var videoURIs = [URL]()
    weak var delegate:PageViewModelDelegate?

    override init() {
        super.init()
        self.dataSource.delegate = self
    }

    func loadModel(){
        self.dataSource.loadModel()
    }

    //Mark:PageViewDataSourceDelegate

    func dataSource(_ dataSource: PageViewDataSource, didDownloadVideoURIs uris: [URL]?) {
        // TODO: do I have to give it another name? DO I have to do this twice?
        if let videoURIs = uris {
            self.videoURIs = videoURIs
            for idx in 0..<self.videoURIs.count {
                let uri = self.videoURIs[idx]
                let videoVC = VideoViewController(videoURI: uri, pageIndex:idx)
                vcs.append(videoVC)
            }
            self.delegate?.viewModel(viewModel: self, didUpdateWithVideoURIs: self.videoURIs)
        }

    }

    func dataSource(_ dataSource: PageViewDataSource, didDownloadVideoWithFailure error:Error?) {
        self.delegate?.viewModel(viewModel: self, didUpdateWithError: error)
    }

    func dataSource(_ dataSource: PageViewDataSource, didUploadVideoURIsWithSuccess success:Bool) {
        print("success upload result \(success)")
    }

    func dataSource(_ dataSource: PageViewDataSource, didUploadVideoURIsWithFailure error:Error?) {
        print("fail to upload  \(error.debugDescription)")
    }




}
