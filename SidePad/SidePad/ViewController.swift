//
//  ViewController.swift
//  SidePad
//
//  Created by Роман Гах on 06.04.2020.
//  Copyright © 2020 Роман Гах. All rights reserved.
//

import UIKit
import CoreBluetooth

let PERIPHERAL_NAME = "SPPeriferal"
let SWIPE_SERVICE_UUID = CBUUID.init(string: "C43F7DE2-644D-46C5-B0CF-2DBCA3E6390E")
let DIRECTION_CHARACTERISTIC_UUID = CBUUID.init(string: "096839B6-2D43-403E-8CF2-4ADA498EB4D2")

let Stand = UInt8(0)
let Left = UInt8(1)
let Up = UInt8(2)
let Right = UInt8(3)
let Down = UInt8(4)

class ViewController: UIViewController, CBPeripheralManagerDelegate {
    
    @IBOutlet weak var swipeLabel: UILabel!
    
    var peripheralManager : CBPeripheralManager!
    var swipeDirection = UInt8(0)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        swipeDirection = Stand
        swipeObservers()
        peripheralManager = CBPeripheralManager(delegate: self, queue: nil)
    }

    func swipeObservers() {
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(gestureHandler))
        swipeRight.direction = .right
        swipeDirection = Right
        self.view.addGestureRecognizer(swipeRight)
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(gestureHandler))
        swipeLeft.direction = .left
        swipeDirection = Left
        self.view.addGestureRecognizer(swipeLeft)
        
        let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(gestureHandler))
        swipeUp.direction = .up
        swipeDirection = Up
        self.view.addGestureRecognizer(swipeUp)
        
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(gestureHandler))
        swipeDown.direction = .down
        swipeDirection = Down
        self.view.addGestureRecognizer(swipeDown)
    }

    @objc func gestureHandler(gesture: UISwipeGestureRecognizer) {
        switch gesture.direction {
        case .right:
            swipeLabel.text = "Right"
        case .left:
            swipeLabel.text = "Left"
        case .up:
            swipeLabel.text = "Up"
        case .down:
            swipeLabel.text = "Down"
        default:
            break
        }
    }
    
    // MARK: Bluetooth
    
    func peripheralManagerDidUpdateState(_ peripheral: CBPeripheralManager) {
        switch peripheral.state {
            case .unknown:
                print("Bluetooth Device is unknown")
            case .unsupported:
                print("Bluetooth Device is unsupported")
            case .unauthorized:
                print("Bluetooth Device is unauthorized")
            case .resetting:
                print("Bluetooth Device is resetting")
            case .poweredOff:
                print("Bluetooth Device is powered OFF")
            case .poweredOn:
                print("Bluetooth Device is powered ON")
                print("Peripheral name ")
                addServices()
            default:
                print("Unknown State")
            }
    }
        
    func addServices() {
        let valueData = Data(base64Encoded: String(swipeDirection))

        // 1. Create instance of CBMutableCharcateristic
        let swipeDirection = CBMutableCharacteristic(
                                type: DIRECTION_CHARACTERISTIC_UUID,
                                properties: [.notify, .read],
                                value: valueData,
                                permissions: [.readable])
        
        // 2. Create instance of CBMutableService
        let myService = CBMutableService(type: SWIPE_SERVICE_UUID, primary: true)
        
        // 3. Add characteristics to the service
        myService.characteristics = [swipeDirection]
        
        // 4. Add service to peripheralManager
        peripheralManager.add(myService)
        
        // 5. Start advertising
        startAdvertising()
    }
    
    func startAdvertising() {
        peripheralManager.startAdvertising(
            [CBAdvertisementDataLocalNameKey : PERIPHERAL_NAME,
             CBAdvertisementDataServiceUUIDsKey : SWIPE_SERVICE_UUID])

        print("Started Advertising")
    }
}

