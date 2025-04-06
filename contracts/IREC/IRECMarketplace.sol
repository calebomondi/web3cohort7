// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/IERC721.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract IRECMarketplace is Ownable {
    //initialize NFT and Token
    IERC20 public fractionToken;
    IERC721 public nftContract;

    // Price per token in ETH
    uint256 public salePrice; 
    
    // Determine if tokens are up for sale
    bool public saleActive = true;

    //Track ownership of tokens
    struct Ownership {
        address from;
        address to;
        uint256 amount;
    }
    mapping (string => Ownership[]) public ownerships;
    
    event PurchasedFractionalTokens(uint256 indexed fractionTokenIndex, address sellerAddress, uint256 amountMinted);

    constructor(
        IERC20 _fractionToken,  
        IERC721 _nftContract
    ) Ownable(msg.sender) {
        fractionToken = _fractionToken;
        nftContract = _nftContract;
    }
    
    //get
    function getOwnershipPercentage(address owner) public view returns (uint256) {
        return (fractionToken.balanceOf(owner) * 10000) / fractionToken.totalSupply();
    }

    // Set up the initial sale
    function configureSale(uint256 _pricePerToken) external onlyOwner {
        salePrice = _pricePerToken;
    }

    // Allow anyone to buy tokens directly
    function purchaseTokens() external payable {
        require(saleActive, "Sale not active");
        require(msg.value > 0, "Must send ETH");
        
        uint256 tokenAmount = msg.value / salePrice;
        require(tokenAmount > 0, "Not enough ETH sent");
        
        // Transfer tokens from contract's reserve to buyer
        //fractionToken._transfer(owner(), msg.sender, tokenAmount);
    }

}