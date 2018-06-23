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
    let brightnessSlider = UISlider(frame: CGRect(x:0, y:0, width:200, height:30))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        openAlbum()
        addBrightnessButton()
        addContrastButton()
        addDoneButton()
        addBrightnessSlider()
        self.view.addSubview(brightnessButton)
        self.view.addSubview(contrastButton)
        // Do any additional setup after loading the view.
    }
    
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
    
    func addBrightnessButton() {
        brightnessButton = UIButton()
        let bWidth: CGFloat = 200
        let bHeight: CGFloat = 50
        let posX: CGFloat = self.view.frame.width/2 - bWidth/2
        let posY: CGFloat = self.view.frame.height/2 - bHeight/2
        brightnessButton.frame = CGRect(x: posX, y: posY, width: bWidth, height: bHeight)
        brightnessButton.setTitle("Brightness", for: .normal)
        brightnessButton.setTitleColor(UIColor.white, for: .normal)
        brightnessButton.addTarget(self, action: #selector(self.brightnessButton(sender:)), for: .touchUpInside)
    }
    
    func addContrastButton() {
        contrastButton = UIButton()
        let bWidth: CGFloat = 200
        let bHeight: CGFloat = 50
        let posX: CGFloat = self.view.frame.width/2 - bWidth/2
        let posY: CGFloat = self.view.frame.height/2 - bHeight/2
        contrastButton.frame = CGRect(x: posX, y: posY, width: bWidth, height: bHeight)
        contrastButton.setTitle("Contrast", for: .normal)
        contrastButton.setTitleColor(UIColor.white, for: .normal)
        contrastButton.addTarget(self, action: #selector(self.brightnessButton(sender:)), for: .touchUpInside)
    }
    
    func addDoneButton() {
        doneButton = UIButton()
        let bWidth: CGFloat = 200
        let bHeight: CGFloat = 50
        let posX: CGFloat = self.view.frame.width/2 - bWidth/2
        let posY: CGFloat = self.view.frame.height/2 - bHeight/2
        doneButton.frame = CGRect(x: posX, y: posY, width: bWidth, height: bHeight)
        doneButton.setTitle("Done", for: .normal)
        doneButton.setTitleColor(UIColor.white, for: .normal)
        doneButton.addTarget(self, action: #selector(self.removeSlider(sender:)), for: .touchUpInside)
    }
    
    func addBrightnessSlider() {
        brightnessSlider.layer.position = CGPoint(x:self.view.frame.midX, y:600)
        brightnessSlider.layer.cornerRadius = 10.0
        brightnessSlider.layer.shadowOpacity = 0.5
        brightnessSlider.layer.masksToBounds = false
        brightnessSlider.tintColor = UIColor.gray
        brightnessSlider.minimumValue = 0
        brightnessSlider.maximumValue = 1
        brightnessSlider.setValue(0.0, animated: true)
    }
    
    @objc func removeSlider(sender: UIButton) {
        brightnessSlider.removeFromSuperview()
        doneButton.removeFromSuperview()
        self.view.addSubview(brightnessButton)
        self.view.addSubview(contrastButton)
    }
    
    func removeButtons() {
        contrastButton.removeFromSuperview()
        brightnessButton.removeFromSuperview()
    }
    
    @IBAction func brightnessButton(sender: UISlider) {
        //changeBrightness(sender: UISlider)
        brightness = Double(slider)
        userDefaults.set(brightness, forKey: "brightness")
        userDefaults.synchronize()
        changeFilter()
        self.view.addSubview(brightnessButton)
        self.view.addSubview(brightnessSlider)
    }
    
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
