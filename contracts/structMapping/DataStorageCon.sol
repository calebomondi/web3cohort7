// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import  {DataStorageLib} from './DataStorageLib.sol';

contract DataStorageContract {
    using DataStorageLib for DataStorageLib.balancesData;

    DataStorageLib.balancesData private balances;

    function setUserBalances(uint _amount) external  {
        balances.setBalances(msg.sender, _amount);
    }

    function getUserBalances() external  view returns (uint){
        return balances.getBalances(msg.sender);
    }

}