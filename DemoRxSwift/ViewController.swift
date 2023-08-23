//
//  ViewController.swift
//  DemoRxSwift
//
//  Created by Nut Jiraporn on 23/8/2566 BE.
//

import UIKit
import RxSwift

class ViewController: UIViewController {

    @IBOutlet var labels: [UILabel]!

    var viewModel = ViewModel()
    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        //subscribe ก่อนที่จะส่งของเข้ามา
        setObservable()
        viewModel.requestCurrency()
    }

    func setObservable() {
        //ทำการ subscribe รอค่าเข้ามาหลังจาก isDataReady ส่ง OnNext มา
        viewModel.isDataReady.asObservable().withUnretained(self)
            .subscribe(onNext: { owner, _ in
                //เมื่อส่ง OnNext มา อยากให้ทำอะไรต่อ
            owner.setupInterface()
        }).disposed(by: disposeBag)

        //ทำการ subscribe รอค่าเข้ามาหลังจาก error ส่ง OnNext มา
        viewModel.error.asObserver().subscribe(onNext:{ [weak self] error in
           //error แล้ว อยากให้แสดงอะไรต่อ
        }).disposed(by: disposeBag)
    }

    func setupInterface() {
        labels[0].text = viewModel.info?.name
        labels[1].text = viewModel.info?.height
        labels[2].text = viewModel.info?.hairColor
    }
}

