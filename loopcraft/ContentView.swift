//
//  ContentView.swift
//  loopcraft
//
//  Created by Siddharth Gurumurthi on 12/29/23.
//

import SwiftUI
import AVFoundation

struct ContentView: View {
    @State var musicInfo: MusicInfo?
    @State private var vibe: String?
    @State private var instrument: String?
    @State private var genre: String?
    @StateObject var globalPlayer = GlobalAVPlayer()
    var body: some View {
        VStack {
            //FileUploadView()
            BeatView(onBeatImport: onBeatImport)
            FilterView(vibe: $vibe, genre: $genre, instrument: $instrument)
            LoopMixerView()
            Spacer()
            
        }
        .padding()
        .environmentObject(globalPlayer)
    }
    func onBeatImport(musicInfo: MusicInfo) {
        print("On Beat Import", musicInfo)
        self.musicInfo = musicInfo
    }
}
