//
//  PlayerView.swift
//  loopcraft
//
//  Created by Siddharth Gurumurthi on 12/30/23.
//

import SwiftUI
import AVFoundation

struct URLPlayerView: View {
    @State var url: URL
    @State var size: CGFloat
    var body: some View {
        let asset = AVURLAsset(url: url)
        VStack {
                PlayerView (size: size, urlasset: asset)
            
            
        }
    }
}



struct PlayerView: View {
    @State var size: CGFloat
    @State var urlasset: AVURLAsset?
    @State var compositionAsset: AVMutableComposition?

    
    @EnvironmentObject var globalPlayer: GlobalAVPlayer
    @State var observer: NSKeyValueObservation?
    @State private var playerState = PlayerState.initial
    
    var body: some View {
        switch playerState {
        case .initial:
            Button(action:{
                var playerItem: AVPlayerItem?
                
                if let asset = urlasset {
                    
                    let accessing = asset.url.startAccessingSecurityScopedResource()
                    defer {
                        if accessing {
                            asset.url.stopAccessingSecurityScopedResource()
                        }
                    }
                    playerItem = AVPlayerItem(asset: asset)
                    playItem(playerItem: playerItem)
                } else
                if let comp = compositionAsset{
                    playerItem = AVPlayerItem(asset: comp)
                    playItem(playerItem: playerItem)
                }
                
                
            },label: {
                Image(systemName: "play.circle").font(.system(size: size))
            }).buttonStyle(PlainButtonStyle())
        case .playing:
            Button(action:{
                self.playerState = .paused
                globalPlayer.player.pause()
            },label: {Image(systemName: "pause.circle").font(.system(size: size))
            }).buttonStyle(PlainButtonStyle())
        case .paused:
            Button(action:{
                self.playerState = .playing
                globalPlayer.player.play()
            },label: {Image(systemName: "play.circle").font(.system(size: size))
            }).buttonStyle(PlainButtonStyle())
        }
    }
    
    
    private func playItem(playerItem: AVPlayerItem?) {
        if let playerItem = playerItem {
            
            globalPlayer.player.replaceCurrentItem(with: playerItem)
            self.observer = playerItem.observe(\.status,
                                                options: [.new, .old]) {(playerItem, change) in
                if playerItem.status == .readyToPlay {
                    globalPlayer.player.volume = 1
                    globalPlayer.player.play()
                    self.playerState = .playing
                }
                
            }
        }

    }
}
