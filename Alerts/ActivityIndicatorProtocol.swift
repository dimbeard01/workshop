//	Created by boris on 03/10/2019.
//	Copyright © 2019 Anonym. All rights reserved.

import Foundation
import UIKit

protocol ActivityIndicatorProtocol {
    var activityIndicatorView: UIActivityIndicatorView { get }
    
    func showActivityIndicator()
    func hideActivityIndicator()
}
