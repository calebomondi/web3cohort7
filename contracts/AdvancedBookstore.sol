// SPDX-License-Identifier: MIT

pragma solidity ^0.8.26;

import './BookStore.sol';

contract AdvancedBookstore is BookStore  {
    mapping (uint256 => bool) public bestseller;

    event BookMarkedAsBestSeller(uint256 indexed bookId);

    constructor (address _owner) BookStore() {}

    function markBookAsBestSeller(uint256 bookId) public onlyOwner {
        require(books[bookId].price != 0,"This Book Does Not Exist!");
        bestseller[bookId] = true;
        emit BookMarkedAsBestSeller(bookId);
    }

    function isBestSeller(uint256 bookId) public view returns (bool) {
        return bestseller[bookId];
    }

    //remove book is in my main contract

 }