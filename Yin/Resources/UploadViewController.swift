import UIKit
import MobileCoreServices


protocol UploadViewControllerDelegate: class {

    func viewCnotroller(_:UploadViewController, didFinishUpLoadingWithSuccess success:Bool)

}

class UploadViewController: UIViewController, UploadViewModelDelegate {

    let imagePickerController = UIImagePickerController()
    let uploadViewModel = UploadViewModel()
    weak var delegate : UploadViewControllerDelegate?

    var uploadButton: UIButton!

    init() {

        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func viewDidLoad() {
        uploadButton = UIButton(type: .custom)
        super.viewDidLoad()
        uploadButton.setTitle("upload", for: .normal)
        uploadButton.backgroundColor = UIColor.random()
        
        uploadButton.addTarget(self, action: #selector(openCamera), for: .touchUpInside)
        uploadButton.translatesAutoresizingMaskIntoConstraints = false
        uploadViewModel.delegate = self
        view.addSubview(uploadButton)

        setupConstraints()
        view.backgroundColor = UIColor.random()


        // Do any additional setup after loading the view.
    }

    func setupConstraints() {
        let constraints = [
            uploadButton.widthAnchor.constraint(equalToConstant: 100),
            uploadButton.heightAnchor.constraint(equalToConstant: 44),
            uploadButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            uploadButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ]

        NSLayoutConstraint.activate(constraints)
    }

     @objc private func openCamera() {
        imagePickerController.sourceType = .photoLibrary
        imagePickerController.delegate = uploadViewModel as (UIImagePickerControllerDelegate & UINavigationControllerDelegate)
        imagePickerController.mediaTypes = [(kUTTypeMovie as String)]
        self.present(imagePickerController, animated: true, completion: nil)
    }


    //Mark:UploadViewModelDelegate

    func viewModel(_ viewModel: UploadViewModel, didUploadVideoWithSuccess success:Bool) {
        if (!success) {
            let alert = AlertControllerHelper.alert(title: "Failure", message: "Could not save locally")
            self.present(alert, animated: true, completion: nil)
        }
        imagePickerController.dismiss(animated: true, completion: nil)
        //Also redirect to home
       self.delegate?.viewCnotroller(self, didFinishUpLoadingWithSuccess: true)
    }

    func viewModel(_ viewModel: UploadViewModel, didUploadVideoWithFailure error:Error?) {
        let alert = AlertControllerHelper.alert(title: "Failure", message: "Error: \(String(describing: error?.localizedDescription))")
        self.present(alert, animated: true, completion: nil)
        imagePickerController.dismiss(animated: true, completion: nil)
        self.delegate?.viewCnotroller(self, didFinishUpLoadingWithSuccess: false)
    }


}
