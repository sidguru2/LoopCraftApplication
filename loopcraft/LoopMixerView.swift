//
//  LoopMixerView.swift
//  loopcraft
//
//  Created by Siddharth Gurumurthi on 12/30/23.
//

import SwiftUI

struct LoopMixerView: View {
    @State var beatInfo: MusicInfo
    @State var vibe: String?
    @State var instrument: String?
    @State var genre: String?
    @State var matchingLoops: [Loop] = []
    
   
    var body: some View {
        VStack {
            if (!matchingLoops.isEmpty) {
                
                MatchingLoops(loops: $matchingLoops, beatURL: beatInfo.url)
                
            }
            Spacer()
        }.onAppear {
            self.loadInitialLoops()
        }
    }
    
    private func loadInitialLoops() {
        let allLoops = readJSONFile("Catalog/LoopCatalog")
        var filtered = MatchesCatalog.filterByKey(loops: allLoops, inputKey: self.beatInfo.key)
        filtered = MatchesCatalog.filterByBpm(loops: filtered, inputBPM: self.beatInfo.bpm ?? 120.0)
        if self.vibe != nil{
            filtered = MatchesCatalog.filterByVibe(loops: filtered, inputVibe: self.vibe)
        }
        if self.instrument != nil{
            filtered = MatchesCatalog.filterByInst(loops: filtered, inputInst: self.instrument)
        }
        if self.genre != nil{
            filtered = MatchesCatalog.filterByGenre(loops: filtered, inputGen: self.genre)
        }
        self.matchingLoops = filtered
    }
   
}
