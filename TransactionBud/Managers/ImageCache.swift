//
//  ImageNetworking.swift
//  TransactionBud
//
//  Created by George Cremer on 18/04/2021.
//

import UIKit

struct ImageCache {
    static let shared = ImageCache()
    var imageCache = NSCache<NSString, UIImage>()

    func retrieveImage(withUrl urlString: String, tag: String, complete: @escaping (_ image: UIImage) -> Void) {
        // TODO: Handle errors + move to separate object
        guard let url = URL(string: urlString) else { return }

        if let image = imageCache.object(forKey: urlString as NSString) {
            print("already cached image price: \(tag) ")
            complete(image)
            return
        }

        let task = URLSession.shared.dataTask(with: url) { data, _, error in

            if let _ = error {
                print("error caching image price: \(tag) ")
                complete(Images.transactionPlaceHolder!)
                return
            }

            if let image = UIImage(data: data!) {
                self.imageCache.setObject(image, forKey: urlString as NSString)
                print("successfully cached image price: \(tag), forKey: \(urlString)")
                complete(image)
            }
        }
        task.resume()
    }
}
