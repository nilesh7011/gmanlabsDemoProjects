//
//  Table&CollectionviewViewController.swift
//  gmanlabsDemoProjects
//
//  Created by m8nilesh on 31/05/24.
//

import UIKit

class dummycollectionview: UICollectionViewCell{
    
    @IBOutlet weak var mainview: UIView!
    
    @IBOutlet weak var steps: UILabel!
    
    @IBOutlet weak var distance: UILabel!
    
    @IBOutlet weak var heart: UILabel!
    
}

class dummytableview:UITableViewCell{
    
    @IBOutlet weak var steps: UILabel!
    
    @IBOutlet weak var distance: UILabel!
    
    @IBOutlet weak var heart: UILabel!
    
    @IBOutlet weak var mainview: UIView!
    
}

class Table_CollectionviewViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource {
    
    @IBOutlet weak var nxtbtn: UIButton!
    
    
    var steps = ["7000","7000"]
    var distance = ["7000","7000"]
    var heart = ["80","80"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nxtbtn.layer.borderColor = UIColor(red: 224/255.0, green: 233/255.0, blue: 255/255.0, alpha: 1.0).cgColor
        nxtbtn.layer.borderWidth = 1
        nxtbtn.layer.cornerRadius = 15
    }
    
    
    @IBAction func nxt(_ sender: Any) {
        
        
        let viewC = (self.storyboard?.instantiateViewController(withIdentifier: "AnimationViewController")) as! AnimationViewController
        self.navigationController?.pushViewController(viewC, animated: true)
        
    }
    
    
}

extension Table_CollectionviewViewController  {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return steps.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "dummytableview", for: indexPath) as! dummytableview
        cell.steps.text = steps[indexPath.row]
        cell.distance.text = distance[indexPath.row]
        cell.heart.text = heart[indexPath.row]
        cell.mainview.layer.masksToBounds = true
        cell.mainview.layer.cornerRadius = 15
        
        return cell
    }
    
}

extension Table_CollectionviewViewController {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return steps.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "dummycollectionview", for: indexPath) as! dummycollectionview
        cell.steps.text = steps[indexPath.row]
        cell.distance.text = distance[indexPath.row]
        cell.heart.text = heart[indexPath.row]
        //        cell.mainview.layer.masksToBounds = true
        //        cell.mainview.layer.cornerRadius = 15
        
        cell.mainview.layer.cornerRadius = 20.0
        cell.mainview.layer.shadowColor = UIColor.gray.cgColor
        cell.mainview.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        cell.mainview.layer.shadowRadius = 12.0
        cell.mainview.layer.shadowOpacity = 0.2
        return cell
    }
}
