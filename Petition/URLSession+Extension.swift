//
//  URLSession+Extension.swift
//  URLSession+Extension
//
//  Created by Evans Domina Attafuah on 04/08/2021.
//

import SwiftUI

extension URLSession {
    func decode<T: Decodable> (
        _ type: T.Type = T.self,
        from url: URL,
        keyDecodingStrategy: JSONDecoder.KeyDecodingStrategy = .useDefaultKeys,
        dataDecodingStrategy: JSONDecoder.DataDecodingStrategy = .deferredToData,
        dateDecodingStrategy: JSONDecoder.DateDecodingStrategy = .secondsSince1970
    ) async throws -> T {
        //try and wait for data
        let (data, _) = try await data(from: url)
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = keyDecodingStrategy
        decoder.dataDecodingStrategy = dataDecodingStrategy
        decoder.dateDecodingStrategy = dateDecodingStrategy
        
        let decoded = try decoder.decode(T.self, from: data)
        return decoded
    
    }
}

