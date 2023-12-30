//
//  MatchesCatalog.swift
//  loopcraft
//
//  Created by Siddharth Gurumurthi on 12/30/23.
//

import Foundation

class MatchesCatalog {
  
  static func filterByKey(loops: [Loop], inputKey: String?) -> [Loop] {
    return loops.filter{ loop in
      if let inputKey = inputKey {
        return (loop.key ?? "").contains(inputKey)
          
      } else {
       return true
      }
    }
  }
  
  static func filterByBpm(loops: [Loop], inputBPM: Float) -> [Loop] {
    return loops.filter{ loop in
      (loop.tempo <= (inputBPM + 10)) || (loop.tempo >= (inputBPM - 10))
    }
  }
    
    static func filterByVibe(loops: [Loop], inputVibe: String?) -> [Loop] {
      return loops.filter{ loop in
        if let inputVibe = inputVibe {
            return (loop.vibe.uppercased()).contains(inputVibe.uppercased())
        } else {
         return true
        }
      }
    }
    
    static func filterByInst(loops: [Loop], inputInst: String?) -> [Loop] {
      return loops.filter{ loop in
        if let inputInst = inputInst {
            return (loop.instrument.uppercased()).contains(inputInst.uppercased())
        } else {
         return true
        }
      }
    }
    
    static func filterByGenre(loops: [Loop], inputGen: String?) -> [Loop] {
      return loops.filter{ loop in
        if let inputGen = inputGen {
            return (loop.genre.uppercased()).contains(inputGen.uppercased())
        } else {
         return true
        }
      }
    }
    
    
}
