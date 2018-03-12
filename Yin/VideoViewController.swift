import UIKit
import AVKit
import AVFoundation

// No need for prefix, because swift is modulebased, this would Yin.YinViewController
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
        print("page index \(pageIndex)")
        print("video uri string \(videoURI.absoluteString)")
        self.player = AVPlayer(url: videoURI)
        self.player?.play()
        let playerLayer = AVPlayerLayer(player: self.player)
        playerLayer.frame = self.view.bounds

        //TODO: why use layer
        self.view.layer.addSublayer(playerLayer)

        //TODO: add parameter to selector function
        NotificationCenter.default.addObserver(self, selector: #selector(playerDidFinishPlaying), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: player?.currentItem)

    }


    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.player?.currentTime()
        self.player?.play()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.player?.pause()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @objc func playerDidFinishPlaying() {
        self.restartPlaying()
    }

    private func restartPlaying() {
        self.player?.seek(to: kCMTimeZero)
        self.player?.play()
    }

    



}
