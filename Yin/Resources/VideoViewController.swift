import UIKit
import AVKit
import AVFoundation

// No need for prefix, because swift is modulebased, this would Yin.YinViewController
class VideoViewController: UIViewController {

    //objective c: has NSInteger, which is same as Int in swift, 32 or 64 bits depends on the processor.
    //objective c: int is from C, it is 32 bits
    open var player : AVPlayer?
    var pageIndex:Int = 0
    var videoURI:URL
    init(videoURI:URL, pageIndex:Int) {
        //TODO: why in swift this is put it before super?
        self.videoURI = videoURI
        self.pageIndex = pageIndex
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        //TODO: Is there a better alternative for this?
        self.videoURI = URL(string:"")!
        super.init(coder: aDecoder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.createPlayer(videoURI: self.videoURI)
        //TODO: add parameter to selector function
        NotificationCenter.default.addObserver(self, selector: #selector(self.playerDidFinishPlaying), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: self.player?.currentItem)
    }

    private func createPlayer(videoURI:URL) {
        self.player = AVPlayer(url : videoURI)
        self.player?.play()
        let playerLayer = AVPlayerLayer(player: self.player)
        playerLayer.frame = self.view.bounds

        //TODO: why use layer
        self.view.layer.addSublayer(playerLayer)
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
