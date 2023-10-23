//
//  IIQMTests.swift
//  IIQMTests
//
//  Created by Ryan Arana on 6/15/18.
//  Copyright © 2018 Dexcom. All rights reserved.
//

import XCTest
@testable import IIQM

class IIQMTests: XCTestCase {
    var iiqm: IIQM!
    
    override func setUp() {
        super.setUp()
        iiqm = IIQM()
    }
    
    override func tearDown() {
        iiqm = nil
        super.tearDown()
    }
    
    // Test if the file reading functionality is working as expected with a valid data file.
    func testReadFileContents_WhenFileExists_ShouldReadSuccessfully() {
        do {
            _ = try iiqm.readFileContents(atPath: Bundle.main.path(forResource: "data", ofType: "txt")!)
            XCTAssert(true)
        } catch {
            XCTFail("File reading failed with error: \(error)")
        }
    }
    
    // Test if the file reading functionality handles non-existent files properly.
    func testReadFileContents_WhenFileNotFound_ShouldThrowFileReadingError() {
        do {
            _ = try iiqm.readFileContents(atPath: "nonexistentPath")
            XCTFail("Expected a file reading error")
        } catch IIQM.IIQMError.fileReadingError {
            XCTAssert(true)
        } catch {
            XCTFail("Unexpected error: \(error)")
        }
    }
    
    // Test IIQM calculation with valid data of 20K values.
    func testCalculate_With20KValidData_ShouldReturnExpectedIIQM() {
        do {
            let result = try iiqm.calculate(fromFile: Bundle.main.path(forResource: "data-20k", ofType: "txt")!)
            
            let expectedIIQM: Double = 413.15
            
            XCTAssertEqual(result, expectedIIQM, accuracy: 0.01, "Expected \(expectedIIQM), but got \(result)")
        } catch {
            XCTFail("IIQM calculation failed with error: \(error)")
        }
    }
    
    // Test IIQM calculation with insufficient data (only 3 valid values).
    func testCalculate_WithInsufficientData_ShouldReturnZero() {
        do {
            let result = try iiqm.calculate(fromFile: Bundle.main.path(forResource: "tinyData", ofType: "txt")!)
            
            let expectedIIQM: Double = 0.0
            
            XCTAssertEqual(result, expectedIIQM, accuracy: 0.01, "Expected \(expectedIIQM), but got \(result)")
        } catch {
            XCTFail("IIQM calculation failed with error: \(error)")
        }
    }
    
    // Test IIQM calculation with invalid data (contains strings).
    func testCalculate_WithInvalidData_ShouldThrowInvalidDataError() {
        do {
            _ = try iiqm.calculate(fromFile: Bundle.main.path(forResource: "invalidData", ofType: "txt")!)
            XCTFail("Expected an error due to invalid data")
        } catch IIQM.IIQMError.invalidData {
            XCTAssert(true)
        } catch {
            XCTFail("Unexpected error: \(error)")
        }
    }
    
    // Test the performance of IIQM calculation with a valid data file of 20K values.
    func testPerformance_With20KValidData_ShouldCompleteWithinAcceptableTime() {
        self.measure {
            do {
                _ = try iiqm.calculate(fromFile: Bundle.main.path(forResource: "data-20k", ofType: "txt")!)
            } catch {
                XCTFail("Performance test failed with error: \(error)")
            }
        }
    }
}
