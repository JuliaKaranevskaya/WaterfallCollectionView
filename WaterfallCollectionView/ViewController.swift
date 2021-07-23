//
//  ViewController.swift
//  WaterfallCollectionView
//
//  Created by Юлия Караневская on 23.07.21.
//

import UIKit
import CHTCollectionViewWaterfallLayout

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, CHTCollectionViewDelegateWaterfallLayout {

    let collectionView: UICollectionView = {
        let layout = CHTCollectionViewWaterfallLayout()
        layout.itemRenderDirection = .leftToRight
        layout.columnCount = 2
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.register(UICollectionViewCell.self, forCellWithReuseIdentifier: ImageCollectionViewCell.identifier)
        return cv
    }()
    
    struct Model {
        let imageName: String
        let height: CGFloat
    }
    
    private var models = [Model]()

    override func viewDidLoad() {
        super.viewDidLoad()
        let images = Array(1...10).map {"images\($0)"}
        models = images.compactMap {
            return Model.init(imageName: $0, height: CGFloat.random(in: 300...600))
        }
        view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
       
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.frame = view.bounds
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return models.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCollectionViewCell.identifier, for: indexPath) as? ImageCollectionViewCell else {
            fatalError()
        }
        cell.configure(with: UIImage(named: models[indexPath.item].imageName))
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: view.frame.size.width / 2, height: models[indexPath.item].height)
    }
    


}

