//
//  NumberFactService.swift
//  tca-examples
//
//  Created by incetro on 12/12/23.
//

import Foundation

// MARK: - NumberFactService

public protocol NumberFactService {
    
    /// Obtain some number's fact
    /// - Returns: number fact string
    func generateFact(number: Int) async throws -> String
}
