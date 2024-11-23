// SPDX-License-Identifier: MIT

pragma solidity ^0.8.26;

import "@openzeppelin/contracts/access/Ownable.sol";

contract BookStore  is Ownable {
    uint256 private totalBooksSold;

    constructor() Ownable (msg.sender) {}

    struct Book {
        uint256 stock;
        uint256 price;
        bool isAvailable;
        string title;
        string author;
    }

    //mapping using bookId to the book
    mapping(uint256 => Book) public books;
    uint256[] public bookIds;

    event BookAdded(uint256 indexed bookId, string title, string author, uint256 price, uint256 stock);
    event BookPurchased(uint256 bookId, address indexed buyer, uint256 quantity);
    event BookRemoved(uint256 indexed bookId);
    event BookBatchRemoved(uint256[] bookIds);


    function addBook(uint256 _bookId, string memory _title, string memory _author, uint256 _stock, uint256 _price) public {
        require(books[_bookId].price == 0, "CANNOT ADD BOOK IT ALREADY EXISTS");
        books[_bookId] = Book({
            stock: _stock,
            price: _price,
            isAvailable: _stock > 0,
            title: _title,
            author: _author
        });
        bookIds.push(_bookId);
        emit BookAdded(_bookId, _title, _author, _stock, _price);
    }

    // 1. Get all books function
    function getAllBooks() public view returns (uint256[] memory) {
        return bookIds;
    }

    // 2. Remove multiple books function
    function removeBooks(uint256[] memory _bookIds) public onlyOwner {
        for (uint256 i = 0; i < _bookIds.length; i++) {
            uint256 bookId = _bookIds[i];
            require(books[bookId].price != 0, "Book does not exist");
            delete books[bookId];
            
            // Remove from bookIds array
            for (uint256 j = 0; j < bookIds.length; j++) {
                if (bookIds[j] == bookId) {
                    bookIds[j] = bookIds[bookIds.length - 1];
                    bookIds.pop();
                    break;
                }
            }
        }
        emit BookBatchRemoved(_bookIds);
    }

    // 3. Remove a single book function
    function removeBook(uint256 _bookId) public onlyOwner {
        require(books[_bookId].price != 0, "Book does not exist");
        delete books[_bookId];
        
        // Remove from bookIds array
        for (uint256 i = 0; i < bookIds.length; i++) {
            if (bookIds[i] == _bookId) {
                bookIds[i] = bookIds[bookIds.length - 1];
                bookIds.pop();
                break;
            }
        }
        emit BookRemoved(_bookId);
    }

    // 4. Check owner balance
    function getOwnerBalance() public view returns (uint256) {
        return address(owner()).balance;
    }

    // 5. Get total number of books sold
    function getTotalBooksSold() public view returns (uint256) {
        return totalBooksSold;
    }

    function getBooks(uint256 _bookId) public view returns (string memory, string memory, uint256, uint256, bool) {
        Book memory book = books[_bookId];
        return (book.title, book.author, book.price, book.stock, book.isAvailable);
    }

    function buyBook(uint256 _bookId, uint256 _quantity) public  payable {
        Book storage book = books[_bookId];
        require(book.isAvailable, "This book is not available");
        require(book.stock >= _quantity, "Not enough stock available");
        require(msg.value == book.price * _quantity, "Incorrect payment amount");
        
        // Decrease stock and update availability
        book.stock -= _quantity;
        if (book.stock == 0) {
            book.isAvailable = false;
        }
        
        // Update total books sold
        totalBooksSold += _quantity;
        
        // Transfer payment to the owner
        payable(owner()).transfer(msg.value);
        emit BookPurchased(_bookId, msg.sender, _quantity);
    }
}

