//
//  Key Finder.swift
//  loopcraft
//
//  Created by Siddharth Gurumurthi on 12/30/23.
//

import Foundation
import TabularData

let keys = [ "A", "A#", "B", "C", "C#", "D", "D#", "E", "F" , "F#", "G", "G#"]
func reduceNote(_ p: Float) -> String {
 let L: Float = log2(27.5)
 if p < 27.5 {
  return "-"
 }
 let logp = log2(p)
 let stepCount = 12.0 * (logp - L)
 let k = Int(round(stepCount)) % 12
 return keys[k]
}

func countItUp(notes: [String]) -> String {
    var counterA: Int = 0
    var counterAsharp: Int = 0
    var counterB: Int = 0
    var counterC: Int = 0
    var counterCsharp: Int = 0
    var counterD: Int = 0
    var counterDsharp: Int = 0
    var counterE: Int = 0
    var counterF: Int = 0
    var counterFsharp: Int = 0
    var counterG: Int = 0
    var counterGsharp: Int = 0
    
    
    for n in notes{
        if n == "A" {
            counterA += 1
        }
        if n == "A#" {
            counterAsharp += 1
        }
        if n == "B" {
            counterB += 1
        }
        if n == "C" {
            counterC += 1
        }
        if n == "C#" {
            counterCsharp += 1
        }
        if n == "D" {
            counterD += 1
        }
        if n == "D#" {
            counterDsharp += 1
        }
        if n == "E" {
            counterE += 1
        }
        if n == "F" {
            counterF += 1
        }
        if n == "F#" {
            counterFsharp += 1
        }
        if n == "G" {
            counterG += 1
        }
        if n == "D#" {
            counterGsharp += 1
        }
        
    }
    let allKeys = [counterA, counterAsharp, counterB, counterC, counterCsharp, counterD, counterDsharp, counterE, counterF, counterFsharp, counterG, counterGsharp]
    let i = allKeys.argmax() ?? 0
    let selectedKey = keys[i]
    
    
return selectedKey
}

func findKey(pitches: [Float]) -> String {
    
    var notes : [String] = []
    for p in pitches{
        let note = reduceNote(p)
        if note != "-" {
            notes.append(note)
        }
        
    }
    
    return countItUp(notes: notes)
    
   
    
}
extension Array where Element: Comparable {
    func argmax() -> Index? {
        return indices.max(by: { self[$0] < self[$1] })
    }
}
