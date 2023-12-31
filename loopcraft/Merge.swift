//
//  Merge.swift
//  loopcraft
//
//  Created by Siddharth Gurumurthi on 12/30/23.
//

import Foundation
import SwiftUI
import AVFoundation
// merge func
func merge(urls: [URL]) -> AVMutableComposition {
    //set comp to be avmutcomp
    let composition = AVMutableComposition()
    //security check of each url
    Task {
        for url in urls {
            do {
                let accessing = url.startAccessingSecurityScopedResource()
                defer {
                    if accessing {
                        url.stopAccessingSecurityScopedResource()
                    }
                }
                // create asset track to hold audio
                let asset = AVURLAsset(url: url, options: nil)
                
                //create duration, tracks
                //add new track to composition, insert time range of source track
                let duration = try await asset.load(.duration)
                let tracks = try await asset.loadTracks(withMediaType: AVMediaType.audio)
                //print statement here if error
                let audioTrack: AVMutableCompositionTrack? = composition.addMutableTrack(withMediaType: AVMediaType.audio, preferredTrackID: kCMPersistentTrackID_Invalid)
                try audioTrack?.insertTimeRange(CMTimeRangeMake(start: CMTime.zero,
                                                                duration:duration), of:
                                                    tracks[0], at: CMTime.zero)
            }catch {
                print("error adding audio")
                print("\(String(describing: error.localizedDescription))")
            }
        }
    }
    print("all media", composition)
    return composition

}

// mix func
func mix(urls: [URL]) async throws -> AVMutableAudioMix {
    
    let assets = urls.map{ url in
        return AVURLAsset(url: url, options: nil)
    }
    guard let asset = assets.first else {
        throw fatalError("no assets to merge")
    }
    // redfine comp, duration, tracks, and audiotrack
    let composition = AVMutableComposition()
    guard let audioTrack: AVMutableCompositionTrack = composition.addMutableTrack(withMediaType: AVMediaType.audio, preferredTrackID: kCMPersistentTrackID_Invalid) else {
        throw fatalError("no audio track")
    }
    //don't know why guard funcs necessary, just put them in and it fixed errors
    let duration = try await asset.load(.duration)
    let tracks = try await asset.loadTracks(withMediaType: AVMediaType.audio)
    try audioTrack.insertTimeRange(CMTimeRangeMake(start: CMTime.zero,
                                                    duration:duration), of:
                                        tracks[0], at: CMTime.zero)
    //create object to hold audio mix
    let audioMix = AVMutableAudioMix()
    //create array for input parameters
    var inputParameters = [AVMutableAudioMixInputParameters]()
    // for every asset, add parameters of added track to audio mix
    for asset in assets {
        do {
            let tracks = try await asset.loadTracks(withMediaType: AVMediaType.audio)
            let inputp = AVMutableAudioMixInputParameters(track: tracks.first)
            // add inputp to array of inputps
            inputParameters.append(inputp)
            
        } catch {
            print("error mixing audio")
            print("\(String(describing: error.localizedDescription))")
        }
    }
    audioMix.inputParameters = inputParameters
    return audioMix
}
