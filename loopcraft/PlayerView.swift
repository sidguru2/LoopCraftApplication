//
//  PlayerView.swift
//  loopcraft
//
//  Created by Siddharth Gurumurthi on 12/30/23.
//

import SwiftUI
import AVFoundation

struct PlayerView: View {
    @State var url: URL
    @EnvironmentObject var globalPlayer: GlobalAVPlayer
    @State var observer: NSKeyValueObservation?
    @State private var playerState = PlayerState.initial
    var body: some View {
        switch playerState {
        case .initial:
            Button(action:{
                // Task {
                print("trying play")
                
                let accessing = url.startAccessingSecurityScopedResource()
                
                defer {
                    if accessing {
                        url.stopAccessingSecurityScopedResource()
                    }
                }
                let asset = AVURLAsset(url: url)
                
                let playerItem = AVPlayerItem(asset: asset)
                globalPlayer.player.replaceCurrentItem(with: playerItem)
                self.observer = playerItem.observe(\.status,
                                                    options: [.new, .old]) {(playerItem, change) in
                    if playerItem.status == .readyToPlay {
                        globalPlayer.player.volume = 1
                        globalPlayer.player.play()
                        self.playerState = .playing
                    }
                    
                }
                
            },label: {
                Image(systemName: "play.circle").font(.system(size: 125))
            }).buttonStyle(PlainButtonStyle())
        case .playing:
            Button(action:{
                self.playerState = .paused
                globalPlayer.player.pause()
            },label: {Image(systemName: "pause.circle").font(.system(size: 125))
            }).buttonStyle(PlainButtonStyle())
        case .paused:
            Button(action:{
                self.playerState = .playing
                globalPlayer.player.play()
            },label: {Image(systemName: "play.circle").font(.system(size: 125))
            }).buttonStyle(PlainButtonStyle())
        }
    }
}


