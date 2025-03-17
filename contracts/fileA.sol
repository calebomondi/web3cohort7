//SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

import  { StringUtils, ArrayUtils as AU } from './fileB.sol';

contract Main {
    //join strings
    function joinStrings(string memory _a, string memory _b) public pure returns (string memory){
        return StringUtils.concat(_a,_b);
    }

    //find if value in array
    function containsValue( uint[] memory _values, uint _a) public pure returns (bool){
        return AU.contains(_values, _a);
    }
}