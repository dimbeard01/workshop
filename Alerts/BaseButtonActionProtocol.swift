//	Created by boris on 03/10/2019.
//	Copyright © 2019 Anonym. All rights reserved.

import Foundation

protocol BaseButtonActionProtocol {
    var action: (() -> Void)? { get set }
}

extension BaseButtonActionProtocol {
    func sendAction() {
        action?()
    }
}
