
import UIKit

extension Styles.Fonts {
    static let LargeTitle = Font.bold(40)
    static let MediumTitle = Font.bold(34)
    static let Title = Font.bold(28)
    static let SubTitle = Font.light(24)
    
    static let Headline1 = Font.bold(20)
    static let Headline2 = Headline1.regular()
    
    static let Body1 = Font.semibold(17)
    static let Body2 = Body1.regular()
    
    static let Subhead1 = Font.semibold(15)
    static let Subhead2 = Subhead1.regular()
    
    static let Caption1 = Font.semibold(13)
    static let Caption2 = Caption1.regular()
    static let Caption3 = Font.regular(11)
    
    static let SubCaption1 = Font.semibold(10)
    static let SubCaption2 = SubCaption1.regular()
    
    static let Tagline1 = Font.semibold(15)
    static let Tagline2 = Font.semibold(13)
    static let Tagline3 = Font.semibold(11)
    
    static let Button1 = Font.semibold(15)
    static let Button2 = Button1.regular()
}

extension UIFont {
    func regular() -> UIFont {
        let pointSize = self.pointSize
        return Font.regular(pointSize)
    }
    
    func medium() -> UIFont {
        let pointSize = self.pointSize
        return Font.medium(pointSize)
    }
    
    func semibold() -> UIFont {
        let pointSize = self.pointSize
        return Font.semibold(pointSize)
    }
    
    func bold() -> UIFont {
        let pointSize = self.pointSize
        return Font.bold(pointSize)
    }
    
    func light() -> UIFont {
        let pointSize = self.pointSize
        return Font.light(pointSize)
    }
    
    func semiboldItalic() -> UIFont {
        let pointSize = self.pointSize
        return Font.semiboldItalic(pointSize)
    }
    
    func italic() -> UIFont {
        let pointSize = self.pointSize
        return Font.italic(pointSize)
    }
}
