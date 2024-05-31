//
//  AnimationViewController.swift
//  gmanlabsDemoProjects
//
//  Created by m8nilesh on 31/05/24.
//

import UIKit
import SwiftUI

class AnimationViewController: UIViewController {
    
    @IBOutlet weak var mainview: UIView!
    
    @IBOutlet weak var nxtpage: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nxtpage.layer.borderColor = UIColor(red: 224/255.0, green: 233/255.0, blue: 255/255.0, alpha: 1.0).cgColor
        nxtpage.layer.borderWidth = 1
        nxtpage.layer.cornerRadius = 15
        
        
        //MARK: - Swift to SwiftUI view
        
        let vc = UIHostingController(rootView: ContentView1())
        let swiftuiView = vc.view!
        swiftuiView.translatesAutoresizingMaskIntoConstraints = false
        self.addChild(vc)
        self.mainview.addSubview(swiftuiView)
        NSLayoutConstraint.activate([
            swiftuiView.leadingAnchor.constraint(equalTo: self.mainview.leadingAnchor),
            swiftuiView.trailingAnchor.constraint(equalTo: self.mainview.trailingAnchor),
            swiftuiView.topAnchor.constraint(equalTo: self.mainview.topAnchor),
            swiftuiView.bottomAnchor.constraint(equalTo: self.mainview.bottomAnchor)
        ])
        vc.didMove(toParent: self)
    }
    
    @IBAction func back(_ sender: Any) {
        
        
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func nxtpage(_ sender: Any) {
        
        let viewC = (self.storyboard?.instantiateViewController(withIdentifier: "ErrorHandlingViewController")) as! ErrorHandlingViewController
        self.navigationController?.pushViewController(viewC, animated: true)
    }
    
    
}
