// SPDX-License-Identifier: MIT

pragma solidity ^0.8.26;

import './Bookstore.sol';

contract  CustomerPoint is BookStore {

    struct CustomerPoints {
        address buyer;
        uint256 points;
    }

    event pointsAdded(address indexed  customer, uint256 points);
 
    mapping (address => CustomerPoints) public  customerewards;

    constructor () BookStore() {}

    function buyBook(uint256 _bookId, uint256 _quantity, uint256 _amount) public virtual override payable {
        super.buyBook(_bookId,_quantity,_amount);

        addCustomerPoints(msg.sender,_amount);
    }
    
    function addCustomerPoints (address _customer, uint256 _amount) public {
        uint256 _points;

        if(_amount < 1000) {
            _points = 10;
        }
        else if (_amount >= 1000 && _amount < 2500 ){
            _points = 15;
        }
        else if (_amount >= 2500 && _amount < 5000 ){
            _points = 20;
        }
        else if (_amount >= 5000 && _amount < 7500 ){
            _points = 25;
        }
        else if (_amount >= 7500 && _amount < 10000 ){
            _points = 30;
        }

        CustomerPoints memory customer = customerewards[_customer];

        if (customer.points > 0) {
            customerewards[_customer].points += _points;
        } 

        if(customerewards[_customer].buyer == address(0)) {
            customerewards[_customer] = CustomerPoints({
                buyer : _customer,
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