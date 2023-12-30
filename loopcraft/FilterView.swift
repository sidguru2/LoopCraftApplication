//
//  FilterView.swift
//  loopcraft
//
//  Created by Siddharth Gurumurthi on 12/30/23.
//

import SwiftUI


struct FilterView: View {
    @Binding var vibe: String?
    @Binding var genre: String?
    @Binding var instrument: String?
    var body: some View {
        Form {
            HStack {
                let vibes = ["Spacey", "Sad", "Hard", "Evil", "Melodic", "Lofi", "Live"]
                let instruments = ["Guitar", "Synths", "Bells", "Marimba", "Brass", "Vocals", "Piano", "Drums + Vocals", "Guitar + Vocals", "Orchestra"]
                let genres = ["Techno", "Hip-Hop", "Trap", "Pop", "Classical", "Rage", "Electronic", "Orchestral", "UK Drill", "Afrobeat", "House", "Breakbeat", "Dancehall", "Soul"]
                let selectedVibe = Binding(
                    get: { self.vibe},
                    set: { self.vibe = $0 == self.vibe ? nil : $0 }
                )
                Picker("Vibe", selection: selectedVibe) {
                    ForEach(vibes, id: \.self) {
                        Text("\($0)").tag(Optional($0))
                    }
                }
                .pickerStyle(.menu)
                
                let selectedInstrument = Binding(
                    get: { self.instrument},
                    set: { self.instrument = $0 == self.instrument ? nil : $0 }
                )
                
                Picker("Instrument", selection: selectedInstrument) {
                    ForEach(instruments, id: \.self) {
                        Text("\($0)").tag(Optional($0))
                    }
                }
                .pickerStyle(.menu)
                
                let selectedGenre = Binding(
                    get: { self.genre},
                    set: { self.genre = $0 == self.genre ? nil : $0 })
                Picker("Genre", selection: selectedGenre) {
                    ForEach(genres, id: \.self) {
                        Text("\($0)").tag(Optional($0))
                    }
                }
                .pickerStyle(.menu)
            }
            
        }.navigationTitle("Filters")
    }
}
