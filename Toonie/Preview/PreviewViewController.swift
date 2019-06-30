//
//  PreviewViewController.swift
//  Toonie
//
//  Created by 이재은 on 26/05/2019.
//  Copyright © 2019 Yapp. All rights reserved.
//

import UIKit

// 툰 컬렉션뷰셀 3d touch했을 때, 프리뷰하는 뷰컨
final class PreviewViewController: UIViewController {
    
    // MARK: - Properties
    
    var toonID: String?
    var imageUrl: String?
    var isFavorite: Bool?
    
    override var previewActionItems: [UIPreviewActionItem] {
        return previewActions()
    }
    
    // MARK: - IBOutlets
    
    @IBOutlet private weak var previewImageView: UIImageView!
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setImage()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        CommonUtility.analytics(eventName: "PreviewViewController",
                                param: ["token": (CommonUtility.getUserToken() ?? "toonie") + (toonID ?? "") ])
    }
    
    // MARK: - Functions
    
    private func previewActions() -> [UIPreviewActionItem] {
        let actionTitle = isFavorite ?? false ? "찜하기 취소" : "찜하기"
        let previewFirstAction = UIPreviewAction
            .init(title: actionTitle, style: .default) { [weak self] (_, _) in
                let body = [
                    "workListName": "default",
                    "workListInfo": "찜한 목록",
                    "toonId": self?.toonID
                ]
                
                FavoriteService.shared
                    .postFavoriteToon(params: body as [String: Any],
                                      completion: {
                                        if self?.isFavorite ?? false {
                                            print("Success to delete favorite toon")
                                        } else {
                                            print("Success to add favorite toon")
                                        }
                    })
        }
        return [previewFirstAction]
    }
    
    private func setImage() {
        self.previewImageView.imageFromUrl(imageUrl, defaultImgPath: "dum2")
        self.previewImageView.image = self.previewImageView.image?
            .resize(newWidth: UIScreen.main.bounds.width)
    }
}
