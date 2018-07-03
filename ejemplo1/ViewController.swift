//
//  ViewController.swift
//  ejemplo1
//
//  Created by Mac01 on 22/06/18.
//  Copyright © 2018 pangolabs2017. All rights reserved.
//
import Alamofire
import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var txthello: UILabel!
    var a: Int = Int("") ?? 0
    var funca: (() -> Void)?
    
    static let encoder = JSONEncoder()
    static let decoder = JSONDecoder()
    // comentario de nil
    //static let algo =
    
    override func viewDidLoad() {
        super.viewDidLoad()
        txthello.text = "algo mas"
        asd(0)
        ViewController.getDataGeneral("https://app.antapaccay.com.pe/hsecweb/whsec_Service/api/Muro/GetMuro/1/100", success: { (algoconAny:Any?,algoconData:Data?) in
            // ViewController.translateTo(algoconData!)
            let array: ArrayGeneral<Temp> = ViewController.translateToArrayOf(algoconData!)
            print(algoconAny as! NSDictionary)
            print(array.Count)
            print(array.Data[0].Area)
        })
        funca?()
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func asd(_ i:Int)-> String {
        return ""
    }
    static let header="eyJhbGciOiJodHRwOi8vd3d3LnczLm9yZy8yMDAxLzA0L3htbGRzaWctbW9yZSNyc2Etc2hhMjU2IiwidHlwIjoiSldUIn0.eyJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9uYW1lIjoiMSIsImh0dHA6Ly9zY2hlbWFzLnhtbHNvYXAub3JnL3dzLzIwMDUvMDUvaWRlbnRpdHkvY2xhaW1zL25hbWVpZGVudGlmaWVyIjoiMTIzNCIsImV4cCI6MTUyOTc0MDMxOCwiaXNzIjoiaHR0cDovL2lzc3Vlci5jb20iLCJhdWQiOiJodHRwOi8vbXlzaXRlLmNvbSJ9.QlqZxoDXOOEM83yjLppSlT87XcgJrq6oz1TbmCmVNaHimBz58rbqVAeFRIhJYUKHsFCoGoPy1uDQfusClVDWoZHDi9jqje7dPGjUSw0PvsVNTsMIvZIBsX6pNCN-nQfrc8Od-Kkq_gfw74LCo487QjQofVSBP5szQ8b52kYVPVrXn0j1HruzhWn-O9I6FTgptGyd3WeQ-fyUxsIMdN0Dm4avhbH-kZEUjyRDNByWeNuUsgEcNgMqvqxMBiyGjJ-m8JdyXDuZrBQnVXLmSpd41Zpm7QnEh_N-txtLzYjfTbLDPueDB4tRioYghVc1hsn5h_hdoBuxaqx_061KB-g_ow"
    static func getDataGeneral(_ route: String, success: @escaping ( _ resultValue: Any?,_ data: Data?) -> Void) {
        print(route)
        Alamofire.request(route, headers: ["Authorization":"Bearer \(self.header)"]).responseJSON { response in
            if let status = response.response?.statusCode {
                switch status {
                case 200:
                    success(response.result.value, response.data)
                default:
                    print("\(status)")
                }
            } else {
                print("Error")
            }
        }
    }
    
    static func translateToArrayOf<Class: Codable>(_ data: Data) -> ArrayGeneral<Class> {
        do {
            let result: ArrayGeneral<Class> = try decoder.decode(ArrayGeneral<Class>.self, from: data)
            return result
        } catch {
            return ArrayGeneral<Class>()
        }
    }
    
    static func translateTo<Class: Codable>(_ data: Data) -> Class? {
        do {
            let result: Class = try decoder.decode(Class.self, from: data)
            return result
        } catch {
            return nil
        }
    }
    
    static func translateToJSON<Class: Codable>(_ objeto: Class) -> Data? {
        do {
            let result = try encoder.encode(objeto)
            return result
        } catch {
            return nil
        }
    }
}

