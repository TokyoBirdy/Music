//
//  HeartButton.swift
//  Yin
//
//  Created by ceciliah on 4/10/18.
//  Copyright © 2018 Humlan. All rights reserved.
//

import UIKit

enum UIButtonState {
    case Liked
    case Normal
}

class HeartButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addTarget(self, action: #selector(buttonTapped), for: UIControlEvents.touchUpInside)
        self.setImageForState(UIButtonState.Normal)
    }

    required init?(coder aDecoder: NSCoder) {
      super.init(coder: aDecoder)
    }

    func setImageForState(_ state:UIButtonState) {
        switch state {
        case .Liked:
            let hightlightedHeartString = "❤️"
            let highlightedHeartImage = hightlightedHeartString.image()
            self.setImage(highlightedHeartImage, for: UIControlState.highlighted)
        default:
            let heartString :String = "♡"
            let heartImage = heartString.image()
            self.setImage(heartImage, for: UIControlState.normal)
        }
    }

    @objc func buttonTapped() {
        print("Button tapped")
    }

}





