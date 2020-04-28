//
//  Network.swift
//  VirusCase
//
//  Created by Salar Soleimani on 2020-03-11.
//  Copyright © 2020 BEKApps. All rights reserved.
//

import Alamofire

enum AlamofireErrors: String {
  case decodeErr, noNet, serverErr, ok
}
struct NetworkManager {
  
  static let shared = NetworkManager()
  
  func fetchGenericDatas<T: Decodable>(urlString: String, completion: @escaping ([T]?, AlamofireErrors) -> ()) {
    print("fetchin data from url: \(urlString)")
    guard let url = URL(string: urlString.replacingOccurrences(of: " ", with: "%20")) else { return }
    
    URLSession.shared.dataTask(with: url) { (data, resp, err) in
      if let err = err {
        print("Failed to fetch data with url(\(urlString)):", err)
        completion(nil, .serverErr)
        return
      }
      
      guard let data = data else {
        completion(nil, .noNet)
        return
      }
      
      do {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .customISO8601
        
        let obj = try decoder.decode([T].self, from: data)
        DispatchQueue.main.async {
          completion(obj, .ok)
        }
      } catch let jsonErr {
        print("Failed to decode json with url(\(urlString)):", jsonErr)
        completion(nil, .decodeErr)
      }
    }.resume()
  }
  
  func fetchGenericDataWithURL<T: Decodable>(url: URL, completion: @escaping (T?, AlamofireErrors) -> ()) {
    
    URLSession.shared.dataTask(with: url) { (data, resp, err) in
      if let err = err {
        print("Failed to fetch data with url(\(url)):", err)
        completion(nil, .serverErr)
        return
      }
      
      guard let data = data else {
        completion(nil, .noNet)
        return
      }
      
      do {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .customISO8601
        let obj = try decoder.decode(T.self, from: data)
        DispatchQueue.main.async {
          completion(obj, .ok)
        }
      } catch let jsonErr {
        print("Failed to decode json with url(\(url)):", jsonErr)
        completion(nil, .decodeErr)
      }
    }.resume()
  }
  func isUpdateAvailable(callback: @escaping (Bool)->Void) {
    let bundleId = Bundle.main.infoDictionary!["CFBundleIdentifier"] as! String
    Alamofire.request("https://itunes.apple.com/lookup?bundleId=\(bundleId)").responseJSON { response in
      if let json = response.result.value as? NSDictionary, let results = json["results"] as? NSArray, let entry = results.firstObject as? NSDictionary, let versionStore = entry["version"] as? String, let versionLocal = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String {
        let arrayStore = versionStore.split(separator: ".")
        let arrayLocal = versionLocal.split(separator: ".")

        if arrayLocal.count != arrayStore.count {
          callback(true) // different versioning system
        }

        // check each segment of the version
        for (key, value) in arrayLocal.enumerated() {
          if Int(value)! < Int(arrayStore[key])! {
            callback(true)
          }
        }
      }
      callback(false) // no new version or failed to fetch app store version
    }
  }
}
