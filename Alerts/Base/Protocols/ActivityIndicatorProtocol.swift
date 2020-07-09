
import Foundation
import UIKit

protocol ActivityIndicatorProtocol {
    var activityIndicatorView: UIActivityIndicatorView { get }
    
    func showActivityIndicator()
    func hideActivityIndicator()
}
