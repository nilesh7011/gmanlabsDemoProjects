//
//  ErrorHandlingViewController.swift
//  gmanlabsDemoProjects
//
//  Created by m8nilesh on 31/05/24.
//

import UIKit
import SwiftUI

class ErrorHandlingViewController: UIViewController {
    
    
    @IBOutlet weak var mainview: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //MARK: - Swift to SwiftUI view
        
        let vc = UIHostingController(rootView: ContentView2())
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
    
    
}
