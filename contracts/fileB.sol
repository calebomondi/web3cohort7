//SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

library StringUtils {
    function concat(string memory a, string memory b) public pure returns (string memory) {
        return string(abi.encodePacked(a, b));
    }

    function compare(string memory a, string memory b) public pure returns (bool){
        return keccak256(abi.encodePacked(a, b)) == keccak256(abi.encodePacked(b, a));
    }
}

library ArrayUtils {
    function contains(uint[] memory array, uint value) public pure returns (bool) {
        for(uint i; i < array.length; i++){
            if(array[i] == value) {
                return true;
            }
        }

        return false;
    }

    function double(uint number) public pure returns (uint256){
        return 2 * number;
    }

    function square(uint number) public pure returns (uint256) {
        return  number * number;
    }
}