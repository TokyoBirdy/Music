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
            // Here's a good place to practive the `.map` function
            // To get the index of each item we can use the `.enumerate()` function first
            //  which returns the type EnumeratedSequence, which just adds index to each item
            //  in a Sequence
            // `Sequence` is a protocol used by types that stores a list of items, for example Array, Dictionary, Set, etc. It adds different ways to iterate over the items. For example `map` and `filter`
            // So what we do is we convert the array of URI's to an EnumeratedSequence and then use `map` to transform the sequence of (index, item) tuples to something else
//            let newVcs = videoURIs.enumerated().map { idx, uri in
//                return VideoViewController(videoURI: uri, pageIndex:idx)
//            }
//            self.vcs.append(contentsOf: newVcs)
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
