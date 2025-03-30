// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {DataTypes} from './dataTypes.sol';

library UpdateBalance {
    function updateUserBalance(
        mapping(address => DataTypes.User) storage _users,
        address user,
        uint256 newBalance
    ) external  {
        require(_users[user].isActive, "User is not active");
        _users[user].balance = newBalance;
    }
}