import UIKit

class ScrollPageViewController: UIViewController {
    var scrollpageView: StackedScrollView!
   // var scrollPageViewBinder = ScrollpageViewBinder()
    let pageViewModel = PageViewModel()

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)

    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        scrollpageView = StackedScrollView(frame: view.frame)
        scrollpageView.isPagingEnabled = true
        scrollpageView.delegate = self
        scrollpageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollpageView)
       // view.getAllSubviews().forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
        pageViewModel.delegate = self
        pageViewModel.loadModel()

        setUpConstraints()
    }

    private func setUpConstraints() {
        let constraints = [
            scrollpageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollpageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollpageView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollpageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollpageView.widthAnchor.constraint(equalTo: view.widthAnchor),
        ]

        NSLayoutConstraint.activate(constraints)
    }

}

extension ScrollPageViewController: PageViewModelDelegate {

    func viewModel(viewModel:PageViewModel, didUpdateWithVideoURIs videoURIs:[URL]?) {

        if let uris = videoURIs {
            scrollpageView.createSubViews(with: uris)
        }

       // scrollpageView.updateContentView()
    }

    func viewModel(viewModel:PageViewModel, didUpdateWithError error:Error?) {
        let alert = AlertControllerHelper.alert(title: "Failure", message: "Could not download videos from Document directory")
        self.present(alert, animated: true, completion: nil)

    }
}

extension ScrollPageViewController: UIScrollViewDelegate {

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageNumber = Int(scrollView.contentOffset.y / scrollView.frame.height)
        print("page number", pageNumber)
        //TODO: how to do it gracefully
        if scrollView == scrollpageView {
            scrollpageView.playVideo(at: pageNumber)
        }

    }
}

