// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

import { ICounter } from './ICounter.sol';

contract MyContract {
    ICounter public  icounter;

    constructor(ICounter _icounter) {
        icounter = _icounter;
    }

    function incrementCounter() external {
        icounter.increment();
    }

    function incrementCounterBy10() external  {
        icounter.incrementBy10();
    }

    function incrementBy(uint _amount) external  {
        icounter.incrementBy(_amount);
    }

    function getCount() external view returns (uint256) {
        return icounter.count();
    }
}
