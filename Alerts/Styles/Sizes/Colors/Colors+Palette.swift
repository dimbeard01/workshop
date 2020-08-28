
import UIKit

//Palette
extension Styles.Colors {
    enum Palette {
        // Primary
        static let primary1: UIColor = #colorLiteral(red: 0.184, green: 0.502, blue: 0.929, alpha: 1)
        static let primary2: UIColor = #colorLiteral(red: 0.329, green: 0.592, blue: 0.941, alpha: 1)
        static let primary3: UIColor = #colorLiteral(red: 0.627, green: 0.773, blue: 0.965, alpha: 1)
        
        // Secondary
        static let secondary1: UIColor = #colorLiteral(red: 0.153, green: 0.412, blue: 0.761, alpha: 1)
        static let secondary2: UIColor = #colorLiteral(red: 0.306, green: 0.518, blue: 0.804, alpha: 1)
        static let secondary3: UIColor = #colorLiteral(red: 0.537, green: 0.678, blue: 0.867, alpha: 1)
        
        // Success
        static let success1: UIColor = #colorLiteral(red: 0.153, green: 0.682, blue: 0.376, alpha: 1)
        static let success2: UIColor = #colorLiteral(red: 0.38, green: 0.769, blue: 0.545, alpha: 1)
        static let success3: UIColor = #colorLiteral(red: 0.612, green: 0.855, blue: 0.714, alpha: 1)
        
        // Error
        static let error1: UIColor = #colorLiteral(red: 0.922, green: 0.341, blue: 0.341, alpha: 1)
        static let error2: UIColor = #colorLiteral(red: 0.941, green: 0.518, blue: 0.518, alpha: 1)
        static let error3: UIColor = #colorLiteral(red: 0.961, green: 0.698, blue: 0.698, alpha: 1)
        
        // Black
        static let black: UIColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        static let black0: UIColor = #colorLiteral(red: 0.078, green: 0.094, blue: 0.137, alpha: 1)
        
        // White
        static let white: UIColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        static let white0: UIColor = #colorLiteral(red: 0.945, green: 0.949, blue: 0.961, alpha: 1)
        
        // Gray
        static let gray1: UIColor = #colorLiteral(red: 0.106, green: 0.125, blue: 0.169, alpha: 1)
        static let gray2: UIColor = #colorLiteral(red: 0.161, green: 0.192, blue: 0.263, alpha: 1)
        static let gray3: UIColor = #colorLiteral(red: 0.173, green: 0.282, blue: 0.373, alpha: 1)
        static let gray4: UIColor = #colorLiteral(red: 0.369, green: 0.463, blue: 0.592, alpha: 1)
        static let gray5: UIColor = #colorLiteral(red: 0.62, green: 0.675, blue: 0.761, alpha: 1)
        static let gray6: UIColor = #colorLiteral(red: 0.812, green: 0.835, blue: 0.878, alpha: 1)
        
        // Logo
        static let logo1: UIColor = #colorLiteral(red: 0.227, green: 0.302, blue: 0.561, alpha: 1)
        static let logo2: UIColor = #colorLiteral(red: 0.937, green: 0.729, blue: 0.827, alpha: 1)
        
        // Backgrounds overlay
        static let bgLightOverlay: UIColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.92)
        static let bgDarkOverlay: UIColor = #colorLiteral(red: 0.161, green: 0.192, blue: 0.263, alpha: 0.92)
        
        // Backgrounds
        static let bgLight: UIColor = #colorLiteral(red: 0.867, green: 0.878, blue: 0.898, alpha: 1)
        static let bgDark: UIColor = #colorLiteral(red: 0.122, green: 0.145, blue: 0.196, alpha: 1)
        
        // Сolors
        static let green1: UIColor = #colorLiteral(red: 0.1019607843, green: 0.737254902, blue: 0.6117647059, alpha: 1)
        static let pink1: UIColor = #colorLiteral(red: 0.9294117647, green: 0.2980392157, blue: 0.4039215686, alpha: 1)
        static let purple1: UIColor = #colorLiteral(red: 0.7529411765, green: 0.4392156863, blue: 1, alpha: 1)
        static let orange1: UIColor = #colorLiteral(red: 0.9450980392, green: 0.5294117647, blue: 0.003921568627, alpha: 1)
        
        // UniqueAvatar
        static let avatarPurple1: UIColor = #colorLiteral(red: 0.462745098, green: 0.1098039216, blue: 0.9176470588, alpha: 1)
        static let avatarOrange1: UIColor = #colorLiteral(red: 0.9647058824, green: 0.3215686275, blue: 0.1803921569, alpha: 1)
        
        static let avatarPurple2: UIColor = #colorLiteral(red: 0.4705882353, green: 0.1843137255, blue: 0.937254902, alpha: 1)
        static let avatarPink1: UIColor = #colorLiteral(red: 0.937254902, green: 0.1843137255, blue: 0.6352941176, alpha: 1)
        static let avatarYellow1: UIColor = #colorLiteral(red: 0.9843137255, green: 1, blue: 0, alpha: 1)

        
        static let avatarBlue1: UIColor = #colorLiteral(red: 0, green: 0.4588235294, blue: 1, alpha: 1)
        static let avatarGreen1: UIColor = #colorLiteral(red: 0, green: 1, blue: 0.6392156863, alpha: 1)
        
        static let avatarPink2: UIColor = #colorLiteral(red: 1, green: 0, blue: 0.5450980392, alpha: 1)

        static let avatarGreen2: UIColor = #colorLiteral(red: 0.137254902, green: 0.5960784314, blue: 0.6705882353, alpha: 1)
        static let avatarGreen3: UIColor = #colorLiteral(red: 0.2705882353, green: 0.8156862745, blue: 0.6196078431, alpha: 1)
        
        static let avatarGreen4: UIColor = #colorLiteral(red: 0.2941176471, green: 0.7058823529, blue: 0.3843137255, alpha: 1)
        static let avatarGreen5: UIColor = #colorLiteral(red: 0.3568627451, green: 1, blue: 0.3843137255, alpha: 1)

    }
}

extension Styles.Colors.Palette {
    // Dividers
    static let dividerDark: UIColor = #colorLiteral(red: 0.369, green: 0.463, blue: 0.592, alpha: 0.25)
    static let dividerLight: UIColor = #colorLiteral(red: 0.62, green: 0.675, blue: 0.761, alpha: 0.25)
}
