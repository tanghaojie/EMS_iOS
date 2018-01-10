//
//  JTPickerViewController.swift
//  JTiOS
//
//  Created by JT on 2017/12/27.
//  Copyright © 2017年 JT. All rights reserved.
//

import UIKit

class JTPickerViewController: UIViewController {

    private var member: [DisplayValueObject] = [DisplayValueObject]()
    private var handler: ((DisplayValueObject) -> Void)?
    @IBOutlet private weak var pickView: UIPickerView!

    override func viewDidLoad() {
        super.viewDidLoad()
        pickView.delegate = self
        pickView.dataSource = self
    }
    @IBAction private func confirmTouchUpInside(_ sender: Any) {
        let sInt = pickView.selectedRow(inComponent: 0)
        let data = member[sInt]
        if let h = handler {
            h(data)
        }
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction private func cancelTouchUpInside(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    func setup(member: [DisplayValueObject], selectedHandler: ((DisplayValueObject) -> Void)? = nil) {
        self.member = member
        self.handler = selectedHandler
    }
}

extension JTPickerViewController: UIPickerViewDelegate {
    internal func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return member[row].display
    }
}

extension JTPickerViewController: UIPickerViewDataSource {
    internal func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    internal func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return member.count
    }
}
