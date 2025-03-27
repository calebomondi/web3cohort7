// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

import { ICounter } from './ICounter.sol';

contract MyContract {
    function incrementCounter(address _counter) external {
        ICounter counter = ICounter(_counter);
        counter.increment();
    }

    function incrementCounterBy10(address _counter) external  {
        ICounter(_counter).incrementBy10();
    }

    function incrementBy(address _counter, uint _amount) external  {
        ICounter(_counter).incrementBy(_amount);
    }

    function getCount(address _counter) external view returns (uint256) {
        return ICounter(_counter).count();
    }
}
