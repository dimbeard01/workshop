////
////  ImageManager.swift
////  Alerts
////
////  Created by Dima on 07.07.2020.
////  Copyright © 2020 Dima. All rights reserved.
////
//
//import UIKit
//import PINRemoteImage
//import PINCache
//
//import AsyncDisplayKit
//
//class ImageManager {
//    static var shared = ImageManager()
//    
//    class RemoteImageDownloader: ASPINRemoteImageDownloader {
//        override func sharedPINRemoteImageManager() -> PINRemoteImageManager {
//            return ImageManager.shared.pinRemoteImageManager
//        }
//    }
//    
//    var remoteImageDownloader: ASPINRemoteImageDownloader = RemoteImageDownloader.shared()
//    var pinRemoteImageManager: PINRemoteImageManager = PINRemoteImageManager.shared()
//    
//    var pinCache: PINCache = PINCache.shared
//    
//    lazy var qImageManager: QueueManager = {
//        let qm = QueueManager()
//        qm.queue.underlyingQueue = .global(qos: .userInteractive)
//        return qm
//    }()
//    
//    deinit {
//        Log.module("\(type(of: self)) - \(#function)")
//    }
//}
//
//extension ImageManager {
//    func downloadImage(_ url: URL, completition: ((Result<UIImage?>) -> ())?) {
//        pinRemoteImageManager.downloadImage(with: url) { (result) in
//            if let error = result.error {
//                Log.error("""
//                ImageManager downloadImage with url: \(url)
//                error: \(error.localizedDescription)
//                """)
//                
//                completition?(.failure([BaseAnonError(key: "error", value: error.localizedDescription)], nil))
//            } else if let image = result.image {
//                completition?(.success(image))
//            }
//        }
//    }
//    
//    func downloadImage(for imageView: UIImageView, url: URL, placeholder: UIImage? = nil, completition: ((Result<UIImage?>) -> ())?) {
//        imageView.pin_updateWithProgress = true
//        imageView.pin_setImage(from: url, placeholderImage: placeholder) { (result) in
//            if let error = result.error {
//                Log.error("""
//                    ImageManager downloadImage with url: \(url)
//                    error: \(error.localizedDescription)
//                    """)
//                
//                completition?(.failure([BaseAnonError(key: "error", value: error.localizedDescription)], nil))
//            } else if let image = result.image {
//                completition?(.success(image))
//            }
//        }
//    }
//}
//
//extension ImageManager {
//    func isCachedImage(for key: String) -> Bool {
//        return pinCache.containsObject(forKey: key)
//    }
//    
//    func setCachedImage(for key: String, image: UIImage?, completion: @escaping ((UIImage?, Bool) -> Void)) {
//        qImageManager.enqueue { [weak self] in
//            guard let self = self else { return }
//
//            guard let image = image else {
//                completion(nil, false)
//                return
//            }
//            
//            self.pinCache.setObjectAsync(image, forKey: key) { (cache, key, object) in
//                guard let image = object as? UIImage else {
//                    completion(nil, false)
//                    return
//                }
//                
//                completion(image, true)
//            }
//        }
//    }
//    
//    func getCachedImage(for key: String, completion: @escaping ((UIImage?, Bool) -> Void)) {
//        qImageManager.enqueue { [weak self] in
//            guard let self = self else { return }
//            
//            guard self.isCachedImage(for: key) else {
//                completion(nil, false)
//                return
//            }
//            
//            self.pinCache.object(forKeyAsync: key) { (cache, key, object) in
//                guard let image = object as? UIImage else {
//                    completion(nil, false)
//                    return
//                }
//                
//                completion(image, true)
//            }
//        }
//    }
//}
