//
//  BeatImportView.swift
//  loopcraft
//
//  Created by Siddharth Gurumurthi on 12/30/23.
//

import SwiftUI
import aubio
import Accelerate
import AVFoundation

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
            if let beatInfo = self.beatInfo {
                URLPlayerView(url: beatInfo.url, size: 125)
                    .id(UUID().uuidString)
            }
            Spacer()
        }.padding()
    }
    //play button
    private func onUpload(url: URL) {
        print("on upload")
        print(url)
//        let musicInfo = MusicInfo(url: url)
//        musicInfo.bpm = 120
//        musicInfo.key = "A#"
        let result = extractInfo(from: url)
        
        switch result {
        case .success(let musicInfo):
            self.beatInfo = musicInfo
            onBeatImport(musicInfo)
        case .failure(let error):
            print("error")
        }
      
        
    }
    
    private func extractInfo(from url: URL) -> Result<MusicInfo, Error>{
        let accessing = url.startAccessingSecurityScopedResource()
        var musicInfo = MusicInfo(url: url)
        defer {
            if accessing {
                url.stopAccessingSecurityScopedResource()
            }
        }
        let path = url.path()
        let hop_size : uint_t = 512
        let win_size : uint_t = 1024;
        let a = new_fvec(hop_size)
        let b = new_aubio_source(path, 0, hop_size)
        let sr: uint_t = aubio_source_get_samplerate(b);
        
        
        let o = new_aubio_tempo("specdiff", win_size, hop_size, sr)
        let out = new_fvec (1)
        
        let pitch = new_aubio_pitch("yin", win_size, hop_size, sr)
        let pitchout = new_fvec(1)
        var read: uint_t = 0
        var total_frames : uint_t = 0
        while (true) {
            aubio_source_do(b, a, &read)
            total_frames += read
            if (read < hop_size) { break }
            aubio_tempo_do(o,a,out)
            if let data = fvec_get_data(out) {
                if (data[0] != 0) {
                    let this_beat = aubio_tempo_get_last_s(o)
                    musicInfo.beats.append(this_beat)
                    print(String(format: "beat at %.3fms, %.3fs, frame %d, %.2f bpm ",
                                 "with confidence %.2f\n",
                                 aubio_tempo_get_last_ms(o), aubio_tempo_get_last_s(o),
                                 aubio_tempo_get_last(o), aubio_tempo_get_bpm(o),
                                 aubio_tempo_get_confidence(o)));
                }
            }
            
            aubio_pitch_do(pitch, a, pitchout)
            if let pitchdata = fvec_get_data(pitchout) {
                let p = pitchdata[0]
                if p > 0.0 {
                    let note = reduceNote( p)
                    musicInfo.pitches.append(p)
                    musicInfo.notes.append(note)
                    print(reduceNote(pitchdata[0]))
                    print(String(format: "pitch  %.3f  with confidence %.2f\n",
                                 pitchdata[0],
                                 aubio_pitch_get_confidence(pitch)));
                    
                }
                
            }
        }
        print("read", total_frames, "frames at", sr, "Hz")
        musicInfo.sampleRate = Int(sr)
        musicInfo.frameCount = Int(total_frames)
        musicInfo.computeBpm()
        musicInfo.computeKey()
        del_aubio_source(b)
        //        del_aubio_beattracking(tempo);
        del_fvec(a)
        del_fvec(out)
        
        return Result { musicInfo }
        
    }
}
