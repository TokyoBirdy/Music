import UIKit
import AVKit
import AVFoundation

// No need for prefix, because swift is modulebased, this would Yin.YinViewController
//TODO: remove ch
class VideoViewController: UIViewController {

    //objective c: has NSInteger, which is same as Int in swift, 32 or 64 bits depends on the processor.
    //objective c: int is from C, it is 32 bits
    var pageIndex : Int = 0
    open var player : AVPlayer?
    var dataSource = VideoDataSource()

    init(pageIndex:NSInteger) {
        super.init(nibName: nil, bundle: nil)
        self.pageIndex = pageIndex
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func viewDidLoad() {
        let videoURI = dataSource.videoURI(index: pageIndex)
        self.player = AVPlayer(url: videoURI)
        self.player?.play()
        let playerLayer = AVPlayerLayer(player: self.player)
        playerLayer.frame = self.view.bounds

        //TODO: why use layer
        self.view.layer.addSublayer(playerLayer)
        self.player?.play()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    



}
