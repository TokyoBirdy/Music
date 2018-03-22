import UIKit
import AVKit
import AVFoundation

// No need for prefix, because swift is modulebased, this would Yin.YinViewController
class VideoViewController: UIViewController {

    //objective c: has NSInteger, which is same as Int in swift, 32 or 64 bits depends on the processor.
    //objective c: int is from C, it is 32 bits
    
    // `open` is only needed when you want to be able to override the variable or function from other modules
    open var player : AVPlayer?
    var pageIndex:Int = 0
    var videoURI:URL
    init(videoURI:URL, pageIndex:Int) {
        //TODO: why in swift this is put it before super?
        // You always need to init your own variables before calling super. Otherwise if super.init() calls any instance method that you have overriden then and used one of your new instance variables, that variable would be uninitialized.
/* In this example, if it would compile, `B.value` would be undefined when `B.setup()` is called by `A.init()`.
 class A {
   init() { setup() }
   func setup() { }
 }
 
 class B: A {
   var value: Int
   override init() {
     super.init()
     value = 5
   }
   override func setup() {
     value = value * 2
   }
 }
*/
        self.videoURI = videoURI
        self.pageIndex = pageIndex
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        //TODO: Is there a better alternative for this?
        self.videoURI = URL(string:"")!
        super.init(coder: aDecoder)
    }
    
    
    // There's a new way for observations where you get a handle back for removing the observer.
    // The good thing about this is that the observation is removed if the returned handler is deallocated, which makes it a bit safer as its a chance the observation will be removed even if you forget to do it manually
    var itemDidPlayToEndTimeObservation: NSObjectProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.createPlayer(videoURI: self.videoURI)
        //TODO: add parameter to selector function
        
        
        // this is how you check if you have an observation allready, and if so remove it
        if let observation = itemDidPlayToEndTimeObservation {
            NotificationCenter.default.removeObserver(observation)
        }
        
        // and here you set it up. Note the `[weak self]` in order to break the retain cycle
        itemDidPlayToEndTimeObservation = NotificationCenter.default.addObserver(forName: .AVPlayerItemDidPlayToEndTime, object: self.player?.currentItem, queue: nil) { [weak self] _ in
            self?.playerDidFinishPlaying()
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.playerDidFinishPlaying), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: self.player?.currentItem)
    }

    private func createPlayer(videoURI:URL) {
        self.player = AVPlayer(url : videoURI)
        self.player?.play()
        let playerLayer = AVPlayerLayer(player: self.player)
        playerLayer.frame = self.view.bounds

        //TODO: why use layer
        // That's the "manual" or custom way of displaying video. The alternative is Apples `AVPlayerViewController`
        // You should update the `playerLayer.frame` in `viewDidLayoutSubviews` as autolayout/resizing masks don't apply to layers
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
