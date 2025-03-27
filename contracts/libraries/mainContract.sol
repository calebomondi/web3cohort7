//SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

import  { StringUtils, ArrayUtils as AU } from './library.sol';

contract Main {
    //using 
    using StringUtils for string;
    using AU for uint;

    string public hi = 'hello';
    uint public num = 3;

    //compare examples
    function compare(string memory _s2) public view  returns (bool){
        return hi.compare(_s2);
    }

    function concatString() public view  returns (string memory ){
        return hi.concat(' world'); 
    }

    function compute() public  view returns (uint256, uint256){
        uint doubleNumber = num.double();
        uint squareNumber = num.square();
        
        return (doubleNumber, squareNumber);
    }

    //join strings
    function joinStrings(string memory _a, string memory _b) public pure returns (string memory){
        return StringUtils.concat(_a,_b);
    }

    //find if value in array
    function containsValue( uint[] memory _values, uint _a) public pure returns (bool){
        return AU.contains(_values, _a);
    }
}