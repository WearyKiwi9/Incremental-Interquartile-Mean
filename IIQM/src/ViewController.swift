//
//  ViewController.swift
//  IIQM
//
//  Created by Ryan Arana on 6/15/18.
//  Copyright © 2018 Dexcom. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let iiqm = IIQM()
        
        // Ensure that the file path is valid before attempting to calculate IIQM
        guard let filePath = Bundle.main.path(forResource: "data-20k", ofType: "txt") else {
            print("Failed to find the file path.")
            return
        }
        
        // Using do-catch to handle errors that might be thrown during IIQM calculation
        do {
            _ = try iiqm.calculate(fromFile: filePath)
        } catch IIQM.IIQMError.fileReadingError {
            print("Error reading the file.")
        } catch IIQM.IIQMError.invalidData {
            print("Invalid data encountered.")
        } catch {
            print("An unexpected error occurred: \(error).")
        }
    }
}
