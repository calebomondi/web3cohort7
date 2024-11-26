// SPDX-License-Identifier: MIT

pragma solidity ^0.8.26;

import './BookStore.sol';

//1. LoyaltyProgram Contract
contract  CustomerPoint is BookStore {

    struct CustomerPoints {
        uint256 points;
    }

    event pointsAdded(address indexed  customer, uint256 points);
 
    mapping (address => CustomerPoints) public  customerewards;

    constructor () BookStore() {}

    function buyBook(uint256 _bookId, uint96 _quantity) public virtual  override payable {
        super.buyBook(_bookId, _quantity);
        addCustomerPoints(msg.sender, msg.value);
    }
    
    function addCustomerPoints (address _customer, uint256 _amount) public {
        uint256 _points;
        uint256 value = 1e18;

        if(_amount < value) {
            _points = 10;
        }
        else if (_amount >= value && _amount < 3*value ){
            _points = 15;
        }
        else if (_amount >= 3*value && _amount < 5*value ){
            _points = 20;
        }
        else if (_amount >= 5*value && _amount < 8*value ){
            _points = 25;
        }
        else if (_amount >= 8*value && _amount < 10*value ){
            _points = 30;
        }

        CustomerPoints memory customer = customerewards[_customer];

        if (customer.points > 0) {
            customerewards[_customer].points += _points;
        } 
        else {
            customerewards[_customer] = CustomerPoints({
                points : _points
            });
        }

        emit pointsAdded(_customer,customerewards[_customer].points);
    } 

    function getCustomerPoints (address _customer) public view returns (uint256) {
        require(customerewards[_customer].points > 0,"Customer Has Not Joined The Loyalty Program!");
        return  customerewards[_customer].points;
    }
}