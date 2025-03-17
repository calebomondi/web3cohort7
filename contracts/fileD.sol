//SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

import './Storage.sol';

contract  App {
    Storage public storageContract;

    constructor(address _storageAddress) {
        storageContract = Storage(_storageAddress);
    }

    //set values
    function setStoredValue(uint _newValue) external {
        storageContract.setValue(_newValue);
    }

    //get values
    function getStoredValues() public view returns  (uint256)  {
        return storageContract.getValue();
    }
}