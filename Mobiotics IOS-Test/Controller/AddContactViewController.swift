//
//  AddContactViewController.swift
//  Mobiotics IOS-Test
//
//  Created by Suraj on 27/09/18.
//  Copyright © 2018 Suraj. All rights reserved.
//

import UIKit

class AddContactViewController: UIViewController,UITextFieldDelegate,UIImagePickerControllerDelegate, UINavigationControllerDelegate,UIGestureRecognizerDelegate {

    @IBOutlet weak var countryCode: UITextField!
    @IBOutlet weak var addContactButton: UIButton!
    @IBOutlet weak var contactNumber: UITextField!
    @IBOutlet weak var contactEmail: UITextField!
    @IBOutlet weak var contactLastName: UITextField!
    @IBOutlet weak var contactName: UITextField!
    @IBOutlet weak var contactImage: UIImageView!
    
    var imagePicker: UIImagePickerController!
    var imageViewbackview = UIImageView()
    
    var countryListArray = [CountryListModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.contactName.delegate = self
        self.contactLastName.delegate = self
        self.contactEmail.delegate = self
        self.contactNumber.delegate = self
        self.countryCode.delegate = self
        
        
        self.addContactButton.layer.cornerRadius = 5
        
        
        self.contactImage.layer.cornerRadius = self.contactImage.frame.height/2
        self.contactImage.clipsToBounds = true
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.counryShortCodeFunc(_:)), name: NSNotification.Name(rawValue: "counryShortCode"), object: nil)
        
        self.imagePicker =  UIImagePickerController()
        self.imagePicker.delegate = self
        
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(AddContactViewController.dismissKeyboard))
        tap.delegate = self
        self.view.addGestureRecognizer(tap)
        
    }

    @objc func dismissKeyboard()
    {
        self.view.endEditing(true)
    }
    
    @objc func counryShortCodeFunc(_ not:NSNotification)
    {
        let obj = not.object as! String
        
        self.countryCode.text = obj
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.navigationController?.navigationBar.tintColor = UIColor.blue
    }
    
    override func viewDidLayoutSubviews() {
        let border = CALayer()
        let width = CGFloat(1.0)
        border.borderColor = UIColor.black.cgColor
        border.frame = CGRect(x: 0, y: contactName.frame.size.height - width, width: contactName.frame.size.width, height: contactName.frame.size.height)
        border.borderWidth = width
        contactName.backgroundColor = UIColor.clear
        contactName.layer.addSublayer(border)
        contactName.layer.masksToBounds = true
        contactName.textColor = UIColor.black
        
        contactName.attributedPlaceholder = NSAttributedString(string: "First Name",
                                                               attributes: [NSAttributedStringKey.foregroundColor: UIColor.black])
        
        let borderl = CALayer()
        let widthl = CGFloat(1.0)
        borderl.borderColor = UIColor.black.cgColor
        borderl.frame = CGRect(x: 0, y: contactLastName.frame.size.height - widthl, width: contactLastName.frame.size.width, height: contactLastName.frame.size.height)
        borderl.borderWidth = widthl
        contactLastName.backgroundColor = UIColor.clear
        contactLastName.layer.addSublayer(borderl)
        contactLastName.layer.masksToBounds = true
        contactLastName.textColor = UIColor.black
        
        contactLastName.attributedPlaceholder = NSAttributedString(string: "Last Name",
                                                               attributes: [NSAttributedStringKey.foregroundColor: UIColor.black])
        
        let borderle = CALayer()
        let widthle = CGFloat(1.0)
        borderle.borderColor = UIColor.black.cgColor
        borderle.frame = CGRect(x: 0, y: contactEmail.frame.size.height - widthle, width: contactEmail.frame.size.width, height: contactEmail.frame.size.height)
        borderle.borderWidth = widthle
        contactEmail.backgroundColor = UIColor.clear
        contactEmail.layer.addSublayer(borderle)
        contactEmail.layer.masksToBounds = true
        contactEmail.textColor = UIColor.black
        
        contactEmail.attributedPlaceholder = NSAttributedString(string: "Email",
                                                                   attributes: [NSAttributedStringKey.foregroundColor: UIColor.black])
        
        let borderlec = CALayer()
        let widthlec = CGFloat(1.0)
        borderlec.borderColor = UIColor.black.cgColor
        borderlec.frame = CGRect(x: 0, y: contactNumber.frame.size.height - widthlec, width: contactNumber.frame.size.width, height: contactNumber.frame.size.height)
        borderlec.borderWidth = widthlec
        contactNumber.backgroundColor = UIColor.clear
        contactNumber.layer.addSublayer(borderlec)
        contactNumber.layer.masksToBounds = true
        contactNumber.textColor = UIColor.black
        
        contactNumber.attributedPlaceholder = NSAttributedString(string: "Phone Number",
                                                                attributes: [NSAttributedStringKey.foregroundColor: UIColor.black])
        
        let borderlecd = CALayer()
        let widthlecd = CGFloat(1.0)
        borderlecd.borderColor = UIColor.black.cgColor
        borderlecd.frame = CGRect(x: 0, y: countryCode.frame.size.height - widthlecd, width: countryCode.frame.size.width, height: countryCode.frame.size.height)
        borderlecd.borderWidth = widthlecd
        countryCode.backgroundColor = UIColor.clear
        countryCode.layer.addSublayer(borderlecd)
        countryCode.layer.masksToBounds = true
        countryCode.textColor = UIColor.black
        
        countryCode.attributedPlaceholder = NSAttributedString(string: "Country Code",
                                                                 attributes: [NSAttributedStringKey.foregroundColor: UIColor.black])
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        self.view.endEditing(true)
        return true
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        
        if textField == self.countryCode{
            
            self.openCountryCodeListVC()
            
            return false
        }
        return true
    }
    
    func openCountryCodeListVC()
    {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let destination = storyboard.instantiateViewController(withIdentifier: "CountryListingViewController") as! CountryListingViewController
        
        destination.modalPresentationStyle = .overCurrentContext
        
        self.present(destination, animated: false, completion: nil)
    }
    
    
    @IBAction func buttonTapped(_ sender: Any)
    {
        let alert:UIAlertController = UIAlertController(title: "Choose Image", message: nil, preferredStyle: UIAlertControllerStyle.actionSheet)
        
        let cameraAction = UIAlertAction(title: "Camera", style: UIAlertActionStyle.default)
        {
            UIAlertAction in
            self.openCamera()
        }
        
        let gallaryAction = UIAlertAction(title: "Gallary", style: UIAlertActionStyle.default)
        {
            UIAlertAction in
            self.openGallary()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel)
        {
            UIAlertAction in
        }
        self.imagePicker.delegate = self
        alert.addAction(cameraAction)
        alert.addAction(gallaryAction)
        alert.addAction(cancelAction)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func openCamera()
    {
        if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerControllerSourceType.camera)){
            imagePicker.allowsEditing = true
            imagePicker.sourceType = UIImagePickerControllerSourceType.camera
            self .present(imagePicker, animated: true, completion: nil)
            
        }else{
            let alert = UIAlertView()
            alert.title = "Warning"
            alert.message = "You don't have camera"
            alert.addButton(withTitle: "OK")
            alert.show()
        }
    }
    func openGallary(){
        
        imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary
        imagePicker.allowsEditing = true
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let pickedImage = info[UIImagePickerControllerEditedImage] as? UIImage {
            self.contactImage.image = pickedImage
        }
        else
        {
            if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
                
                self.contactImage.image = pickedImage
            }
        }
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func addContactButtonFunc(_ sender: Any) {
        
        
        if (self.contactName.text?.isEmpty)!{
            self.shakeView(contactName)
        }
        else if (self.contactLastName.text?.isEmpty)!{
            self.shakeView(contactLastName)
        }
        else if (self.contactEmail.text?.isEmpty)!{
            self.shakeView(contactEmail)
        }
        else if self.contactEmail.isValidEmail() == false{
            self.shakeView(contactEmail)
        }
        else if (self.contactNumber.text?.isEmpty)!{
            shakeView(contactNumber)
        }
        else if (self.contactNumber.text?.characters.count)! < 10{
            shakeView(contactNumber)
        }
        else if self.isValidPhone(phone: self.contactNumber.text!) == false{
            shakeView(contactNumber)
        }
        else if (self.countryCode.text?.isEmpty)!{
            shakeView(self.countryCode)
        }
        else{
            
            let encodedImageData = self.encode(self.contactImage.image!)
            
            let obj = CountryListModel(countryName: self.contactName.text!, countryLastName: self.contactLastName.text!, email: self.contactEmail.text!, phoneNumber: self.contactNumber.text!, countryCode: self.countryCode.text!, image:encodedImageData)
            
            self.countryListArray.append(obj)
            
            //save in offline mode
            
           // UserDefaults.standard.set(tasksDetailsObj, forKey: "countryListOffline")
            if let data = UserDefaults.standard.data(forKey: "countryListOffline"),
                let myPeopleList = NSKeyedUnarchiver.unarchiveObject(with: data) as? [CountryListModel] {
                
                //self.contactDataArray.removeAll()
                self.countryListArray += myPeopleList
                
                let tasksDetailsObj = NSKeyedArchiver.archivedData(withRootObject: self.countryListArray)
                
                 UserDefaults.standard.set(tasksDetailsObj, forKey: "countryListOffline")
                
            }else{
                
                let tasksDetailsObj = NSKeyedArchiver.archivedData(withRootObject: self.countryListArray)
                
                UserDefaults.standard.set(tasksDetailsObj, forKey: "countryListOffline")
            }
            //end here
            
            self.navigationController?.popViewController(animated: true)
            
        }
    }
    
    func encode(_ image: UIImage) -> String {
        return UIImagePNGRepresentation(image)!.base64EncodedString(options: .lineLength64Characters)
    }
    
    func isValidPhone(phone: String) -> Bool {
        
        let phoneRegex = "^[0-9]{6,14}$";
        let valid = NSPredicate(format: "SELF MATCHES %@", phoneRegex).evaluate(with: phone)
        return valid
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        if textField == contactLastName{
            animateViewMoving(true, moveValue: 60)
        }
        else if textField == contactEmail{
            animateViewMoving(true, moveValue: 70)
        }
        else if textField == contactNumber{
            animateViewMoving(true, moveValue: 80)
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        if textField == contactLastName{
            animateViewMoving(false, moveValue: 60)
        }
        else if textField == contactEmail{
            animateViewMoving(false, moveValue: 70)
        }
        else if textField == contactNumber{
            animateViewMoving(false, moveValue: 80)
        }
        
    }
    
    func animateViewMoving (_ up:Bool, moveValue :CGFloat){
        let movementDuration:TimeInterval = 0.3
        let movement:CGFloat = ( up ? -moveValue : moveValue)
        UIView.beginAnimations( "animateView", context: nil)
        UIView.setAnimationBeginsFromCurrentState(true)
        UIView.setAnimationDuration(movementDuration )
        self.view.frame = self.view.frame.offsetBy(dx: 0,  dy: movement)
        UIView.commitAnimations()
    }
    
    func shakeView(_ sender:UITextField){
        
        let shake:CABasicAnimation = CABasicAnimation(keyPath: "position")
        
        shake.duration = 0.1
        
        shake.repeatCount = 2
        
        shake.autoreverses = true
        
        let from_point:CGPoint = CGPoint(x: sender.center.x - 5, y: sender.center.y)
        
        let from_value:NSValue = NSValue(cgPoint: from_point)
        
        let to_point:CGPoint = CGPoint(x: sender.center.x + 5, y: sender.center.y)
        
        let to_value:NSValue = NSValue(cgPoint: to_point)
        
        shake.fromValue = from_value
        shake.toValue = to_value
        sender.layer.add(shake, forKey: "position")
        
    }
}
