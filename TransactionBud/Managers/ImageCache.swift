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

    func retrieveImage(withUrl urlString: String, tag _: String, complete: @escaping (_ image: UIImage) -> Void) {
        // TODO: Handle errors + persist cache
        guard let url = URL(string: urlString) else { return }

        if let image = imageCache.object(forKey: urlString as NSString) {
            complete(image)
            return
        }

        let task = URLSession.shared.dataTask(with: url) { data, _, error in

            if let _ = error {
                complete(Images.transactionPlaceHolder!)
                return
            }

            if let image = UIImage(data: data!) {
                self.imageCache.setObject(image, forKey: urlString as NSString)
                complete(image)
            }
        }
        task.resume()
    }
}
