//
//  ExportButton.swift
//  loopcraft
//
//  Created by Siddharth Gurumurthi on 12/30/23.
//

import SwiftUI
import AVFoundation

struct ExportButton: View {
  
  var comp: AVMutableComposition
  @State var showPath = false
  @State var exportedPath: String?
  var body: some View {
    Button(action: {
      let panel = NSOpenPanel()
      panel.allowsMultipleSelection = false
      panel.canChooseDirectories = true
      panel.canChooseFiles = false
      if panel.runModal() == .OK {
        let exportFolder = panel.url?.lastPathComponent ?? "<none>"
        if let panelUrl = panel.url {
          exportFile(panelUrl)
        }
      }
    }, label: {Image(systemName: "square.and.arrow.up")})
    if showPath,
       let path = exportedPath{
      
      Text("Your mixed audio is available at \(path)")
    }
  }
  
  private func exportFile(_ panelUrl: URL) {
    let _assetExport = AVAssetExportSession(asset: comp, presetName: AVAssetExportPresetAppleM4A)
    
    let mixedAudio: String = "mixed-\(shortUUID())"
//    let exportPath = exportFolder + (mixedAudio)
    let exportURL = panelUrl.appendingPathComponent(mixedAudio, conformingTo: UTType.mpeg4Audio)
    print("url", exportURL, "path", exportURL.absoluteString)
    _assetExport?.outputFileType = AVFileType.m4a
    _assetExport?.outputURL = exportURL
    _assetExport?.shouldOptimizeForNetworkUse = true
    _assetExport?.exportAsynchronously(completionHandler: {() -> Void in
      print("Completed Sucessfully", exportURL.absoluteString)
      self.exportedPath = exportURL.absoluteString.replacing("file://", with: "")
      self.showPath = true
    })
  }
}


