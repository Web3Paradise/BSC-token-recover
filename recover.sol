// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract TokenRecovery {
    address private owner;
    
    constructor() {
        owner = msg.sender;
        require(owner != address(0), "Invalid owner address");
    }
    
    modifier onlyOwner() {
        require(msg.sender == owner, "Only the contract owner can call this function");
        _;
    }
    
    // Function to recover ERC20 tokens sent to this contract
    function recoverTokens(address tokenAddress, address to, uint256 amount) external onlyOwner {
        IERC20 token = IERC20(tokenAddress);
        require(token.transfer(to, amount), "Token transfer failed");
    }
}

// Interface for ERC20 tokens
interface IERC20 {
    function transfer(address recipient, uint256 amount) external returns (bool);
}
