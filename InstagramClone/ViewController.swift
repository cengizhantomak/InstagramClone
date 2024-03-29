//
//  ViewController.swift
//  InstagramClone
//
//  Created by Cengizhan Tomak on 18.05.2023.
//

import UIKit
import FirebaseAuth
import JGProgressHUD
import FirebaseStorage
import FirebaseFirestore

class ViewController: UIViewController {
    
    let btnFotografEkle: UIButton = {
        
        let btn = UIButton(type: .system)
        btn.setImage(UIImage(named: "Fotograf_Sec")?.withRenderingMode(.alwaysOriginal), for: .normal)
        
        btn.addTarget(self, action: #selector(btnFotografEklePressed), for: .touchUpInside)
        
        return btn
    }()
    
    @objc fileprivate func btnFotografEklePressed() {
        let imgPickerController = UIImagePickerController()
        imgPickerController.delegate = self
        present(imgPickerController, animated: true, completion: nil)
    }
    
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
        
        let hud = JGProgressHUD(style: .light)
        hud.textLabel.text = "Kaydınız Gerçekleşiyor"
        hud.show(in: self.view)
        
        Auth.auth().createUser(withEmail: emailAdresi, password: parola) { sonuc, hata in
            if let hata = hata {
                print("Kullanıcı kayıt olurken hata meydana geldi: ", hata)
                hud.dismiss(animated: true)
                return
            }
            
            guard let kaydolanKullaniciID = sonuc?.user.uid else { return }
            
            let goruntuAdi = UUID().uuidString
            let ref = Storage.storage().reference(withPath: "/ProfilFotograflari/\(goruntuAdi)")
            let goruntuData = self.btnFotografEkle.imageView?.image?.jpegData(compressionQuality: 0.8)
            
            ref.putData(goruntuData!, metadata: nil) { _, hata in
                if let hata = hata {
                    print("Fotoğraf Kaydedilemedi: ", hata)
                    return
                }
                print("Görüntü başarıyla Upload Edildi")
                
                ref.downloadURL { url, hata in
                    if let hata = hata {
                        print("Görüntünün URL Adresi Alınamadı: ", hata)
                        return
                    }
                    print("Upload edilen görüntünün URL Adresi: \(url?.absoluteString ?? "Link Yok")")
                    
                    let eklenecekVeri = ["KullaniciAdi" : kullaniciAdi,
                                         "KullaniciID" : kaydolanKullaniciID,
                                         "ProfilGoruntuURL" : url?.absoluteString ?? ""]
                    
                    Firestore.firestore().collection("Kullanicilar").document(kaydolanKullaniciID).setData(eklenecekVeri) { hata in
                        if let hata = hata {
                            print("Kullanıcı verileri firestore'a kaydedilemedi: ",hata)
                            return
                        }
                        print("Kullanıcı verileri başarıyla kaydedildi")
                        
                        hud.dismiss(animated: true)
                        self.gorunumuDuzelt()
                    }
                }
            }
            print("Kullanıcı kaydı başarıyla gerçekleşti: ", sonuc?.user.uid)
        }
    }
    
    fileprivate func gorunumuDuzelt() {
        self.btnFotografEkle.setImage(UIImage(named: "Fotograf_Sec"), for: .normal)
        self.btnFotografEkle.layer.borderColor = UIColor.clear.cgColor
        self.btnFotografEkle.layer.borderWidth = 0
        self.txtEmail.text = ""
        self.txtKullaniciAdi.text = ""
        self.txtParola.text = ""
        let basariliHud = JGProgressHUD(style: .light)
        basariliHud.textLabel.text = "Kayıt İşlemi Başarılı..."
        basariliHud.show(in: self.view)
        basariliHud.dismiss(afterDelay: 2)
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

extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let imgSecilen = info[.originalImage] as? UIImage
        self.btnFotografEkle.setImage(imgSecilen?.withRenderingMode(.alwaysOriginal), for: .normal)
        btnFotografEkle.layer.cornerRadius = btnFotografEkle.frame.width / 2
        btnFotografEkle.layer.masksToBounds = true
        btnFotografEkle.layer.borderColor = UIColor.darkGray.cgColor
        btnFotografEkle.layer.borderWidth = 3
        dismiss(animated: true, completion: nil)
    }
}

