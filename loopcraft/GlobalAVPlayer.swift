//
//  GlobalAVPlayer.swift
//  loopcraft
//
//  Created by Siddharth Gurumurthi on 12/30/23.
//

import Foundation
import AVFoundation

enum PlayerState {
    case initial
    case playing
    case paused
}


class GlobalAVPlayer: ObservableObject {
    var player = AVPlayer()
}
