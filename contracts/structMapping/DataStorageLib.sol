// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

library DataStorageLib {
    struct balancesData {
        mapping (address => uint) balances;
    }

    function setBalances (
        balancesData storage _user, 
        address _owner, 
        uint256 _amount
    ) internal {
        _user.balances[_owner] = _amount;
    }

    function getBalances (
        balancesData storage _user, 
        address _owner
    ) internal view returns (uint)  {
        return _user.balances[_owner];
    }

}