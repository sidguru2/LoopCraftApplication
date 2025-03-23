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
    //@State var fetchedLoops: [Loop] = []
    let freesoundAPI = FreesoundAPI()
    
    var body: some View {
        VStack {
            if (!matchingLoops.isEmpty) {
                
                MatchingLoops(loops: $matchingLoops, beatURL: beatInfo.url)
                
            }
            Spacer()
        }.onAppear {
            //self.loadInitialLoops()
            self.fetchFreeSoundLoops()
        }
    }
    
    private func fetchFreeSoundLoops() {
//        let minBPM = 85
//        let maxBPM = 95
//        let key = "A"

        freesoundAPI.search(query: "cop") { sounds in
            if let sounds = sounds {
                let loops = sounds.map { sound in
                    Loop(
                        id: sound.id,
                        filename: sound.name,
                        genre: "Unknown",
                        instrument: "Unknown",
                        pitch: "Unknown",
                        mood: "Unknown",
                        vibe: "Unknown",
                        tempo: 0.0,
                        key: nil,
                        form: "Unknown",
                        culture: nil,
                        artist: nil,
                        timesignature: "4/4",
                        url: URL(
                            string: sound.previews?.previewHQMP3 ??
                                    sound.previews?.previewLQMP3 ??
                                    sound.previews?.previewHQOGG ??
                                    sound.previews?.previewLQOGG ??
                                    "https://example.com"
                        )!
                    )
                }
                DispatchQueue.main.async { //need this cuz sm about asyncrhonus network request
                    self.matchingLoops = loops
                }

//                for sound in sounds {
//                    print("Sound name: \(sound.name)")
////                    print("PreviewURL: \(sound.url)")
//                    //try filtering analysis params here - ex. if bpm outside range, append "NO BPM" to loop name. and then filter out based on loop name
//                }
                
                                
                                
                              
            } else {
                print("No results found")
            }
            
        }
        
    }
    
    private func loadInitialLoops(from allLoops: [Loop]) {
        //let allLoops = readJSONFile("Catalog/LoopCatalog")
        var filtered = MatchesCatalog.filterByKey(loops: allLoops, inputKey: self.beatInfo.key)
        filtered = MatchesCatalog.filterByBpm(loops: filtered, inputBPM: self.beatInfo.bpm)
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
