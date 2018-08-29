import UIKit

class StackedScrollView: UIScrollView {
    var stackView = UIStackView()
    var videoViews = [VideoView]()

    var currentpage = 0

    override init(frame: CGRect) {
        super.init(frame: frame)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stackView)
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .equalSpacing
        stackView.spacing = 0

        setupConstraints()
      // addFakeViews()

    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    private func setupConstraints() {
        let constraints = [
            stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            stackView.topAnchor.constraint(equalTo: self.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            stackView.widthAnchor.constraint(equalTo: self.widthAnchor),
            ]

        NSLayoutConstraint.activate(constraints)
    }

    func createSubViews(with uris: [URL]) {
        let videoVys = uris.map { (uri) -> VideoView in
            let fillBounds = CGRect(origin: .zero, size: CGSize(width: self.frame.width, height: self.frame.height))
            let videoView = VideoView(frame: fillBounds)

//            let backgroundImage = UIColor.random().image(fillBounds.size)
//            videoView.addSubview(UIImageView(image: backgroundImage))
            videoView.translatesAutoresizingMaskIntoConstraints = false
            videoView.backgroundColor = UIColor.random()
            videoView.widthAnchor.constraint(equalToConstant: fillBounds.width).isActive = true
            videoView.heightAnchor.constraint(equalToConstant: fillBounds.height).isActive = true
            stackView.addArrangedSubview(videoView)
            videoView.videoURI = uri
            return videoView
        }
        videoViews += videoVys
    }

    func playVideo(at page: Int) {
        if currentpage != page {
            currentpage = page
            videoViews[page].playVideo()
        }
    }
}
