//
//  BeatImportView.swift
//  loopcraft
//
//  Created by Siddharth Gurumurthi on 12/30/23.
//

import SwiftUI

struct BeatView: View {
    var onBeatImport : (MusicInfo) -> Void
    @State var beatInfo: MusicInfo?
    var body: some View {
        HStack{
            VStack(alignment: .leading) {
                FileUploadView(onUpload: onUpload)
                if let beatInfo = self.beatInfo {
                    BeatInfoView(beatInfo: beatInfo)
                }
            }
            Spacer()
        }.padding()
    }
    //play button
    private func onUpload(url: URL) {
        print("on upload")
        print(url)
        let musicInfo = MusicInfo(url: url)
        musicInfo.bpm = 120
        musicInfo.key = "A#"
        self.beatInfo = musicInfo
        onBeatImport(musicInfo)
    }
}
