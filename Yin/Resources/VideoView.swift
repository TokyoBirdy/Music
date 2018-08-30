import UIKit
import AVKit
import AVFoundation

// No need for prefix, because swift is modulebased, this would Yin.YinViewController
 class VideoView: UIView {

    //objective c: has NSInteger, which is same as Int in swift, 32 or 64 bits depends on the processor.
    //objective c: int is from C, it is 32 bits

    var player : AVPlayer?
    var pageIndex:Int = 0

    var itemDidPlayToEndTimeObservation: NSObjectProtocol?

    var videoURI: URL? {
        didSet {
            if let uri = videoURI {
                self.createPlayer(videoURI: uri)
            }

        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
    }




    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }



//    deinit {
//        // this is how you check if you have an observation allready, and if so remove it
//        if let observation = itemDidPlayToEndTimeObservation {
//            NotificationCenter.default.removeObserver(observation)
//        }
//    }

    private func createPlayer(videoURI:URL) {
        self.player = AVPlayer(url : videoURI)
       // self.player?.play()
        let playerLayer = AVPlayerLayer(player: self.player)
        playerLayer.frame = self.bounds
        playerLayer.videoGravity = .resizeAspectFill

        //TODO: why use layer
        self.layer.addSublayer(playerLayer)
    }


    func startPlay() {
        self.player?.currentTime()
        self.player?.play()
    }

    func stopPlay() {
         self.player?.pause()
    }

    @objc func playerDidFinishPlaying() {
        self.restartPlaying()
    }

    private func restartPlaying() {
        self.player?.seek(to: kCMTimeZero)
        self.player?.play()
    }


}
