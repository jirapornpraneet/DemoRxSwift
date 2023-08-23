//
//  ViewController.swift
//  DemoRxSwift
//
//  Created by Nut Jiraporn on 23/8/2566 BE.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var labels: [UILabel]!
    var viewModel = ViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        fecthDate()
    }

    func fecthDate() {
        viewModel.requestCurrency { isSuccess in
            if isSuccess {
                self.setupInterface()
            }
        }
    }

    func setupInterface() {
        labels[0].text = viewModel.info?.name
        labels[1].text = viewModel.info?.height
        labels[2].text = viewModel.info?.hairColor
    }
}

