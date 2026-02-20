// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "openzeppelin-contracts/contracts/utils/ReentrancyGuard.sol";

contract ReentrancyVaultGuarded is ReentrancyGuard {
    mapping(address => uint256) public balances;

    function deposit() external payable {
        balances[msg.sender] += msg.value;
    }

    function withdraw(uint256 amount) external nonReentrant {
        require(balances[msg.sender] >= amount, "Not enough");

        balances[msg.sender] -= amount;

        (bool sent,) = msg.sender.call{value: amount}("");
        require(sent, "Failed");
    }

    function getBalance() external view returns (uint256) {
        return address(this).balance;
    }
}
