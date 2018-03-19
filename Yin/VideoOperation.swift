import Foundation

//TODO: maybe it should be renamed, since swift call it closure
typealias completionBlock = (_ success:Bool, _ error:Error?)->Void
typealias downloadBlock = (_ uris:[URL]?, _ error:Error?)->Void

//TODO: difference struct, class and enum which one to choose
enum VideoOperation {

    //TODO: when to use static
   static func upload(videoURI:URL?, completion:completionBlock) {

        //redeclaire
        guard let videoURI = videoURI else {
            return
        }

        //TODO: this code can be better
        do {


            let lastPath = videoURI.absoluteURL.lastPathComponent
            let splited = lastPath.split(separator: ".")

            let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)

            guard let name = splited.first, let type = splited.last else  {
                return

                //TODO: do throw an error, so much safer
            }

            let pathURL = URL(fileURLWithPath: paths.first!).appendingPathComponent(String(name)).appendingPathExtension(String(type))

            let videoData = try Data(contentsOf:videoURI)
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

    static func cleanUp(completion:completionBlock) {
        let fileManager = FileManager.default
        let documentURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first

        do {
            //TODO: I guess I just unwrapp it, cause I know it exists!
            let fileURLs = try fileManager.contentsOfDirectory(at: documentURL!, includingPropertiesForKeys: nil, options: [.skipsSubdirectoryDescendants,.skipsPackageDescendants])

            for fileURL in fileURLs {
               try fileManager.removeItem(at: fileURL)
            }
        } catch let error {
                   completion(false, error)
        }

        completion(true, nil)

    }
}


