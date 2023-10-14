//
//  NetworkService.swift
//  TestApp
//
//  Created by sidzhe on 12.10.2023.
//

import UIKit

//MARK: - NetworkServiceProtocol

protocol NetworkServiceProtocol: AnyObject {
    func searchTrack<T: Decodable>(search: String, completion: @escaping (Result<T, RequestError>) -> Void)
    func loadImage(from model: [SearchTracks], completion: @escaping (Result<[UIImage], RequestError>) -> Void)
}


//MARK: - NetworkService

final class NetworkService: NetworkServiceProtocol {
    
    private var imageCache = NSCache<NSString, UIImage>()
    
    ///searchTrack
    func searchTrack<T: Decodable>(search: String, completion: @escaping (Result<T, RequestError>) -> Void) {
        
        var urlComponents = URLComponents()
        let endpoint = ItunesEndpoint.searchTrack
        
        urlComponents.scheme = endpoint.scheme
        urlComponents.host = endpoint.host
        urlComponents.path = endpoint.path
        urlComponents.queryItems = [URLQueryItem(name: Constants.term, value: search), URLQueryItem(name: "limit", value: "10")]
        
        guard let url = urlComponents.url else {
            completion(.failure(.invalidURL))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            if error != nil {
                completion(.failure(.noResponse))
                return
            }
            
            guard let response = response as? HTTPURLResponse, let data = data else {
                completion(.failure(.noDataReceived))
                return
            }
            
            switch response.statusCode {
                
            case 200...299:
                guard let decodedData = try? JSONDecoder().decode(T.self, from: data) else {
                    completion(.failure(.decode))
                    return
                }
                completion(.success(decodedData))
            case 401:
                return completion(.failure(.unexpectedStatusCode))
            default:
                return completion(.failure(.unknown))
            }
        }.resume()
    }
    
    //MARK: - LoadImage
    
    func loadImage(from model: [SearchTracks], completion: @escaping (Result<[UIImage], RequestError>) -> Void) {
        
        var images = [UIImage]()
        let group = DispatchGroup()
        
        model.forEach { element in
            group.enter()
            
            guard let urlString = element.artworkUrl100?.replacingOccurrences(of: Constants.size100, with: Constants.size600),
                  let url = URL(string: urlString) else {
                group.leave()
                return completion(.failure(.invalidURL))
            }
            
            let session = URLRequest(url: url, cachePolicy: URLRequest.CachePolicy.returnCacheDataElseLoad, timeoutInterval: 10)
            
            URLSession.shared.dataTask(with: session) { data, response, error in
                if error != nil {
                    group.leave()
                    return completion(.failure(.noResponse))
                }
                
                guard let data = data else {
                    group.leave()
                    return completion(.failure(.noDataReceived))
                }
                
                let image = UIImage(data: data) ?? UIImage(systemName: "swift") ?? UIImage()
                self.imageCache.setObject(image, forKey: urlString as NSString)
                images.append(image)
                group.leave()
            }.resume()
        }
        
        group.notify(queue: .main) {
            completion(.success(images))
        }
    }
}




