// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {DataTypes} from './dataTypes.sol';
import {UpdateBalance} from './updateBalance.sol';

contract MappingExample {
    mapping(address => DataTypes.User) private users;
    mapping(uint256 => address) private userIndex;

    constructor() {
        // Initialize some dummy users
        users[msg.sender] = DataTypes.User(100, true);
        userIndex[0] = msg.sender;
    }

    // External function calls internal function with mappings
    function updateUserBalance(address user, uint256 newBalance) external {
        UpdateBalance.updateUserBalance(users, user, newBalance);
    }

    // View function to check balance
    function getUserBalance(address user) external view returns (uint256) {
        return users[user].balance;
    }
}
