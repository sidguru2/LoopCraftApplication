//
//  MusicInfoView.swift
//  loopcraft
//
//  Created by Siddharth Gurumurthi on 12/30/23.
//

import SwiftUI

struct BeatInfoView: View {
    var beatInfo: MusicInfo
    var body: some View {
        VStack(alignment: .leading){
            Text(beatInfo.url.lastPathComponent)
                .frame(width: 500, alignment: .leading)
                .lineLimit(1)
                .truncationMode(.tail)
            Text("Bpm: \(beatInfo.bpm,  specifier: "%.2f")")
                .frame(alignment: .leading)
            Text("Key: \(beatInfo.key)")
                .frame(alignment: .leading)
        }.padding()
    }
}
