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
        
        return btn
    }()
    
    let txtEmail: UITextField = {
        
        let txt = UITextField()
        txt.backgroundColor = UIColor(white: 0, alpha: 0.05)
        txt.placeholder = "Email adresinizi giriniz..."
        txt.borderStyle = .roundedRect
        txt.font = UIFont.systemFont(ofSize: 16)
        
        return txt
    }()
    
    let txtKullaniciAdi: UITextField = {
        
        let txt = UITextField()
        txt.backgroundColor = UIColor(white: 0, alpha: 0.05)
        txt.placeholder = "Kullanıcı Adınız..."
        txt.borderStyle = .roundedRect
        txt.font = UIFont.systemFont(ofSize: 16)
        
        return txt
    }()
    
    let txtParola: UITextField = {
        
        let txt = UITextField()
        txt.backgroundColor = UIColor(white: 0, alpha: 0.05)
        txt.placeholder = "Parolanız..."
        txt.isSecureTextEntry = true
        txt.borderStyle = .roundedRect
        txt.font = UIFont.systemFont(ofSize: 16)
        
        return txt
    }()
    
    let btnKayitOl: UIButton = {
       
        let btn = UIButton(type: .system)
        btn.setTitle("Kayıt Ol", for: .normal)
        btn.backgroundColor = UIColor.rgbDonustur(red: 150, green: 205, blue: 245)
        btn.layer.cornerRadius = 6
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        btn.setTitleColor(.white, for: .normal)
        
        return btn
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(btnFotografEkle)
        
        btnFotografEkle.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                               bottom: nil,
                               leading: nil,
                               trailing: nil,
                               paddingTop: 40,
                               paddingBottom: 0,
                               paddingLeft: 0,
                               paddingRight: 0,
                               width: 150,
                               height: 150)
        
        btnFotografEkle.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        girisAlanlariniOlustur()
    }
    
    fileprivate func girisAlanlariniOlustur() {
        
        let stackView = UIStackView(arrangedSubviews: [txtEmail, txtKullaniciAdi, txtParola, btnKayitOl])
        stackView.distribution = .fillEqually
        stackView.axis = .vertical
        stackView.spacing = 10
        view.addSubview(stackView)
        
        stackView.anchor(top: btnFotografEkle.bottomAnchor,
                         bottom: nil,
                         leading: view.leadingAnchor,
                         trailing: view.trailingAnchor,
                         paddingTop: 20,
                         paddingBottom: 0,
                         paddingLeft: 45,
                         paddingRight: -45,
                         width: 0,
                         height: 230)
    }
}

extension UIView {
    
    func anchor(top: NSLayoutYAxisAnchor?,
                bottom: NSLayoutYAxisAnchor?,
                leading: NSLayoutXAxisAnchor?,
                trailing: NSLayoutXAxisAnchor?,
                paddingTop: CGFloat,
                paddingBottom: CGFloat,
                paddingLeft: CGFloat,
                paddingRight: CGFloat,
                width: CGFloat,
                height: CGFloat) {
        
        translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top {
            self.topAnchor.constraint(equalTo: top, constant: paddingTop).isActive = true
        }
        
        if let bottom = bottom {
            self.bottomAnchor.constraint(equalTo: bottom, constant: paddingBottom).isActive = true
        }
        
        if let leading = leading {
            self.leadingAnchor.constraint(equalTo: leading, constant: paddingLeft).isActive = true
        }
        
        if let trailing = trailing {
            self.trailingAnchor.constraint(equalTo: trailing, constant: paddingRight).isActive = true
        }
        
        if width != 0 {
            widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        
        if height != 0 {
            heightAnchor.constraint(equalToConstant: height).isActive = true
        }
    }
}

