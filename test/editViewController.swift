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
    var filterBrightness: Float?
    var filterContrast: Float?
    var filterSaturation: Float?
    private var brightnessButton: UIButton!
    private var contrastButton: UIButton!
    private var saturationButton: UIButton!
    private var doneButton: UIButton!
    private var contrastCancelButton: UIButton!
    private var brightnessCancelButton: UIButton!
    private var saturationCancelButton: UIButton!
    private var saveFilterButton: UIButton!
    private var saveButton: UIButton!
    private var shareButton: UIButton!
    private var filterButton: UIButton!
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
        addSaveFilterButton()
        addFilterButton()
        addSaveButton()
        addShareButton()
        self.view.addSubview(brightnessButton)
        self.view.addSubview(contrastButton)
        self.view.addSubview(saturationButton)
        self.view.addSubview(saveFilterButton)
        self.view.addSubview(filterButton)
        self.view.addSubview(saveButton)
        self.view.addSubview(shareButton)
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
    
    //saturationのすらいだーをつくる
    func addSaturationSlider() {
        saturationSlider.layer.position = CGPoint(x:self.view.frame.midX, y:600)
        saturationSlider.layer.cornerRadius = 20.0
        saturationSlider.layer.shadowOpacity = 0.5
        saturationSlider.layer.masksToBounds = false
        saturationSlider.tintColor = UIColor.gray
        saturationSlider.minimumValue = 0
        saturationSlider.maximumValue = 2
        saturationSlider.setValue(saturation, animated: true)
        saturationSlider.addTarget(self, action: #selector(self.changeSaturation(sender:)), for: .valueChanged)
    }
    
    //filter保存ぼたんをつくる
    func addSaveFilterButton() {
        saveFilterButton = UIButton()
        let bWidth: CGFloat = 50
        let bHeight: CGFloat = 50
        let posX: CGFloat = 18.5*(self.view.frame.width)/20 - bWidth/2
        let posY: CGFloat = 14*(self.view.frame.height)/20 - bHeight/2
        saveFilterButton.frame = CGRect(x: posX, y: posY, width: bWidth, height: bHeight)
        saveFilterButton.setTitle("卍", for: .normal)
        saveFilterButton.setTitleColor(UIColor.black, for: .normal)
        saveFilterButton.titleLabel?.font = UIFont.systemFont(ofSize: 25)
        saveFilterButton.addTarget(self, action: #selector(self.saveFilter(sender:)), for: .touchUpInside)
    }
    
    //保存ぼたん
    func addSaveButton() {
        saveButton = UIButton()
        let bWidth: CGFloat = 50
        let bHeight: CGFloat = 50
        let posX: CGFloat = 2*(self.view.frame.width)/20 - bWidth/2
        let posY: CGFloat = 14*(self.view.frame.height)/20 - bHeight/2
        saveButton.frame = CGRect(x: posX, y: posY, width: bWidth, height: bHeight)
        saveButton.setTitle("Save", for: .normal)
        saveButton.setTitleColor(UIColor.black, for: .normal)
        saveButton.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        saveButton.addTarget(self, action: #selector(self.savePhoto(sender:)), for: .touchUpInside)
    }
    
    //
    func addShareButton() {
        shareButton = UIButton()
        let bWidth: CGFloat = 50
        let bHeight: CGFloat = 50
        let posX: CGFloat = 5*(self.view.frame.width)/20 - bWidth/2
        let posY: CGFloat = 14*(self.view.frame.height)/20 - bHeight/2
        shareButton.frame = CGRect(x: posX, y: posY, width: bWidth, height: bHeight)
        shareButton.setTitle("Share", for: .normal)
        shareButton.setTitleColor(UIColor.black, for: .normal)
        shareButton.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        shareButton.addTarget(self, action: #selector(self.sharePhoto(sender:)), for: .touchUpInside)
    }
    
    func addFilterButton() {
        filterButton = UIButton()
        let bWidth: CGFloat = 75
        let bHeight: CGFloat = 50
        let posX: CGFloat = 15*(self.view.frame.width)/20 - bWidth/2
        let posY: CGFloat = 14*(self.view.frame.height)/20 - bHeight/2
        filterButton.frame = CGRect(x: posX, y: posY, width: bWidth, height: bHeight)
        filterButton.setTitle("MyFilter", for: .normal)
        filterButton.setTitleColor(UIColor.black, for: .normal)
        filterButton.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        filterButton.addTarget(self, action: #selector(self.filter(sender:)), for: .touchUpInside)
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
        
        //saturation
        filter.setValue(saturation, forKey: kCIInputSaturationKey)
        
        
        let ctx = CIContext(options: nil)
        let cgImage = ctx.createCGImage(filter.outputImage!, from: filter.outputImage!.extent)
        imageView.image = UIImage(cgImage: cgImage!)
    }
    
    //filterを保存する
    @objc func saveFilter(sender: UIButton) {
        userDefaults.set(brightness, forKey: "brightness")
        userDefaults.set(contrast, forKey: "contrast")
        userDefaults.set(saturation, forKey: "saturation")
        let alert: UIAlertController = UIAlertController(title: "保存", message: "保存しました", preferredStyle: .alert)
        alert.addAction(
            UIAlertAction(
                title: "OK",
                style: .default,
                handler: { action in
                    //ボタンが押された時の動作

                    print("OKボタンが押されました!")
            }
            )
        )
        present(alert, animated: true, completion: nil)
        print("DebugPrint\(userDefaults.object(forKey: "brightness") as! Float)")
    }
    
    @objc func filter(sender: UIButton) {
        brightness = userDefaults.object(forKey: "brightness") as! Float
        contrast = userDefaults.object(forKey: "contrast") as! Float
        saturation = userDefaults.object(forKey: "saturation") as! Float
        print(brightness)
        changeFilter()
    }
    
    //画像を保存
    @objc func savePhoto(sender: UIButton) {
        UIImageWriteToSavedPhotosAlbum(imageView.image!, nil, nil, nil)
    }
    
    //画像をSNSでシェア
    @objc func sharePhoto(sender: UIButton) {
        let shareImage = imageView.image!
        let activityItems: [Any] = [shareImage]
        let activityViewController = UIActivityViewController(activityItems: activityItems, applicationActivities: nil)
        let excludeAcitivityTypes = [UIActivityType.postToWeibo, .saveToCameraRoll, .print]
        activityViewController.excludedActivityTypes = excludeAcitivityTypes
        present(activityViewController, animated: true, completion: nil)
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
