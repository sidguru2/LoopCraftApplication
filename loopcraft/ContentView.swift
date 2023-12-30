//
//  ContentView.swift
//  loopcraft
//
//  Created by Siddharth Gurumurthi on 12/29/23.
//

import SwiftUI

struct ContentView: View {
    @State var musicInfo: MusicInfo?
    var body: some View {
        VStack {
            //FileUploadView()
            BeatView(onBeatImport: onBeatImport)
            FilterView()
            LoopMixerView()
            Spacer()
            
        }
        .padding()
    }
    func onBeatImport(musicInfo: MusicInfo) {
        print("On Beat Import", musicInfo)
        self.musicInfo = musicInfo
    }
}
