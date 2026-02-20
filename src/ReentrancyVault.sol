// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract ReentrancyVault {

    mapping(address => uint256) public balances;

    function deposit() external payable {
        balances[msg.sender] += msg.value;
    }

    // ❌ VULNERABLE FUNCTION
  function withdraw(uint256 amount) external {
    require(balances[msg.sender] >= amount, "Not enough");

    // ✅ EFFECT dulu (tutup celah reentrancy)
    balances[msg.sender] -= amount;

    // ✅ INTERACTION terakhir
    (bool sent,) = msg.sender.call{value: amount}("");
    require(sent, "Failed");
}


    function getBalance() external view returns (uint256) {
        return address(this).balance;
    }
}
