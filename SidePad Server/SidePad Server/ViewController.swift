//
//  ViewController.swift
//  SidePad Server
//
//  Created by Роман Гах on 14.04.2020.
//  Copyright © 2020 Роман Гах. All rights reserved.
//

import Cocoa
import CoreBluetooth

let PERIPHERAL_NAME = "SPPeriferal"
let SWIPE_SERVICE_UUID = CBUUID.init(string: "C43F7DE2-644D-46C5-B0CF-2DBCA3E6390E")
let DIRECTION_CHARACTERISTIC_UUID = CBUUID.init(string: "096839B6-2D43-403E-8CF2-4ADA498EB4D2")

class ViewController:
        NSViewController,
        CBCentralManagerDelegate,
        CBPeripheralDelegate
{
    var manager: CBCentralManager!
    var peripheral: CBPeripheral!
    
    @IBOutlet weak var countLabel: NSTextField!
    @IBOutlet var logText: NSTextView!
    let queue = DispatchQueue.main
    

    override func viewDidLoad() {
        super.viewDidLoad()

        manager = CBCentralManager(delegate: self, queue: queue)
    }
    
    override var representedObject: Any? {
        didSet {
            // Update the view, if already loaded.
        }
    }
    
    func log(_ text: String) {
        logText.string = logText.string + "\n" + text;
    }
    
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        switch central.state {
            case .poweredOff:
                log("BLE is powered off")
            case .poweredOn:
                log("BLE is powered on")
                central.scanForPeripherals(withServices: nil, options: nil)
            case .resetting:
                log("BLE is resetting")
            case .unauthorized:
                log("BLE is not authorized")
            case .unknown:
                log("BLE state is unknown")
            case .unsupported:
                log("BLE is unsupported")
            default:
                log("Unable to determine BLE state")
        }
    }
    
    func centralManager(_ central: CBCentralManager,
                        didDiscover peripheral: CBPeripheral,
                        advertisementData: [String : Any],
                        rssi RSSI: NSNumber)
    {
        log(peripheral.description);
        
        guard peripheral.services != nil else {
            log("No services")
            return ;
        }
        
        let services = peripheral.services!
        for service in services {
            self.log("Service uuid: " + service.uuid.description)
        }
    }
    
    func centralManager(central: CBCentralManager,
                        didDiscoverPeripheral peripheral: CBPeripheral,
                        advertisementData: [String : AnyObject],
                        RSSI: NSNumber)
    {
        let device = (advertisementData as NSDictionary)
                        .object(forKey: CBAdvertisementDataLocalNameKey)
                        as? NSString
            
        if device?.contains(PERIPHERAL_NAME) == true {
            self.manager.stopScan()
            self.peripheral = peripheral
            self.peripheral.delegate = self

            manager.connect(peripheral, options: nil)
        }
    }
    
    func centralManager(central: CBCentralManager,
                        didConnectPeripheral peripheral: CBPeripheral)
    {
        peripheral.discoverServices(nil)
    }
    
    func peripheral(peripheral: CBPeripheral, didDiscoverServices error: NSError?)
    {
        for service in peripheral.services! {
            let thisService = service as CBService

            if service.uuid == SWIPE_SERVICE_UUID {
                peripheral.discoverCharacteristics(nil, for: thisService)
            }
        }
    }
    
    func peripheral(peripheral: CBPeripheral,
                    didDiscoverCharacteristicsForService service: CBService,
                    error: NSError?)
    {
        for characteristic in service.characteristics! {
            let thisCharacteristic = characteristic as CBCharacteristic

            if thisCharacteristic.uuid == DIRECTION_CHARACTERISTIC_UUID {
                self.peripheral.setNotifyValue(true, for: thisCharacteristic)
            }
        }
    }
    
    func peripheral(peripheral: CBPeripheral,
                    didUpdateValueForCharacteristic characteristic: CBCharacteristic,
                    error: NSError?)
    {
        var count: UInt8 = 0;

        if characteristic.uuid == DIRECTION_CHARACTERISTIC_UUID {
            characteristic.value!.copyBytes(to: &count, count: 1)
            countLabel.stringValue = NSString(format: "%llu", count) as String
        }
    }
    
    func centralManager(central: CBCentralManager,
                        didDisconnectPeripheral peripheral: CBPeripheral,
                        error: NSError?)
    {
        central.scanForPeripherals(withServices: nil, options: nil)
    }
    
    @IBAction func pressCell(_ sender: NSTextFieldCell) {
        
    }
    

}

