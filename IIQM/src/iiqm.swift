//
//  iiqm.swift
//  IIQM
//
//  Created by Shaun Winters on 9/21/17.
//  Copyright © 2017 Dexcom. All rights reserved.
//

import Foundation

class IIQM {
    
    // Custom error types for handling file reading and data validation errors.
    enum IIQMError: Error {
        case fileReadingError
        case invalidData
    }
    
    /// Calculates the final interquartile mean from the dataset in the specified file.
    func calculate(fromFile path: String) throws -> Double {
        let lines = try readFileContents(atPath: path)
        
        var data: [Int] = []
        var finalIIQM: Double = 0.0
        
        for line in lines {
            if let value = Int(line){
                insert(&data, value)
                
                if data.count >= 4 {
                    finalIIQM = try calculateIIQM(forData: &data)
                }
            } else {
                throw IIQMError.invalidData
            }
        }

        return finalIIQM // Returning finalIIQM for testing purposes
    }
    
    /// Inserts a value into the data array while maintaining sorted order.
    /// Uses a binary search to find the correct insertion point, reducing the time complexity.
    private func insert(_ data: inout [Int], _ value: Int) {
        var low = 0
        var high = data.count - 1
        
        while low <= high {
            let mid = (low + high)/2
            if data[mid] == value {
                data.insert(value, at: mid)
                return
            } else if data[mid] < value {
                low = mid + 1
            } else {
                high = mid - 1
            }
        }
        
        data.insert(value, at: low)
    }
    
    /// Reads the file contents, trims unnecessary whitespaces and newlines, and splits the content into lines.
    func readFileContents(atPath path: String) throws -> [String] {
        do {
            let contents: String = try String(contentsOfFile: path, encoding: .ascii)
            let trimmed = contents.trimmingCharacters(in: .whitespacesAndNewlines)
            return trimmed.components(separatedBy: .newlines)
        } catch {
            throw IIQMError.fileReadingError
        }
    }

    /// Calculates the interquartile mean for the given dataset.
    private func calculateIIQM(forData data: inout [Int]) throws -> Double {
        let quarter = Double(data.count) / 4.0
        
        // Calculating the bounds for the interquartile range.
        let lowerBound = Int(quarter.rounded(.up)) - 1
        let upperBound = Int((quarter * 3).rounded(.down))
                
        // Calculating the sum of the interquartile range excluding the first and last elements.
        var sum = 0
        for i in lowerBound+1..<upperBound {
            sum += data[i]
        }
        
        // Factor accounts for the weight of the first and last elements in the interquartile mean calculation.
        let factor = quarter - (Double(upperBound-lowerBound+1) / 2.0 - 1)
        
        // Calculating the weighted mean of the interquartile range.
        let mean = (Double(sum) + Double(data[lowerBound] + data[upperBound]) * factor) / (2.0 * quarter)
        print("Index => \(data.count), Mean => \(String(format: "%.2f", mean))")
        
        return mean
    }
}
