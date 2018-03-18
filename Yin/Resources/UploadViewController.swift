import UIKit
import MobileCoreServices


class UploadViewController: UIViewController, UploadViewModelDelegate {

    let imagePickerController = UIImagePickerController()
    let uploadViewModel = UploadViewModel()


    init() {
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        uploadViewModel.delegate = self


        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
         openCamera()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func openCamera() {
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

    }
    func viewModel(_ viewModel: UploadViewModel, didUploadVideoWithFailure error:Error?) {
        let alert = AlertControllerHelper.alert(title: "Failure", message: "Error: \(String(describing: error?.localizedDescription))")
        self.present(alert, animated: true, completion: nil)
        imagePickerController.dismiss(animated: true, completion: nil)
    }

}
