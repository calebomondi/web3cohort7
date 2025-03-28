// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/utils/Strings.sol";

contract ErrorHandler {
    function riskyOperation(bool shouldfail) public pure returns(uint) {
        if(shouldfail) {
            revert('This operation is risky');
        }

        return 42;
    }

    function demo(bool triggerError) external view  returns (string memory) {
        try this.riskyOperation(triggerError) returns(uint result) {
            return string(abi.encodePacked("Operation was a success: ", Strings.toString(result)));
        } catch Error(string memory reason) {
            return string(abi.encodePacked("Caught Error: ", reason));
        } catch Panic(uint errorCode) {
            return string(abi.encodePacked("Caught Panic: ", Strings.toString(errorCode)));
        } catch (bytes memory lowLevelData) {
            return string(abi.encodePacked("Caught Unknown Error!", string(lowLevelData)));
        }
    }
}