
import Foundation

protocol BaseButtonActionProtocol {
    var action: (() -> Void)? { get set }
}

extension BaseButtonActionProtocol {
    func sendAction() {
        action?()
    }
}
