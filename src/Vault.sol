// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Vault {
    address public owner;
    mapping(address => uint256) public balances;

    constructor() {
        owner = msg.sender;
    }

    function deposit() external payable {
        balances[msg.sender] += msg.value;
    }

    // BUG 1: auth salah pakai tx.origin
  function withdraw(uint256 amount) external {
  	  require(tx.origin == owner, "Not owner"); // ⚠ BUG auth
  	  require(balances[tx.origin] >= amount, "Not enough"); // ⚠ accounting pakai tx.origin

   	 balances[tx.origin] -= amount;
    	payable(msg.sender).transfer(amount); // msg.sender = attacker, dana lari ke attacker
     }


    // BUG 2: tidak ada access control
    function changeOwner(address newOwner) external {
        owner = newOwner; // ⚠ BUG
    }
}
