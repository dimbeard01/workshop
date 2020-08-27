//
//  UserRewardModel.swift
//  Alerts
//
//  Created by Dima on 21.08.2020.
//  Copyright © 2020 Dima. All rights reserved.
//

import UIKit

protocol RewardModel {
    var name: String { get set }
    var photo: UIImage { get set }
    var event: UserEvent { get set }
    var rewardTimeReceiving: Int { get set }
    var reward: Reward { get set }
}

struct UserReward: RewardModel {
    var name: String
    var photo: UIImage
    var event: UserEvent
    var rewardTimeReceiving: Int
    var reward: Reward
}

struct AnonUserReward: RewardModel {
    var name: String = "Anonym"
    var photo: UIImage = UIImage(named: "anonCoin")!.withTintColor(Styles.Colors.Palette.gray4) //change this later!
    var event: UserEvent
    var rewardTimeReceiving: Int
    var reward: Reward
}
