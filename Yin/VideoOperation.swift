import Foundation

//TODO: maybe it should be renamed, since swift call it closure
typealias completionBlock = (_ success:Bool, _ error:Error?)->Void
typealias downloadBlock = (_ uris:[URL]?, _ error:Error?)->Void

//TODO: difference struct, class and enum which one to choose
enum VideoOperation {

    //TODO: when to use static
   static func upload(videoURI:URL?, completion:completionBlock) {

        guard let uri = videoURI else {
            return
        }

        //TODO: this code can be better
        do {
            let videoData = try Data(contentsOf:uri)

            let uniqueID = String(arc4random())
            let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
            let pathURL = URL(fileURLWithPath: paths.first!).appendingPathComponent(uniqueID).appendingPathExtension("MOV")
            // You can aslo try! it has same effect as setting a breakpoint if it crashes
            try! videoData.write(to:pathURL)

            completion(true, nil)

            //This is how you catch error let error!! sigh
        } catch let error {
            completion(false,error)
        }
    }

    static func download(completion:downloadBlock) {

        let fileManager = FileManager.default
        let documentsURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first

        do {
            let fileURLs = try fileManager.contentsOfDirectory(at: documentsURL!, includingPropertiesForKeys: nil, options: [.skipsSubdirectoryDescendants,.skipsPackageDescendants])
            completion(fileURLs, nil)
        } catch let error {
            completion (nil, error)

        }
    }
}


