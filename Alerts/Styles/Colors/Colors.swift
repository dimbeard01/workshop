
import UIKit

extension Styles.Colors {
    static var randomColor: UIColor {
        return [Palette.error1,
                Palette.secondary1,
                Palette.primary1,
                Palette.success1].randomElement() ?? .white
    }
}
