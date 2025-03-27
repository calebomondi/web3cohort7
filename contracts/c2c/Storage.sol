//SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

contract Storage {
    uint256 private value;

    //set value
    function setValue(uint256 _newValue) external {
        value = _newValue;
    }

    //get value
    function getValue() public view returns (uint) {
        return value;
    }
}