// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Counter {
    uint256 public count;

    function increment() external {
        count += 1;
    }

    function incrementBy10() external {
        count += 10;
    }

    function incrementBy(uint amount) external {
        count += amount;
    }
}