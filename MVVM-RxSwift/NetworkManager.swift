//
//  NetworkManager.swift
//  MVVM-RxSwift
//
//  Created by Ravi Tripathi on 29/11/19.
//  Copyright © 2019 Ravi Tripathi. All rights reserved.
//

import Foundation

class User {
    static let current = User()
    var userName: String?
}

enum API: String {
    case following
    case repos
    
    func getURL() -> URL? {
        guard let userName = User.current.userName else {
            return nil
        }
        let composedURLString = "\(NetworkManager.baseURL)\(userName)/\(self.rawValue)/"
        return URL(string: composedURLString)
    }
}

class NetworkManager {
    static let baseURL = "https://api.github.com/users/"
    
    
    func getFollowingList(completion: @escaping ([FollowingUser]?) -> (Void)) {
        guard let url = API.following.getURL() else {
            return
        }
        let task = URLSession(configuration: URLSessionConfiguration.default).dataTask(with: url) { (data, response, error) in
            guard let httpResponse = response as? HTTPURLResponse,
                (200...299).contains(httpResponse.statusCode) else {
                    completion(nil)
                    return
            }
            
            if let data = data, let decodedResponse = try? JSONDecoder().decode([FollowingUser].self, from: data) {
                completion(decodedResponse)
            }
        }
        task.resume()
    }
    
    func getRepoList() {
        guard let url = API.repos.getURL() else {
            return
        }
        let task = URLSession(configuration: URLSessionConfiguration.default).dataTask(with: url) { (data, response, error) in
            guard let httpResponse = response as? HTTPURLResponse,
                (200...299).contains(httpResponse.statusCode) else {
                    completion(nil)
                    return
            }
            
            if let data = data, let decodedResponse = try? JSONDecoder().decode([FollowingUser].self, from: data) {
                completion(decodedResponse)
            }
        }
        task.resume()
    }
}
