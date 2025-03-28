// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract CallData {
    struct Person {
        string name;
        uint256 age;
    }
    
    function processNumbers(
        uint[] calldata numbers
    ) external pure returns(uint sum, uint avg) {
        for(uint i; i < numbers.length; i++) {
            sum += numbers[i];
        }

        avg = sum / numbers.length;

        return (sum, avg);
    }

    function processPersonData(
        Person calldata person
    ) external pure returns (string memory, bool isAdult) {
        isAdult = person.age >= 18;
        return (person.name, isAdult);
    }
}