//
//  UserRewardModel.swift
//  Alerts
//
//  Created by Dima on 21.08.2020.
//  Copyright © 2020 Dima. All rights reserved.
//

import UIKit

protocol RewardModel {
    var name: String { get }
    var photo: UIImage { get }
    var event: UserEvent { get }
    var rewardTimeReceiving: Int { get }
    var reward: Reward { get }
}

struct UserReward: RewardModel {
    let name: String
    let photo: UIImage
    let event: UserEvent
    let rewardTimeReceiving: Int
    let reward: Reward
}

struct AnonUserReward: RewardModel {
    let name: String = "Anonym"
    let photo: UIImage = UIImage(named: "anonCoin")!.withTintColor(Styles.Colors.Palette.gray4) //change this later!
    let event: UserEvent
    let rewardTimeReceiving: Int
    let reward: Reward
}
