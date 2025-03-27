// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface ICounter {
    //functions
    function count() external view returns (uint);
    function increment() external;
    function incrementBy10() external;
    function incrementBy(uint _amount) external;
    function decrement() external;

    //events
    event IncrementedTo(uint newAmount);
}