//
//  ViewController.swift
//  Lec1RxSwift
//
//  Created by Eman Khaled on 26/09/2023.
//

import UIKit
import RxSwift
import RxCocoa
class ViewController: UIViewController {
let disposeBag = DisposeBag()
    @IBOutlet weak var segmentControl: UISegmentedControl!
    
    @IBOutlet weak var myTextField: UITextField!
    @IBOutlet weak var myLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let _: Observable<Int> = Observable<Int>.just(1)
        let observable2: Observable<String> = Observable.create{ observer in
            observer.onNext("1")
           observer.onNext("2")
           observer.onCompleted()
           observer.onNext("3")
           return Disposables.create()
    
        }
        observable2.subscribe{ value in
            print(value)
        }onCompleted: {
            print("onCompleted")
        }onDisposed: {
            print("onDisposed")
        }
        segmentControl.rx.selectedSegmentIndex.subscribe{ [weak self] index in
            guard let self = self else {return}
            if index == 0{
                print("First")
              //  self.myLabel.text = "First"
            }else {
                print("Second")
                //self.myLabel.text = "Second"
            }
        }.disposed(by: disposeBag)
        myTextField.rx.text.subscribe{ [weak self] text in
            guard let self = self else {return}
            self.myLabel.text = text
        }.disposed(by: disposeBag)
    }


}

