//
//  ViewController.swift
//  InstagramClone
//
//  Created by Cengizhan Tomak on 18.05.2023.
//

import UIKit
import FirebaseAuth

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
        
        txt.addTarget(self, action: #selector(veriDegisimi), for: .editingChanged)
        
        return txt
    }()
    
    @objc fileprivate func veriDegisimi() {
        let formGecerlimi = (txtEmail.text?.count ?? 0) > 0 &&
        (txtKullaniciAdi.text?.count ?? 0) > 0 &&
        (txtParola.text?.count ?? 0) > 0
        
        if formGecerlimi {
            btnKayitOl.backgroundColor = UIColor.rgbDonustur(red: 20, green: 155, blue: 235)
            btnKayitOl.isEnabled = true
        } else {
            btnKayitOl.backgroundColor = UIColor.rgbDonustur(red: 150, green: 205, blue: 245)
            btnKayitOl.isEnabled = false
        }
    }
    
    let txtKullaniciAdi: UITextField = {
        
        let txt = UITextField()
        txt.backgroundColor = UIColor(white: 0, alpha: 0.05)
        txt.placeholder = "Kullanıcı Adınız..."
        txt.borderStyle = .roundedRect
        txt.font = UIFont.systemFont(ofSize: 16)
        
        txt.addTarget(self, action: #selector(veriDegisimi), for: .editingChanged)
        
        return txt
    }()
    
    let txtParola: UITextField = {
        
        let txt = UITextField()
        txt.backgroundColor = UIColor(white: 0, alpha: 0.05)
        txt.placeholder = "Parolanız..."
        txt.isSecureTextEntry = true
        txt.borderStyle = .roundedRect
        txt.font = UIFont.systemFont(ofSize: 16)
        
        txt.addTarget(self, action: #selector(veriDegisimi), for: .editingChanged)
        
        return txt
    }()
    
    let btnKayitOl: UIButton = {
       
        let btn = UIButton(type: .system)
        btn.setTitle("Kayıt Ol", for: .normal)
        btn.backgroundColor = UIColor.rgbDonustur(red: 150, green: 205, blue: 245)
        btn.layer.cornerRadius = 6
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        btn.setTitleColor(.white, for: .normal)
        
        btn.addTarget(self, action: #selector(btnKayitOlPressed), for: .touchUpInside)
        btn.isEnabled = false
        
        return btn
    }()
    
    @objc fileprivate func btnKayitOlPressed() {
        
        guard let emailAdresi = txtEmail.text else { return }
        guard let kullaniciAdi = txtKullaniciAdi.text else { return }
        guard let parola = txtParola.text else { return }
        
        Auth.auth().createUser(withEmail: emailAdresi, password: parola) { sonuc, hata in
            if let hata = hata {
                print("Kullanıcı kayıt olurken hata meydana geldi: ", hata)
                return
            }
            print("Kullanıcı kaydı başarıyla gerçekleşti: ", sonuc?.user.uid)
            self.txtEmail.text = ""
            self.txtKullaniciAdi.text = ""
            self.txtParola.text = ""
        }
    }

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

