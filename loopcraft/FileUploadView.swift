//
//  FileUploadView.swift
//  loopcraft
//
//  Created by Siddharth Gurumurthi on 12/30/23.
//

import SwiftUI
import AVFoundation


struct FileUploadView: View {
    var onUpload: (URL) -> Void
    @State private var isImporting = false
    @State private var beatURL: URL?
    @State private var beatName: String?
    var body: some View {
        
            Button {
                isImporting = true
            } label: {
                Label("Import your beat", systemImage: "play.circle")
            }.fileImporter(isPresented: $isImporting,
                           allowedContentTypes: [.wav, .mp3]) {result in
                switch result {
                case .success(let url):
                    
                    onUpload(url)
                  
                case .failure(let error):
                    print(error)
                }
            // []    ()
        
        }
    }
}


