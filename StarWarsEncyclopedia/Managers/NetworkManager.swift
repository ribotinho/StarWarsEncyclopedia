//
//  NetworkManager.swift
//  StarWarsEncyclopedia
//
//  Created by Pau Ribot Pujolras on 17/10/22.
//

import Foundation

class NetworkManager {
    
    static let shared = NetworkManager()
    let decoder = JSONDecoder()
    
    private init() {
        decoder.keyDecodingStrategy = .convertFromSnakeCase
    }

    func getFilms(for endpoint : Endpoint, completed: @escaping (Result<[Film],NetworkError>) -> Void)  {
        
        
        guard let url = URL(string: endpoint.rawValue) else {
            print("invalid URL")
            completed(.failure(NetworkError.invalidURL))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let _ = error  {
                print("error")
                completed(.failure(NetworkError.unableToComplete))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                print("invalid response")
                completed(.failure(NetworkError.invalidResponse))
                return
            }
            
            guard let data = data else {
                print("invalid data")
                completed(.failure(NetworkError.invalidResponse))
                return }
            
            
            
            do {
                let filmResult = try self.decoder.decode(FilmResult.self, from: data)
                completed(.success(filmResult.results))
                print(filmResult.results)
            }catch {
                print("decoding error")
            }
        }
        
        task.resume()
        
    }
    
}


//MARK: - Async await
extension NetworkManager {
    
    func getFilms(for endpoint : Endpoint) async throws -> [Film] {
        
        guard let url = URL(string: endpoint.rawValue) else {
            throw NetworkError.invalidURL }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else { throw NetworkError.invalidResponse }
        
        do {
            let results = try decoder.decode(FilmResult.self, from: data)
            return results.results
        }catch {
            throw NetworkError.invalidData
        }
    }
    
    func getPersons(for endpoint : Endpoint) async throws -> [Person] {
        
        guard let url = URL(string: endpoint.rawValue) else {
            throw NetworkError.invalidURL }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else { throw NetworkError.invalidResponse }
        
        do {
            let results = try decoder.decode(PersonResult.self, from: data)
            return results.results
        }catch {
            throw NetworkError.invalidData
        }
    }
    
    func getFilms<T: Codable>(type: T.Type, for endpoint : Endpoint) async throws -> T {
        
        guard let url = URL(string: endpoint.rawValue) else {
            throw NetworkError.invalidURL }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else { throw NetworkError.invalidResponse }
        
        do {
            return try decoder.decode(type, from: data)
            
        }catch {
            throw NetworkError.invalidData
        }
    }
}

enum Endpoint : String {
    case baseURL = "https://swapi.dev/api/"
    case films = "https://swapi.dev/api/films/"
    case people = "https://swapi.dev/api/people/"
}

enum NetworkError : Error {
    case invalidURL
    case invalidResponse
    case invalidData
    case unableToComplete
}
