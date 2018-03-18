import UIKit
import Foundation

protocol UploadViewModelDelegate: class {
    func viewModel(_ viewModel: UploadViewModel, didUploadVideoWithSuccess success:Bool)
    func viewModel(_ viewModel: UploadViewModel, didUploadVideoWithFailure error:Error?)
}

class UploadViewModel: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    weak var delegate:UploadViewModelDelegate?

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let videoURI = info["UIImagePickerControllerMediaURL"] as? URL
        VideoOperation.upload(videoURI: videoURI, completion: { (succeed, error) in
            if (error != nil) {
                self.delegate?.viewModel(self, didUploadVideoWithFailure: error)
            } else {
                self.delegate?.viewModel(self, didUploadVideoWithSuccess:true)
            }
        })
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {

    }    

}
