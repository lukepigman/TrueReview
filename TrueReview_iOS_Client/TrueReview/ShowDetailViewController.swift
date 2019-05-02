//
//  ShowDetailViewController.swift
//  TrueReview
//
//  Created by Pigman, Luke on 4/29/19.
//  Copyright © 2019 Billy Lim. All rights reserved.
//

import UIKit
import MapKit
import Alamofire

class ShowDetailViewController: UIViewController {
    
    @IBOutlet weak var newBut: UIButton!
    @IBOutlet weak var goThere: UIButton!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var goToButton: UIButton!
    @IBOutlet weak var trScoreLabel: UILabel!
    @IBOutlet weak var yrLabel: UILabel!
    @IBOutlet weak var rNameLabel: UILabel!
    var loco: Attraction?
    var scoreLabel: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        

        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer zmd9y3Q30Zj7Ekoh8sokT1bmzw4hWXNfzpjbnjSV5GXhX6v6gKslsx7T645Dm4rBMCv-x5ZKAM_0l7-FlFJS76ev43IWXnDcwyoOwIRVZh2SGyLne_jzL3-LHAbGXHYx",
            "Accept": "application/json"
        ]
        print("requesting at http://truereview-env.esdjmc2j8y.us-west-2.elasticbeanstalk.com/service/?id=\(String(describing: loco!.id))")
        Alamofire.request("http://truereview-env.esdjmc2j8y.us-west-2.elasticbeanstalk.com/service/?id=\(String(describing: loco!.id))", headers: headers).responseJSON { response in
//            print("Request: \(String(describing: response.request))")   // original url request
           print("Response: \(String(describing: response.response))") // http url response
            ("Result: \(response.result)")// response serialization result

            let decoder = JSONDecoder()
            do {


                let TR = try? decoder.decode(TRScore.TRS.self, from: response.data!)
              
              
                
               

        } catch {
                print("error trying to convert data to JSON")
                print(error)

            }
            if let json = response.result.value {
                var str = String(describing: response.result.value)
                if let range = str.range(of: ": ") {
                    var score = str[range.upperBound...]
                    var out = String(describing: score)
                    out.remove(at: out.index(before: out.endIndex))
                    out.remove(at: out.index(before: out.endIndex))
                    self.trScoreLabel.text = out
                }
              
                print("JSON: \(json)") // serialized json response
            }

        }
    

        // Do any additional setup after loading the view.
        
        
        rNameLabel.text = loco?.locationName
        rNameLabel.sizeToFit()
        phoneLabel.text = loco?.display_phone
       
        yrLabel.text = String(describing: loco!.rating)
    }
    @IBAction func goToSite(_ sender: UIButton) {
        guard let url = URL(string: (loco?.url)!) else { return }
        UIApplication.shared.open(url)
        
    }
    @IBAction func goThereNow(_ sender: UIButton) {
        let placemark = MKPlacemark(coordinate: (loco?.coordinate)!)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = (loco?.locationName)!
        
        let regionDistance:CLLocationDistance = 2000
        let coordinates = CLLocationCoordinate2DMake((loco?.coordinate.latitude)!, (loco?.coordinate.longitude)!)
        let regionSpan = MKCoordinateRegionMakeWithDistance(coordinates, regionDistance, regionDistance)
        
        let options = [
            MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: regionSpan.center),
            MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan: regionSpan.span)
        ]
        
        mapItem.openInMaps(launchOptions: options)
    }
    
    
    @IBAction func goBackToSearch(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

//}
//    }
    
}



