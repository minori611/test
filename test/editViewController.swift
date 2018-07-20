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
    var brightness: Float = 0.0
    var contrast: Float = 1.0
    var saturation: Float = 1.0
    let userDefaults = UserDefaults.standard
    private var brightnessButton: UIButton!
    private var contrastButton: UIButton!
    private var saturationButton: UIButton!
    private var doneButton: UIButton!
    private var contrastCancelButton: UIButton!
    private var brightnessCancelButton: UIButton!
    private var saturationCancelButton: UIButton!
    let brightnessSlider = UISlider(frame: CGRect(x:0, y:0, width:200, height:30))
    let contrastSlider = UISlider(frame: CGRect(x:0, y:0, width:200, height:30))
    let saturationSlider = UISlider(frame: CGRect(x:0, y:0, width:200, height:30))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        openAlbum()
        addBrightnessButton()
        addContrastButton()
        addSaturationButton()
        addDoneButton()
        addBrightnessSlider()
        addContrastSlider()
        addSaturationSlider()
        addBrightnessCancelButton()
        addContrastCancelButton()
        addSaturationCancelButton()
        self.view.addSubview(brightnessButton)
        self.view.addSubview(contrastButton)
        self.view.addSubview(saturationButton)
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
        let bWidth: CGFloat = 100
        let bHeight: CGFloat = 30
        let posX: CGFloat = self.view.frame.width/5 - bWidth/2
        let posY: CGFloat = 19*(self.view.frame.height)/20 - bHeight/2
        brightnessButton.frame = CGRect(x: posX, y: posY, width: bWidth, height: bHeight)
        brightnessButton.setTitle("Brightness", for: .normal)
        brightnessButton.setTitleColor(UIColor.black, for: .normal)
        brightnessButton.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        brightnessButton.addTarget(self, action: #selector(self.brightnessButton(sender:)), for: .touchUpInside)
    }
    
    //こんとらすとのぼたんをつくる
    func addContrastButton() {
        contrastButton = UIButton()
        let bWidth: CGFloat = 100
        let bHeight: CGFloat = 30
        let posX: CGFloat = 4*(self.view.frame.width)/5 - bWidth/2
        let posY: CGFloat = 19*(self.view.frame.height)/20 - bHeight/2
        contrastButton.frame = CGRect(x: posX, y: posY, width: bWidth, height: bHeight)
        contrastButton.setTitle("Contrast", for: .normal)
        contrastButton.setTitleColor(UIColor.black, for: .normal)
        contrastButton.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        contrastButton.addTarget(self, action: #selector(self.contrastButton(sender:)), for: .touchUpInside)
    }
    
    //彩度のぼたんをつくる
    func addSaturationButton() {
        saturationButton = UIButton()
        let bWidth: CGFloat = 100
        let bHeight: CGFloat = 30
        let posX: CGFloat = 2.5*(self.view.frame.width)/5 - bWidth/2
        let posY: CGFloat = 19*(self.view.frame.height)/20 - bHeight/2
        saturationButton.frame = CGRect(x: posX, y: posY, width: bWidth, height: bHeight)
        saturationButton.setTitle("Saturation", for: .normal)
        saturationButton.setTitleColor(UIColor.black, for: .normal)
        saturationButton.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        saturationButton.addTarget(self, action: #selector(self.saturationButton(sender:)), for: .touchUpInside)
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
    
    //brightnessのcancel
    func addBrightnessCancelButton() {
        brightnessCancelButton = UIButton()
        let bWidth: CGFloat = 200
        let bHeight: CGFloat = 50
        let posX: CGFloat = self.view.frame.width/5 - bWidth/2
        let posY: CGFloat = 19*(self.view.frame.height)/20 - bHeight/2
        brightnessCancelButton.frame = CGRect(x: posX, y: posY, width: bWidth, height: bHeight)
        brightnessCancelButton.setTitle("Cancel", for: .normal)
        brightnessCancelButton.setTitleColor(UIColor.black, for: .normal)
        brightnessCancelButton.addTarget(self, action: #selector(self.brightnessCanceled(sender:)), for: .touchUpInside)
    }
    
    //contrastのcancel
    func addContrastCancelButton() {
        contrastCancelButton = UIButton()
        let bWidth: CGFloat = 200
        let bHeight: CGFloat = 50
        let posX: CGFloat = self.view.frame.width/5 - bWidth/2
        let posY: CGFloat = 19*(self.view.frame.height)/20 - bHeight/2
        contrastCancelButton.frame = CGRect(x: posX, y: posY, width: bWidth, height: bHeight)
        contrastCancelButton.setTitle("Cancel", for: .normal)
        contrastCancelButton.setTitleColor(UIColor.black, for: .normal)
        contrastCancelButton.addTarget(self, action: #selector(self.contrastCanceled(sender:)), for: .touchUpInside)
    }
    
    //saturationのcancel
    func addSaturationCancelButton() {
        saturationCancelButton = UIButton()
        let bWidth: CGFloat = 200
        let bHeight: CGFloat = 50
        let posX: CGFloat = self.view.frame.width/5 - bWidth/2
        let posY: CGFloat = 19*(self.view.frame.height)/20 - bHeight/2
        saturationCancelButton.frame = CGRect(x: posX, y: posY, width: bWidth, height: bHeight)
        saturationCancelButton.setTitle("Cancel", for: .normal)
        saturationCancelButton.setTitleColor(UIColor.black, for: .normal)
        saturationCancelButton.addTarget(self, action: #selector(self.saturationCanceled(sender:)), for: .touchUpInside)
    }
    
    //ぶらいとねすのすらいだーをつくる
    func addBrightnessSlider() {
        brightnessSlider.layer.position = CGPoint(x:self.view.frame.midX, y:600)
        brightnessSlider.layer.cornerRadius = 10.0
        brightnessSlider.layer.shadowOpacity = 0.5
        brightnessSlider.layer.masksToBounds = false
        brightnessSlider.tintColor = UIColor.gray
        brightnessSlider.minimumValue = -1
        brightnessSlider.maximumValue = 1
        brightnessSlider.setValue(brightness, animated: true)
        brightnessSlider.addTarget(self, action: #selector(self.changeBrightness(sender:)), for: .valueChanged)
    }
    
    //こんとらすとのすらいだーをつくる
    func addContrastSlider() {
        contrastSlider.layer.position = CGPoint(x:self.view.frame.midX, y:600)
        contrastSlider.layer.cornerRadius = 20.0
        contrastSlider.layer.shadowOpacity = 0.5
        contrastSlider.layer.masksToBounds = false
        contrastSlider.tintColor = UIColor.gray
        contrastSlider.minimumValue = 0
        contrastSlider.maximumValue = 2
        contrastSlider.setValue(contrast, animated: true)
        contrastSlider.addTarget(self, action: #selector(self.changeContrast(sender:)), for: .valueChanged)
    }
    
    //こんとらすとのすらいだーをつくる
    func addSaturationSlider() {
        saturationSlider.layer.position = CGPoint(x:self.view.frame.midX, y:600)
        saturationSlider.layer.cornerRadius = 20.0
        saturationSlider.layer.shadowOpacity = 0.5
        saturationSlider.layer.masksToBounds = false
        saturationSlider.tintColor = UIColor.gray
        saturationSlider.minimumValue = 0
        saturationSlider.maximumValue = 2
        saturationSlider.setValue(contrast, animated: true)
        saturationSlider.addTarget(self, action: #selector(self.changeSaturation(sender:)), for: .valueChanged)
    }
    
    //ぶらいとねすのすらいだーをけす
    @objc func removeSlider(sender: UIButton) {
        brightnessSlider.removeFromSuperview()
        contrastSlider.removeFromSuperview()
        saturationSlider.removeFromSuperview()
        doneButton.removeFromSuperview()
        brightnessCancelButton.removeFromSuperview()
        contrastCancelButton.removeFromSuperview()
        saturationCancelButton.removeFromSuperview()
        self.view.addSubview(brightnessButton)
        self.view.addSubview(contrastButton)
        self.view.addSubview(saturationButton)
    }
    
    //brightnessがcancelされた時
    @objc func brightnessCanceled(sender: UIButton) {
        brightnessSlider.removeFromSuperview()
        doneButton.removeFromSuperview()
        brightnessCancelButton.removeFromSuperview()
        self.view.addSubview(brightnessButton)
        self.view.addSubview(contrastButton)
        self.view.addSubview(saturationButton)
        brightness = 0.0
        userDefaults.set(brightness, forKey: "brightness")
        userDefaults.synchronize()
        changeFilter()
    }
    
    //contrastがcancelされた時
    @objc func contrastCanceled(sender: UIButton) {
        contrastSlider.removeFromSuperview()
        doneButton.removeFromSuperview()
        contrastCancelButton.removeFromSuperview()
        self.view.addSubview(brightnessButton)
        self.view.addSubview(contrastButton)
        self.view.addSubview(saturationButton)
        contrast = 1.0
        userDefaults.set(contrast, forKey: "contrast")
        userDefaults.synchronize()
        changeFilter()
    }
    
    //saturationtがcancelされた時
    @objc func saturationCanceled(sender: UIButton) {
        saturationSlider.removeFromSuperview()
        doneButton.removeFromSuperview()
        saturationCancelButton.removeFromSuperview()
        self.view.addSubview(brightnessButton)
        self.view.addSubview(contrastButton)
        self.view.addSubview(saturationButton)
        saturation = 1.0
        userDefaults.set(saturation, forKey: "saturation")
        userDefaults.synchronize()
        changeFilter()
    }
    
    //ぼたんけす
    func removeButtons() {
        contrastButton.removeFromSuperview()
        brightnessButton.removeFromSuperview()
        saturationButton.removeFromSuperview()
        self.view.addSubview(doneButton)
    }
    
    //ぶらいとねすの値を変える
    @objc func changeBrightness(sender: UISlider) {
        brightness = sender.value
        userDefaults.set(brightness, forKey: "brightness")
        userDefaults.synchronize()
        changeFilter()
    }
    
    //こんとらすとの値を変える
    @objc func changeContrast(sender: UISlider) {
        contrast = sender.value
        userDefaults.set(contrast, forKey: "contrast")
        userDefaults.synchronize()
        changeFilter()
    }
    
    //saturationの値を変える
    @objc func changeSaturation(sender: UISlider) {
        saturation = sender.value
        userDefaults.set(saturation, forKey: "saturation")
        userDefaults.synchronize()
        changeFilter()
    }
    
    @objc func brightnessButton(sender: UIButton) {
        self.view.addSubview(brightnessSlider)
        self.view.addSubview(brightnessCancelButton)
        brightnessSlider.setValue(brightness, animated: true)
        removeButtons()
    }
    
    @objc func contrastButton(sender: UIButton) {
        self.view.addSubview(contrastSlider)
        self.view.addSubview(contrastCancelButton)
        contrastSlider.setValue(contrast, animated: true)
        removeButtons()
    }
    
    @objc func saturationButton(sender: UIButton) {
        self.view.addSubview(saturationSlider)
        self.view.addSubview(saturationCancelButton)
        contrastSlider.setValue(saturation, animated: true)
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
        
        filter.setValue(saturation, forKey: kCIInputSaturationKey)
        
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
