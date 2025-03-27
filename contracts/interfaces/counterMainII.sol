// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import { ICounter } from './ICounter.sol';

contract Counter is ICounter {
    uint256 public count;

    //Increment
    function increment() external {
        count += 1;
    }

    function incrementBy10() external {
        count += 10;
    }

    function incrementBy(uint amount) external {
        count += amount;
    }

    //Decrement
    function decrement() external {
        count -= 1;
    }
}