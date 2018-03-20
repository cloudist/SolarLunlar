//
//  ViewController.swift
//  SolarLunar
//
//  Created by liubo on 2018/3/16.
//  Copyright © 2018年 cloudist. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var solarYear: UITextField!
    
    @IBOutlet weak var solarMonth: UITextField!
    
    @IBOutlet weak var solarDay: UITextField!
    
    @IBOutlet weak var solarErrorPrompt: UILabel!
    @IBOutlet weak var lunarYear: UITextField!
    
    @IBOutlet weak var lunarMonth: UITextField!
    
    @IBOutlet weak var lunarDay: UITextField!
    
    @IBOutlet weak var isLeapMonth: UISwitch!
    
    @IBOutlet weak var LunarErrorPrompt: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func solar2Lunar(_ sender: Any) {
        lunarYear.text = nil
        lunarMonth.text = nil
        lunarDay.text = nil
        isLeapMonth.isOn = false
        solarErrorPrompt.text = nil
        
        let solar = Solar(year: Int(solarYear.text!)!, month: Int(solarMonth.text!)!, day: Int(solarDay.text!)!)
        
        do {
            let lunar = try solar.toLunar()
            lunarYear.text = String(lunar.year)
            lunarMonth.text = String(lunar.month)
            lunarDay.text = String(lunar.day)
            isLeapMonth.isOn = lunar.isLeap
        } catch let e {
            if e is Converter.ConvertError {
                let error = e as! Converter.ConvertError
                solarErrorPrompt.text = error.message
            }
        }
    }
    
    @IBAction func lunar2Solar(_ sender: Any) {
        solarYear.text = nil
        solarMonth.text = nil
        solarDay.text = nil
        LunarErrorPrompt.text = nil
        
        let lunar = Lunar(year: Int(lunarYear.text!)!, month: Int(lunarMonth.text!)!, day: Int(lunarDay.text!)!, isLeap: isLeapMonth.isOn)
        
        do {
            let solar = try lunar.toSolar()
            solarYear.text = String(solar.year)
            solarMonth.text = String(solar.month)
            solarDay.text = String(solar.day)
        } catch let e {
            if e is Converter.ConvertError {
                let error = e as! Converter.ConvertError
                LunarErrorPrompt.text = error.message
            }
        }
    }
    
    @IBAction func endEditing(_ sender: UIButton) {
        view.endEditing(true)
    }
    
    @IBAction func clearAll(_ sender: UIButton) {
        solarYear.text = nil
        solarMonth.text = nil
        solarDay.text = nil
        
        lunarYear.text = nil
        lunarMonth.text = nil
        lunarDay.text = nil
        isLeapMonth.isOn = false
    }
}

