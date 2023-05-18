//
//  ViewController.swift
//  InstagramClone
//
//  Created by Cengizhan Tomak on 18.05.2023.
//

import UIKit

class ViewController: UIViewController {
    
    let btnFotografEkle: UIButton = {
        
        let btn = UIButton(type: .system)
        btn.setImage(UIImage(named: "Fotograf_Sec")?.withRenderingMode(.alwaysOriginal), for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        
        return btn
    }()
    
    let txtEmail: UITextField = {
        
        let txt = UITextField()
        txt.backgroundColor = UIColor(white: 0, alpha: 0.05)
        txt.placeholder = "Email adresinizi giriniz..."
        txt.translatesAutoresizingMaskIntoConstraints = false
        txt.borderStyle = .roundedRect
        txt.font = UIFont.systemFont(ofSize: 16)
        
        return txt
    }()
    
    let txtKullaniciAdi: UITextField = {
        
        let txt = UITextField()
        txt.backgroundColor = UIColor(white: 0, alpha: 0.05)
        txt.placeholder = "Kullanıcı Adınız..."
        txt.translatesAutoresizingMaskIntoConstraints = false
        txt.borderStyle = .roundedRect
        txt.font = UIFont.systemFont(ofSize: 16)
        
        return txt
    }()
    
    let txtParola: UITextField = {
        
        let txt = UITextField()
        txt.backgroundColor = UIColor(white: 0, alpha: 0.05)
        txt.placeholder = "Parolanız..."
        txt.isSecureTextEntry = true
        txt.translatesAutoresizingMaskIntoConstraints = false
        txt.borderStyle = .roundedRect
        txt.font = UIFont.systemFont(ofSize: 16)
        
        return txt
    }()
    
    let btnKayitOl: UIButton = {
       
        let btn = UIButton(type: .system)
        btn.setTitle("Kayıt Ol", for: .normal)
        btn.backgroundColor = UIColor(red: 150/255, green: 205/255, blue: 245/255, alpha: 1)
        btn.layer.cornerRadius = 6
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        btn.setTitleColor(.white, for: .normal)
        
        return btn
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(btnFotografEkle)
        
        btnFotografEkle.widthAnchor.constraint(equalToConstant: 150).isActive = true
        btnFotografEkle.heightAnchor.constraint(equalToConstant: 150).isActive = true
        btnFotografEkle.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        btnFotografEkle.topAnchor.constraint(equalTo: view.topAnchor, constant: 80).isActive = true
        
        girisAlanlariniOlustur()
    }
    
    fileprivate func girisAlanlariniOlustur() {
        
        let stackView = UIStackView(arrangedSubviews: [txtEmail, txtKullaniciAdi, txtParola, btnKayitOl])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fillEqually
        stackView.axis = .vertical
        stackView.spacing = 10
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: btnFotografEkle.bottomAnchor, constant: 20),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 45),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -45),
            stackView.heightAnchor.constraint(equalToConstant: 230)
        ])
    }
}

