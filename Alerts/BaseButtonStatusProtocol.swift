//	Created by boris on 03/10/2019.
//	Copyright © 2019 Anonym. All rights reserved.

import Foundation

protocol BaseButtonStatusProtocol: ActivityIndicatorProtocol {
    @discardableResult
    func setStatus(status: BaseButton.ButtonStatus) -> Self
}
