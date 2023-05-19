//
//  KullaniciProfilController.swift
//  InstagramClone
//
//  Created by Cengizhan Tomak on 19.05.2023.
//

import Foundation
import UIKit
import FirebaseAuth
import FirebaseFirestore

class KullaniciProfilController: UICollectionViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .white
        kullaniciyiGetir()
    }
    
    fileprivate func kullaniciyiGetir() {
        
        guard let gecerliKullaniciID = Auth.auth().currentUser?.uid else { return }
        
        Firestore.firestore().collection("Kullanicilar").document(gecerliKullaniciID).getDocument { snapshot, hata in
            if let hata = hata {
                print("Kullanıcı Bilgileri Getirilemedi: ", hata)
                return
            }
            
            guard let kullaniciVerisi = snapshot?.data() else { return }
            let kullaniciAdi = kullaniciVerisi["KullaniciAdi "] as? String
            self.navigationItem.title = kullaniciAdi
            print("KullanıcıID: ", gecerliKullaniciID)
            print("Kullanıcı Adı: ",kullaniciAdi ?? "")
        }
    }
}
