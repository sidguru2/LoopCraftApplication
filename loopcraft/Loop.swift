//
//  Loop.swift
//  loopcraft
//
//  Created by Siddharth Gurumurthi on 12/30/23.
//

import Foundation
struct Loop: Decodable, Identifiable, Hashable {
  let id: Int
  let filename: String
  let genre: String
  let instrument: String
  let pitch: String
  // pitch set
  let mood: String
  let vibe: String
  let tempo: Float
  let key: String?
  let form: String
  let culture: String?
  let artist: String?
  let timesignature: String
  
  public func hash(into hasher: inout Hasher) {
    hasher.combine(id)
  }
}
