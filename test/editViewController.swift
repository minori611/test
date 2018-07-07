//
//  editViewController.swift
//  test
//
//  Created by Minori on 2018/06/23.
//  Copyright © 2018年 Minori. All rights reserved.
//
//test
import UIKit
import Accounts

class editViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet var imageView: UIImageView!
    
    var originalImage: UIImage!
    var filter:CIFilter!
    var slider: Double = 0
    var brightness = 1.0
    var contrast = 1.0
    let userDefaults = UserDefaults.standard
    private var brightnessButton: UIButton!
    private var contrastButton: UIButton!
    private var doneButton: UIButton!
    private var cancelButton: UIButton!
    let brightnessSlider = UISlider(frame: CGRect(x:0, y:0, width:200, height:30))
    let contrastSlider = UISlider(frame: CGRect(x:0, y:0, width:200, height:30))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        openAlbum()
        addBrightnessButton()
        addContrastButton()
        addDoneButton()
        addBrightnessSlider()
        addCancelButton()
        self.view.addSubview(brightnessButton)
        self.view.addSubview(contrastButton)
        // Do any additional setup after loading the view.
    }
    
    //あるばむをひらく
    func openAlbum() {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let picker = UIImagePickerController()
            picker.sourceType = .photoLibrary
            picker.delegate = self
            picker.allowsEditing = true
            present(picker, animated: true, completion: nil)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo Info: [String : Any]) {
        imageView.image = Info[UIImagePickerControllerEditedImage] as? UIImage
        
        originalImage = imageView.image
        
        dismiss(animated: true, completion: nil)
    }
    
    //ぶらいとねすのぼたんをつくる
    func addBrightnessButton() {
        brightnessButton = UIButton()
        let bWidth: CGFloat = 200
        let bHeight: CGFloat = 50
        let posX: CGFloat = self.view.frame.width/5 - bWidth/2
        let posY: CGFloat = 19*(self.view.frame.height)/20 - bHeight/2
        brightnessButton.frame = CGRect(x: posX, y: posY, width: bWidth, height: bHeight)
        brightnessButton.setTitle("Brightness", for: .normal)
        brightnessButton.setTitleColor(UIColor.black, for: .normal)
        brightnessButton.addTarget(self, action: #selector(self.brightnessButton(sender:)), for: .touchUpInside)
    }
    
    //こんとらすとのぼたんをつくる
    func addContrastButton() {
        contrastButton = UIButton()
        let bWidth: CGFloat = 200
        let bHeight: CGFloat = 50
        let posX: CGFloat = 4*(self.view.frame.width)/5 - bWidth/2
        let posY: CGFloat = 19*(self.view.frame.height)/20 - bHeight/2
        contrastButton.frame = CGRect(x: posX, y: posY, width: bWidth, height: bHeight)
        contrastButton.setTitle("Contrast", for: .normal)
        contrastButton.setTitleColor(UIColor.black, for: .normal)
        contrastButton.addTarget(self, action: #selector(self.contrastButton(sender:)), for: .touchUpInside)
    }
    
    //doneぼたんをつくる
    func addDoneButton() {
        doneButton = UIButton()
        let bWidth: CGFloat = 200
        let bHeight: CGFloat = 50
        let posX: CGFloat = 4*(self.view.frame.width)/5 - bWidth/2
        let posY: CGFloat = 19*(self.view.frame.height)/20 - bHeight/2
        doneButton.frame = CGRect(x: posX, y: posY, width: bWidth, height: bHeight)
        doneButton.setTitle("Done", for: .normal)
        doneButton.setTitleColor(UIColor.black, for: .normal)
        doneButton.addTarget(self, action: #selector(self.removeSlider(sender:)), for: .touchUpInside)
    }
    
    //cancelぼたんをつくる
    func addCancelButton() {
        cancelButton = UIButton()
        let bWidth: CGFloat = 200
        let bHeight: CGFloat = 50
        let posX: CGFloat = self.view.frame.width/5 - bWidth/2
        let posY: CGFloat = 19*(self.view.frame.height)/20 - bHeight/2
        cancelButton.frame = CGRect(x: posX, y: posY, width: bWidth, height: bHeight)
        cancelButton.setTitle("Cancel", for: .normal)
        cancelButton.setTitleColor(UIColor.black, for: .normal)
        cancelButton.addTarget(self, action: #selector(self.removeSlider(sender:)), for: .touchUpInside)
    }
    
    //ぶらいとねすのすらいだーをつくる
    func addBrightnessSlider() {
        brightnessSlider.layer.position = CGPoint(x:self.view.frame.midX, y:600)
        brightnessSlider.layer.cornerRadius = 10.0
        brightnessSlider.layer.shadowOpacity = 0.5
        brightnessSlider.layer.masksToBounds = false
        brightnessSlider.tintColor = UIColor.gray
        brightnessSlider.minimumValue = 0
        brightnessSlider.maximumValue = 1
        brightnessSlider.setValue(0.0, animated: true)
        brightnessSlider.addTarget(self, action: #selector(self.changeBrightness(sender:)), for: .valueChanged)
    }
    
    //こんとらすとのすらいだーをつくる
    func addContrastSlider() {
        contrastSlider.layer.position = CGPoint(x:self.view.frame.midX, y:600)
        contrastSlider.layer.cornerRadius = 10.0
        contrastSlider.layer.shadowOpacity = 0.5
        contrastSlider.layer.masksToBounds = false
        contrastSlider.tintColor = UIColor.gray
        contrastSlider.minimumValue = 0
        contrastSlider.maximumValue = 1
        contrastSlider.setValue(0.0, animated: true)
        contrastSlider.addTarget(self, action: #selector(self.changeContrast(sender:)), for: .valueChanged)
    }
    
    //ぶらいとねすのすらいだーをけす
    @objc func removeSlider(sender: UIButton) {
        brightnessSlider.removeFromSuperview()
        contrastSlider.removeFromSuperview()
        doneButton.removeFromSuperview()
        cancelButton.removeFromSuperview()
        self.view.addSubview(brightnessButton)
        self.view.addSubview(contrastButton)
    }
    
    //ぼたんけす
    func removeButtons() {
        contrastButton.removeFromSuperview()
        brightnessButton.removeFromSuperview()
        self.view.addSubview(doneButton)
        self.view.addSubview(cancelButton)
    }
    
    //ぶらいとねすの値を変える
    @objc func changeBrightness(sender: UISlider) {
        brightness = Double(slider)
        print(brightness)
        userDefaults.set(brightness, forKey: "brightness")
        userDefaults.synchronize()
        changeFilter()
    }
    
    //こんとらすとの値を変える
    @objc func changeContrast(sender: UISlider) {
        contrast = Double(slider)
        userDefaults.set(contrast, forKey: "contrast")
        userDefaults.synchronize()
        changeFilter()
    }
    
    @objc func brightnessButton(sender: UIButton) {
        self.view.addSubview(brightnessSlider)
        removeButtons()
    }
    
    @objc func contrastButton(sender: UIButton) {
        self.view.addSubview(contrastSlider)
        removeButtons()
    }
    //ふぃるたー変える
    func changeFilter() {
        let filterImage: CIImage = CIImage(image: originalImage)!
        
        //filter
        filter = CIFilter(name: "CIColorControls")!
        filter.setValue(filterImage, forKey: kCIInputImageKey)
        
        //brightness
        filter.setValue(brightness, forKey: "inputBrightness")
        
        //contrast
        filter.setValue(contrast, forKey: "inputContrast")
        
        
        let ctx = CIContext(options: nil)
        let cgImage = ctx.createCGImage(filter.outputImage!, from: filter.outputImage!.extent)
        imageView.image = UIImage(cgImage: cgImage!)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
