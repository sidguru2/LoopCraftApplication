//
//  MusicInfo.swift
//  loopcraft
//
//  Created by Siddharth Gurumurthi on 12/30/23.
//

import Foundation
import Accelerate
class MusicInfo {
    var url: URL
    var frameCount: Int = 0
    var sampleRate: Int = 0
    var beats: [Float] = []
    var bpm: Float = 0.0
    var pitches: [Float] = []
    var notes: [String] = []
    var key: String = ""
    
    var vibe: String = ""
    /*
     func computeBpm() {
     if beats.count > 1 {
     let bpms = beats.diff().map {element in
     60.0/element
     }
     self.bpm = median(values: bpms) ?? 0.0
     }
     }
     
     func computeKey() {
     if notes.count > 1 {
     
     self.key = countItUp(notes: notes)
     
     }
     
     }*/
    
    
    init(url: URL) {
        self.url = url
    }
}
