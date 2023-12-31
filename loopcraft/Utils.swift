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

// https://www.tutorialspoint.com/swift-program-to-find-median-of-an-unsorted-array
func median(values: [Float]) -> Float? {
  let count = values.count
  if count == 0 {
    return nil
  }
  let isOdd = count % 2 > 0
  let sorted = values.sorted()
  if isOdd {
    let mid = (count-1) / 2
    return sorted[mid]
  } else {
    let l = (count-1) / 2
    let r = l + 1
    return (sorted[l] + sorted[r]) / 2.0
  }
}

//diff
// https://stackoverflow.com/questions/50689535/does-swift-have-a-function-similar-to-numpy-diff-that-calculates-the-difference

extension Collection where Element: SignedNumeric {
  func diff() -> [Element] {
    guard var last = first else { return [] }
    return dropFirst().map { element in
      defer { last = element }
      return element - last
    }
  }
}

