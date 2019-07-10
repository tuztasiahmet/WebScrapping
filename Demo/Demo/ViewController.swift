//
//  ViewController.swift
//  Demo
//
//  Created by ahmet on 6.07.2019.
//  Copyright © 2019 konusarakogren. All rights reserved.
//

import UIKit
import SwiftSoup

class ViewController: UIViewController,UICollectionViewDelegate {
    
    @IBOutlet var title1: UITextField!
    @IBOutlet var title2: UITextField!
    @IBOutlet var title3: UITextField!
    @IBOutlet var title4: UITextField!
    @IBOutlet var title5: UITextField!
    
    @IBOutlet var image1: UIImageView!
    @IBOutlet var image2: UIImageView!
    @IBOutlet var image3: UIImageView!
    @IBOutlet var image4: UIImageView!
    @IBOutlet var image5: UIImageView!
    
    
    @IBOutlet var btn1: UIButton!
    @IBOutlet var btn2: UIButton!
    @IBOutlet var btn3: UIButton!
    @IBOutlet var btn4: UIButton!
    @IBOutlet var btn5: UIButton!
    
    let link1 = ""
    let link2 = ""
    let link3 = ""
    let link4 = ""
    let link5 = ""
    
    var tempArray = [String]()
    var imgSrcArray = [String]()
    var titleArray = [String]()
    var linkArray = [String]()
    
    let _url = "https://www.wired.com"
    var segueLink = ""
    var segueTitle = ""
    var segueImageSrc = ""

    override func viewDidLoad() {
        takeTitle()
        takeLinkHref()
        takeImageUrl()
    }
    
    func takeImageUrl() -> (){
        if let url = URL(string: _url) {
            do {
                let contents = try String(contentsOf: url)
                let els: Elements = try SwiftSoup.parse(contents).select("img")
                
                for link: Element in els.array() {
                    let imgSrc: String = try link.attr("src")
                    if(imgSrc.contains("photos")) {
                        imgSrcArray.append(imgSrc)
                    }
                }
                let url = URL(string: imgSrcArray[0])
                let data = try? Data(contentsOf: url!)
                image1.image = UIImage(data: data!)
                
                let url2 = URL(string: imgSrcArray[1])
                let data2 = try? Data(contentsOf: url2!)
                image2.image = UIImage(data: data2!)
                
                let url3 = URL(string: imgSrcArray[2])
                let data3 = try? Data(contentsOf: url3!)
                image3.image = UIImage(data: data3!)
                
                let url4 = URL(string: imgSrcArray[3])
                let data4 = try? Data(contentsOf: url4!)
                image4.image = UIImage(data: data4!)

                let url5 = URL(string: imgSrcArray[4])
                let data5 = try? Data(contentsOf: url5!)
                image5.image = UIImage(data: data5!)
                
            } catch Exception.Error(type: let type, Message: let message){
                print(type)
                print(message)
                // contents could not be loaded
            } catch{
                print("")
            }
        } else {
            // the URL was bad!
        }
    }
    
    func takeTitle() -> (){
        if let url = URL(string: _url) {
            do {
                let contents = try String(contentsOf: url)
                let doc: Document = try SwiftSoup.parse(contents)
                let h2: [Element] = try doc.select("h2").array()
                
                var i = 0
                while(i<5){ //element to string  convert array
                    titleArray.append(try h2[i].text())
                    i+=1
                }
                
                title1.text = titleArray[0]
                title2.text = titleArray[1]
                title3.text = titleArray[2]
                title4.text = titleArray[3]
                title5.text = titleArray[4]
                
            } catch Exception.Error(type: let type, Message: let message){
                print(type)
                print(message)
                // contents could not be loaded
            } catch{
                print("")
            }
        } else {
            // the URL was bad!
        }
    }
    
    func takeLinkHref() -> (){
        if let url = URL(string: _url) {
            do {
                let contents = try String(contentsOf: url)
                let els: Elements = try SwiftSoup.parse(contents).select("a")
                
                for link: Element in els.array() {
                    let linkHref: String = try link.attr("href")
                    if(linkHref.contains("story")) {
                        tempArray.append(linkHref)
                    }
                }
                var i = 0
                while(i<15){ // 3 kerede bir linkler tekrarlandıgı ıcın kullanıldı
                    linkArray.append(tempArray[i])
                    i+=3
                }
            } catch Exception.Error(type: let type, Message: let message){
                print(type)
                print(message)
                // contents could not be loaded
            } catch{
                print("")
            }
        } else {
            // the URL was bad!
        }
    }
        
    @IBAction func btn1(_ sender: Any) {
        self.segueLink = linkArray[0]
        self.segueImageSrc = imgSrcArray[0]
        self.segueTitle = titleArray[0]
        //self.segueTitle =
        performSegue(withIdentifier: "passData", sender: self)
    }
    @IBAction func btn2(_ sender: Any) {
        self.segueLink = linkArray[1]
        self.segueImageSrc = imgSrcArray[1]
        self.segueTitle = titleArray[1]
        performSegue(withIdentifier: "passData", sender: self)
    }
    @IBAction func btn3(_ sender: Any) {
        self.segueLink = linkArray[2]
        self.segueImageSrc = imgSrcArray[2]
        self.segueTitle = titleArray[2]
        performSegue(withIdentifier: "passData", sender: self)
    }
    @IBAction func btn4(_ sender: Any) {
        self.segueLink = linkArray[3]
        self.segueImageSrc = imgSrcArray[3]
        self.segueTitle = titleArray[3]
        performSegue(withIdentifier: "passData", sender: self)
        
    }
    @IBAction func btn5(_ sender: Any) {
        self.segueLink = linkArray[4]
        self.segueImageSrc = imgSrcArray[4]
        self.segueTitle = titleArray[4]
        performSegue(withIdentifier: "passData", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! ViewController2
        vc.articleLink = self.segueLink
        vc.articleTitle = self.segueTitle
        vc.articleImgSrc = self.segueImageSrc
    }
}
