//
//  GestureViewController.swift
//  Toonie
//
//  Created by 박은비 on 23/03/2019.
//  Copyright © 2019 Yapp. All rights reserved.
//

import UIKit

///모든 뷰 컨트롤러는 GestureViewController를 상속받음.
class GestureViewController: UIViewController {
    
    ///viewwillAppear 호출시 꼭 super 넣어줄것
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //스와이프제스쳐로 뒤로가기 허용
        navigationController?.interactivePopGestureRecognizer?.delegate = nil
 
//        CommonUtility.analytics(eventName: NSStringFromClass(type(of: self)),
//                                param: nil)
        
    }
    
}
