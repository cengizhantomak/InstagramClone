//
//  AnaTabBarController.swift
//  InstagramClone
//
//  Created by Cengizhan Tomak on 19.05.2023.
//

import Foundation
import UIKit

class AnaTabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let layout = UICollectionViewFlowLayout()
        let kullaniciProfilController = KullaniciProfilController(collectionViewLayout: layout)
        let navController = UINavigationController(rootViewController: kullaniciProfilController)
        navController.tabBarItem.image = UIImage(named: "Profil")
        navController.tabBarItem.selectedImage = UIImage(named: "Profil_Secili")
        tabBar.tintColor = .black
        viewControllers = [navController, UIViewController()]
    }
}
