//
//  FreesoundAPI.swift
//  loopcraft
//
//  Created by Siddharth Gurumurthi on 3/16/25.
//

import Foundation

struct FreesoundSound: Codable {
    let id: Int
    let name: String
    let previews: Previews? // Make it optional to handle cases where it's missing
        
        struct Previews: Codable {
            let previewHQMP3: String? // ~128kbps mp3
            let previewLQMP3: String? // ~64kbps mp3
            let previewHQOGG: String? // ~192kbps ogg
            let previewLQOGG: String? // ~80kbps ogg
            
            enum CodingKeys: String, CodingKey {
                case previewHQMP3 = "preview-hq-mp3"
                case previewLQMP3 = "preview-lq-mp3"
                case previewHQOGG = "preview-hq-ogg"
                case previewLQOGG = "preview-lq-ogg"
            }
        }
//    let analysis: Analysis? // Make it optional
//        
//        struct Analysis: Codable {
//            let tonal: Tonal?
//            let rhythm: Rhythm?
//            
//            struct Tonal: Codable {
//                let key_key: String? // Make it optional to handle cases where it's missing
//            }
//
//            struct Rhythm: Codable {
//                let bpm: Int? // Make it optional to avoid decoding issues
//            }
//        }
//    
}

struct FreesoundResponse: Codable {
    let count: Int
    let results: [FreesoundSound]
}

class FreesoundAPI {
    private let baseURL = "https://freesound.org/apiv2/search/text/"
    private let apiKey = "jyZMHg7U6DAnpn3pcoRxQchF84r0cPzTa5amW79D" // Replace with your API key
    
    //    let key = "C"
    //    let bpmMin = 120
    //    let bpmMax = 140
    //
    //    let descriptorsFilter = "rhythm.bpm:[\(bpmMin) TO \(bpmMax)]+tonal.key_key:\"\(key)\""
    //    components.queryItems.append(URLQueryItem(name: "descriptors_filter", value: descriptorsFilter))
    
    func search(query: String, completion: @escaping ([FreesoundSound]?) -> Void) {
        var components = URLComponents(string: baseURL)!
        // let tonality: String = "C%20minor"

        components.queryItems = [
            URLQueryItem(name: "query", value: query),
            URLQueryItem(name: "token", value: apiKey),
            URLQueryItem(name: "fields", value: "id,name,url,previews,analysis,tags"),
            URLQueryItem(name: "descriptors", value: "tonal.key_key,rhythm.bpm"),
            URLQueryItem(name: "filter", value: "ac_tempo%3A[85%20TO%20*]+tag%3Aloop+ac_tonality%3A%22A%20minor%22"),
            //URLQueryItem(name: "filter", value: "ac_tempo:[*%20TO%2095]+tag:loop+ac_tonality:C minor"),
            //URLQueryItem(name: "filter", value: "ac_tonality:C minor"),
            //URLQueryItem(name: "descriptors_filter", value: "tonal.key_key:\"A\"".addingPercentEncoding(withAllowedCharacters: .alphanumerics)),
            //URLQueryItem(name: "descriptors_filter", value: "rhythm.bpm:[120 TO 140]+tonal.key_key:\"C\""),
            URLQueryItem(name: "sort", value: "created_desc"),
            URLQueryItem(name: "page_size", value: "10")
        ]
        
        guard let url = components.url else { return }
        
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                completion(nil)
                return
            }
            
            do {
                self.printJsonString(data)
                let response = try JSONDecoder().decode(FreesoundResponse.self, from: data)
//                let filteredSounds = self.filterSounds(response.results, minBPM: minBPM, maxBPM: maxBPM, key: key)
                DispatchQueue.main.async {
                    completion(response.results)
                }
            } catch {
                print("Failed to decode JSON:", error)
                completion(nil)
            }
        }
        
        task.resume()
    }
    
    func printJsonString(_ data: Data) {
        guard let jsonString = String(data: data, encoding: .utf8) else { return }
        print(jsonString)
    }
    
//    private func filterSounds(_ sounds: [FreesoundSound], minBPM: Int, maxBPM: Int, key: String) -> [FreesoundSound] {
//            return sounds.filter { sound in
//                if let bpm = sound.analysis?.rhythm?.bpm,
//                   let soundKey = sound.analysis?.tonal?.key_key {
//                    // Only keep sounds with matching key and BPM range
//                    return bpm >= minBPM && bpm <= maxBPM && soundKey == key
//                }
//                return false
//            }
//        }


}

//make tags = [vibe, instrument, genre] 
