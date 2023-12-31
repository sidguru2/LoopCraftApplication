//
//  Utils.swift
//  loopcraft
//
//  Created by Siddharth Gurumurthi on 12/30/23.
//

import Foundation


func readJSONFile(_ name: String) -> [Loop]{
   do {
      // creating a path from the main bundle and getting data object from the path
      if let bundlePath = Bundle.main.path(forResource: name, ofType: "json"),
      let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8) {
            
         // Decoding the Product type from JSON data using JSONDecoder() class.
         let catalog = try JSONDecoder().decode([Loop].self, from: jsonData)
        return catalog
      }
   } catch {
      print(error)
            
   }
    return [Loop]()
}


func shortUUID() -> String{
  let text = UUID().uuidString
  let index = text.index(text.startIndex, offsetBy: 8)
  return String(text[text.startIndex..<index])
}
