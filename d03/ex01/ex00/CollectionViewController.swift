//
//  CollectionViewController.swift
//  ex00
//
//  Created by Kyri IOULIANOU on 2017/10/05.
//  Copyright © 2017 Kyri IOULIANOU. All rights reserved.
//

import UIKit

private let reuseIdentifier = "cell"

class CollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    let images:[String] = [
        "https://images-assets.nasa.gov/image/PIA21965/PIA21965~orig.jpg",
        "https://images-assets.nasa.gov/image/PIA22036/PIA22036~orig.jpg",
        "https://images-assets.nasa.gov/image/KSC-20170508-PH_SWW01_0025/KSC-20170508-PH_SWW01_0025~orig.JPG",
        "https://images-assets.nasa.gov/image/KSC-20170508-PH_SWW01_0004/KSC-20170508-PH_SWW01_0004~orig.JPG"
    ]

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return images.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! ImageCell
        
        cell.backgroundColor = UIColor.black
        let activityIndicator = UIActivityIndicatorView()
        cell.backgroundView = activityIndicator
        activityIndicator.startAnimating()
        let row = indexPath.row
        
        DispatchQueue.global().async {
            let url = URL(string: self.images[row])
            let data = try? Data(contentsOf: url!)
            
            DispatchQueue.main.async {
                if let imageData = data {
                    cell.imageView.image = UIImage(data: imageData)
                    activityIndicator.stopAnimating()
                }
            }
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width / 2 - 20, height: self.view.frame.width / 2)
    }


}
