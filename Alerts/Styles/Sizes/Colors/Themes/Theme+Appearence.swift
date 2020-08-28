
import UIKit

extension Theme {
    struct Appearence: Equatable {
        let barStyle: UIBarStyle
        let blurEffectStyle: UIBlurEffect.Style
        let keyboardAppearence: UIKeyboardAppearance
        let statusBarStyle: UIStatusBarStyle
        let scrollViewIndicatorStyle: UIScrollView.IndicatorStyle
        
        static let light = Appearence(
            barStyle: .default,
            blurEffectStyle: .light,
            keyboardAppearence: .default,
            statusBarStyle: .default,
            scrollViewIndicatorStyle: .black
        )
        
        static let dark = Appearence(
            barStyle: .black,
            blurEffectStyle: .dark,
            keyboardAppearence: .dark,
            statusBarStyle: .lightContent,
            scrollViewIndicatorStyle: .white
        )
    }
}
