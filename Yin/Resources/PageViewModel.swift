import Foundation
import UIKit
import CoreMedia

protocol PageViewModelDelegate: class {
    func viewModel(viewModel:PageViewModel, didUpdateWithVideoURIs videoURIs:[URL]?)
    func viewModel(viewModel:PageViewModel, didUpdateWithError error:Error?)
}


class PageViewModel: NSObject, PageViewDataSourceDelegate {

    var videoViews = [VideoView]()
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

    func reload() {
        self.dataSource.loadModel()
    }

    //Mark:PageViewDataSourceDelegate

    func dataSource(_ dataSource: PageViewDataSource, didDownloadVideoURIs uris: [URL]?) {

        guard  let uris = uris else {
            return
        }

//        let videoVys = uris.enumerated().map({ (index,url) -> VideoView in
//            return VideoView(videoURI: url, pageIndex:index)
//        })

        self.videoURIs = uris
       // videoViews = videoVys

        self.delegate?.viewModel(viewModel: self, didUpdateWithVideoURIs: self.videoURIs)

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
