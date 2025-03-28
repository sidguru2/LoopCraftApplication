//
//  MatchingLoops.swift
//  loopcraft
//
//  Created by Siddharth Gurumurthi on 12/30/23.
//

import SwiftUI
import AVFoundation

struct MatchingLoops: View {
  @Binding var loops: [Loop]
    @State var beatURL: URL
    @State var comp: AVMutableComposition?
    @State var mixed: AVMutableAudioMix?
  let firstColor: Color = .white
  let secondColor: Color = .gray.opacity(0.4)
  
//  @State private var selectedLoops = Set<Loop.ID>()
  @State private var selected = [Bool]()

  var body: some View {

    let selectedLoops = selected.filter{value in
      return value
    }
    VStack {
      HStack {
          Spacer()
        Text("Matching Loops").font(.title2)
          Spacer()
      }
      LazyVStack {
        ForEach(Array(loops.enumerated()), id: \.element) { index, loop in
          let path = "http://localhost:8000/\(loop.filename)"
            //let playerId = UUID().uuidString
          //if let url = URL(string: path) {
            if let url = loop.url {
            HStack{
              Text(loop.filename)
              Spacer()
                URLPlayerView(url: url, size: 25)
                .id(UUID().uuidString)
            }.padding()
              .contentShape(Rectangle())
              .border((selected.count > 0 && selected[index] ) ? Color.accentColor : Color.clear)
              .onTapGesture {
                selected[index] = !selected[index]
              }
          }
        }
      }
      Text("\(selectedLoops.count) loops selected")
        
        Button(action: {
            var listUrl = [beatURL]
            /*
                selected = [false, false , true]
                
             */
            for i in 0..<selected.count {
                if selected[i] == true {
                    let loop = loops[i]
                    //let path = "http://localhost:8000/\(loop.filename)"
                    //let url = URL(string: path)
                    //let url = loop.url
                    if let url = loop.url {
                        listUrl.append(url)
                    }
                    
                }
                
            }
           self.comp = merge(urls: listUrl)

        }, label: {Text("Merge")})
        if let comp = self.comp {
            PlayerView(size: 25, compositionAsset: comp)
                .id(UUID().uuidString)
            ExportButton(comp: comp)
                .id(UUID().uuidString)
            //Playe
         //   CompPlayer(comp: comp)
         //   ExportButton(comp: comp)
        }
      Spacer()
    }.onAppear {
      self.selected = loops.map{_ in false}
      print(self.selected)
    }
  }
}

