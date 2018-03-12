import UIKit

class VideoDataSource: NSObject {

    private var videoURIs = [URL]()

    let names = ["Gudetama","Doreimon", "Richie"]


    override init() {
        for name in names {
            let path = Bundle.main.path(forResource: name, ofType:"MOV")
            let videoURI = URL(fileURLWithPath:path!)
            videoURIs.append(videoURI)
        }
    }

    func videoURI(index:NSInteger) ->URL {
        return videoURIs[(index%videoURIs.count)]
    }




}
