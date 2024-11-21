// SPDX-License-Identifier: MIT

pragma solidity ^0.8.26;

import './LoyaltyProgram.sol';

contract CustomerDiscount is CustomerPoint {
    struct Discount {
        address buyer;
        uint percent;
    }

    mapping  (address => Discount) public  customer_discounts;

    constructor () CustomerPoint() {}

    event DiscountAllocated(address indexed customer, uint percent);

    function setDiscount() public  {
        require(customerewards[msg.sender].points > 0, "Customer Has Not Joined The Loyalty Program");  
        
        if(customer_discounts[msg.sender].buyer == address(0)) {
            customer_discounts[msg.sender] = Discount({
                buyer: msg.sender,
                percent: 0
            });
        }

        CustomerPoints memory this_customer = customerewards[msg.sender];

        if(this_customer.points < 100) {
            customer_discounts[msg.sender].percent = 3;
        }
        else if (this_customer.points >= 100 && this_customer.points < 500) {
            customer_discounts[msg.sender].percent = 4;
        }
        else if (this_customer.points >= 500 && this_customer.points < 800) {
            customer_discounts[msg.sender].percent = 5;
        }
        else if (this_customer.points >= 800 && this_customer.points < 1000) {
            customer_discounts[msg.sender].percent = 7;
        }
        else  {
            customer_discounts[msg.sender].percent = 9;
        }

        emit  DiscountAllocated(msg.sender, customer_discounts[msg.sender].percent);
        
    }

    function getDiscountedPrice (uint256 _amount) public view returns (uint256) {
        require(customer_discounts[msg.sender].percent > 0, "This Customer Has No Discounts");
        return _amount - (_amount * customer_discounts[msg.sender].percent + 99)/100;
    }

}