//
//  ViewController2.swift
//  Demo
//
//  Created by ahmet on 6.07.2019.
//  Copyright © 2019 konusarakogren. All rights reserved.
//

import UIKit
import SwiftSoup
import SwiftGoogleTranslate

class ViewController2: UIViewController {

    
    @IBOutlet var image: UIImageView!
    @IBOutlet var titleTextView: UITextField!
    @IBOutlet weak var textArea: UITextView!
    
    @IBOutlet var enWord1: UITextField!
    @IBOutlet var enWord2: UITextField!
    @IBOutlet var enWord3: UITextField!
    @IBOutlet var enWord4: UITextField!
    @IBOutlet var enWord5: UITextField!
    
    @IBOutlet var trWord1: UITextField!
    @IBOutlet var trWord2: UITextField!
    @IBOutlet var trWord3: UITextField!
    @IBOutlet var trWord4: UITextField!
    @IBOutlet var trWord5: UITextField!
    
    var mostCommonElements = ""
    
    var articleLink = "" // used for data transfer between controller
    var articleImgSrc = "" // used for data transfer between controller
    var articleTitle = "" // used for data transfer between controller
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchHtmlContents()
        
        let articelUrl = URL(string: articleImgSrc)
        let data = try? Data(contentsOf: articelUrl!)
        image.image = UIImage(data: data!)
        titleTextView.text = articleTitle
    }
    
    func fetchHtmlContents() ->() {
        if let url = URL(string: "https://www.wired.com" + articleLink){
            do {
                let contents = try String(contentsOf: url)                
                let doc: Document = try SwiftSoup.parse(contents)
                let p: [Element] = try doc.select("p").array()
                
                for i in p {
                    let title = try i.text()
                    mostCommonElements += try i.text()
                    textArea.text += title
                }
                let stringArray = mostCommonElements.split{$0 == " "}.map(String.init)
                mostCommonElement(inArray: stringArray)
                
            } catch Exception.Error(type: _, Message: let message){
                print("url'ye erisilemiyor")
                print(message)
                // contents could not be loaded
            } catch{
                textArea.text = "içerige erişelemiyor"
            }
        } else {
            
        }
    }
    func mostCommonElement(inArray array: [String]) -> () {
        
        SwiftGoogleTranslate.shared.start(with: "AIzaSyDFQgL2znjGowcGYtcsGwiWUM6oqTSYuUg")
        var dictionary = [String: Int]()
        
        array.forEach { (element) in
            if let count = dictionary[element] {
                dictionary[element] = count + 1
            } else {
                dictionary[element] = 1
            }
        }
        var max = 0
        
        for (key, _) in dictionary {
            if (key == "a" || key == "an" || key == "the" || key == "The" || key == "can" || key == "of" || key == "have" || key == "has" ||
                key == "they" || key == "its" || key == "about" || key == "where" || key == "what" || key == "how" || key == "but" || key == "more" ||
                key == "their" || key == "we" || key == "from" || key == "From" || key == "on" || key == "in" || key == "that" || key == "this" ||
                key == "at" || key == "are" || key == "to" || key == "and" || key == "is" || key == "as" || key == "with" || key == "for" ||
                key == "be" || key == "was" || key == "it" || key == "not" || key == "or" || key == "just" || key == "now" || key == "then" ||
                key == "new" || key == "than" || key == "you" || key == "could" || key == "In")
            {
                dictionary.removeValue(forKey: key)
            }
        }
        
        let topwords = dictionary.max { a, b in a.value < b.value }
        
        enWord1.text = topwords?.key
        translateTrtoEn(entoTr: enWord1.text!, tV: trWord1)
        
        dictionary.removeValue(forKey: enWord1.text!)
        
        let topwords2 = dictionary.max { a, b in a.value < b.value }
        enWord2.text = topwords2?.key
        translateTrtoEn(entoTr: enWord2.text!,tV: trWord2)
        
        for(_, value) in dictionary {
            if value > max {
                max = value            }
        }
        dictionary.removeValue(forKey: enWord2.text!)
        
        
        let topwords3 = dictionary.max { a, b in a.value < b.value }
        enWord3.text = topwords3?.key
        translateTrtoEn(entoTr: enWord3.text!,tV: trWord3)
        
        for(_, value) in dictionary {
            if value > max {
                max = value            }
        }
        
        dictionary.removeValue(forKey: enWord3.text!)
        
        let topwords4 = dictionary.max { a, b in a.value < b.value }
        enWord4.text = topwords4?.key
        translateTrtoEn(entoTr: enWord4.text!, tV: trWord4)
        
        for(_, value) in dictionary {
            if value > max {
                max = value            }
        }
        
        dictionary.removeValue(forKey: enWord4.text!)
        
        let topwords5 = dictionary.max { a, b in a.value < b.value }
        enWord5.text = topwords5?.key
        translateTrtoEn(entoTr: enWord5.text!,tV: trWord5)
        
        for(_, value) in dictionary {
            if value > max {
                max = value
            }
        }
        enWord5.text = topwords5?.key
    }
    
    func translateTrtoEn(entoTr: String, tV: UITextField) ->() {
    
        SwiftGoogleTranslate.shared.translate(entoTr, "tr", "en") { (text, error) in
            if let t = text {
                DispatchQueue.main.async {
                tV.text = t
                }
            }
        }
    }
}
