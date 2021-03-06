//
//  LoadAndDecode.swift
//  SwiftPaper
//
//  Created by 吕丁阳 on 2021/11/28.
//
import Foundation


func loadjsonfromWeb<T: Decodable>(from url: URL, force: Bool = false) async throws -> [T] {
    var session = URLSession.shared
    if force {
        let configuration = URLSessionConfiguration.ephemeral
        session = URLSession(configuration: configuration)
    }
    let (data, _) = try await session.data(from: url)
    let decoder = JSONDecoder()
    return try decoder.decode([T].self, from: data)
}

func loadjsonfromFile<T: Decodable>(_ filename: String) -> [T] {
    var placeholders: [T]
    let data: Data
    
    guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
        else {
            fatalError("Couldn't find \(filename) in main bundle.")
    }
    
    do {
        data = try Data(contentsOf: file)
    } catch {
        fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
    }
    
    do {
        let decoder = JSONDecoder()
        placeholders = try decoder.decode([T].self, from: data)
    } catch {
        fatalError("Couldn't parse \(filename):\n\(error)")
    }
    return placeholders
}

@available(iOS, deprecated: 15.0, message: "Use the built-in API instead")
extension URLSession {
    func data(from url: URL) async throws -> (Data, URLResponse) {
        try await withCheckedThrowingContinuation { continuation in
            let task = self.dataTask(with: url) { data, response, error in
                guard let data = data, let response = response else {
                    let error = error ?? URLError(.badServerResponse)
                    return continuation.resume(throwing: error)
                }

                continuation.resume(returning: (data, response))
            }

            task.resume()
        }
    }
}
