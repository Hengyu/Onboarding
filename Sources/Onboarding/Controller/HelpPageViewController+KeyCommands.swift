//
//  HelpPageViewController+KeyCommands.swift
//
//
//  Created by hengyu on 2020/10/8.
//

import UIKit

extension HelpPageViewController {

    public override var keyCommands: [UIKeyCommand]? {
        let esc = UIKeyCommand(
            input: UIKeyCommand.inputEscape,
            modifierFlags: UIKeyModifierFlags(rawValue: 0),
            action: #selector(dismissPage)
        )
        let backward = UIKeyCommand(
            input: UIKeyCommand.inputLeftArrow,
            modifierFlags: UIKeyModifierFlags(rawValue: 0),
            action: #selector(selectBackwardPage)
        )
        let forward = UIKeyCommand(
            input: UIKeyCommand.inputRightArrow,
            modifierFlags: UIKeyModifierFlags(rawValue: 0),
            action: #selector(selectForwardPage)
        )
        return [esc, backward, forward] + (super.keyCommands ?? [])
    }
}
