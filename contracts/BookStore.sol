// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

import "@openzeppelin/contracts/access/Ownable.sol";

contract BookStore is Ownable {
    struct Book {
        uint96 stock;       
        uint96 price;       
        bool isAvailable;
        string title;
        string author;
    }

    mapping(uint256 => Book) public books;
    mapping(address => bool) public subscribers;
    uint256[] private bookIds;
    uint96 private totalBooksSold;  

    event BookAdded(uint256 indexed bookId, string title, string author, uint96 price, uint96 stock);
    event BookPurchased(uint256 indexed bookId, address indexed buyer, uint96 quantity);
    event BookRemoved(uint256 indexed bookId);
    event BookBatchRemoved(uint256[] bookIds);
    event SubscriptionAdded(address indexed subscriber);       
    event SubscriptionRemoved(address indexed subscriber);

    constructor() Ownable(msg.sender) {}

    function addBook(uint256 _bookId, string calldata _title, string calldata _author, uint96 _stock, uint96 _price) external {
        require(books[_bookId].price == 0, "Book exists");
        books[_bookId] = Book({
            stock: _stock,
            price: _price * 1 ether,
            isAvailable: _stock > 0,
            title: _title,
            author: _author
        });
        bookIds.push(_bookId);
        emit BookAdded(_bookId, _title, _author, _price, _stock);
    }
    
    // 1. Get all books function
    function getAllBooks() external view returns (string[] memory) {
        string[] memory titles = new string[](bookIds.length);
        for (uint256 i; i < bookIds.length;){
            Book storage book = books[bookIds[i]];
            titles[i] = book.title;
            unchecked { i++; }
        }
        return titles;
    }
    
    // 2. Remove multiple books function
    function removeBooks(uint256[] calldata _bookIds) external onlyOwner {
        uint256 length = _bookIds.length;
        for (uint256 i; i < length;) {
            //Remove book from mapping
            uint256 bookId = _bookIds[i];
            require(books[bookId].price != 0, "Book not exist");
            delete books[bookId];
            
            // Remove  bookId from bookIds array
            for (uint256 j; j < bookIds.length;) {
                if (bookIds[j] == bookId) {
                    bookIds[j] = bookIds[bookIds.length - 1];
                    bookIds.pop();
                    break;
                }
                unchecked { ++j; }
            }
            unchecked { ++i; }
        }
        emit BookBatchRemoved(_bookIds);
    }

    // 3. Remove a single book function
    function removeBook(uint256 _bookId) external onlyOwner {
        require(books[_bookId].price != 0, "Book not exist");
        delete books[_bookId];
        
        for (uint256 i; i < bookIds.length;) {
            if (bookIds[i] == _bookId) {
                bookIds[i] = bookIds[bookIds.length - 1];
                bookIds.pop();
                break;
            }
            unchecked { ++i; }
        }
        emit BookRemoved(_bookId);
    }
    
    // 4. Check owner balance
    function getOwnerBalance() external view returns (uint256) {
        return address(owner()).balance;
    }

    // 5. Get total number of books sold
    function getTotalBooksSold() external view returns (uint96) {
        return totalBooksSold;
    }

    function getBooks(uint256 _bookId) external view returns (string memory title, string memory author, uint96 price, uint96 stock, bool isAvailable) {
        Book storage book = books[_bookId];
        return (book.title, book.author, book.price, book.stock, book.isAvailable);
    }

    function buyBook(uint256 _bookId, uint96 _quantity) public  virtual  payable {
        Book storage book = books[_bookId];
        require(book.isAvailable, "Not available");
        require(book.stock >= _quantity, "Not enough stock");
        require(msg.value == book.price * _quantity, "Wrong payment");
        
        unchecked {
            book.stock -= _quantity;
            totalBooksSold += _quantity;
        }
        
        book.isAvailable = book.stock > 0;
        payable(owner()).transfer(msg.value);
        emit BookPurchased(_bookId, msg.sender, _quantity);
    }

    // Subscriptions Assignment
    function Subscribe(address _customer) public {
        require(!subscribers[_customer],"Customer Is Already Subscribed!");
        subscribers[_customer] = true;
        emit SubscriptionAdded(_customer);
    }

    function Unsubcribe(address _customer) public {
        require(subscribers[_customer], "Customer Is Not Subscribed!");
        delete subscribers[_customer];
        emit SubscriptionRemoved(_customer);
    }

    function checkIfSubscribed(address _customer) public view returns (bool) {
        require(subscribers[_customer], "Customer Is Not Subscribed!");
        return  subscribers[_customer];
    }
}