
import Foundation

protocol BaseButtonStatusProtocol: ActivityIndicatorProtocol {
    @discardableResult
    func setStatus(status: BaseButton.ButtonStatus) -> Self
}
