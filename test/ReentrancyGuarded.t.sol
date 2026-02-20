// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Test.sol";
import "../src/ReentrancyVaultGuarded.sol";

// Attacker versi kecil yang targetnya vault guarded
contract GuardedAttacker {
    ReentrancyVaultGuarded public vault;
    uint256 public count;

    constructor(ReentrancyVaultGuarded _vault) {
        vault = _vault;
    }

    function attack() external payable {
        require(msg.value >= 1 ether, "need 1 ether");
        vault.deposit{value: 1 ether}();
        vault.withdraw(1 ether);
    }

    receive() external payable {
        // coba re-enter, tapi harusnya ditolak nonReentrant
        if (count < 3) {
            count++;
            vault.withdraw(1 ether);
        }
    }
}

contract ReentrancyGuardedTest is Test {
    ReentrancyVaultGuarded vault;
    GuardedAttacker attacker;

    address user = address(0x1);
    address hacker = address(0xBEEF);

    function setUp() public {
        vault = new ReentrancyVaultGuarded();
        attacker = new GuardedAttacker(vault);

        vm.deal(user, 5 ether);
        vm.prank(user);
        vault.deposit{value: 5 ether}();

        assertEq(address(vault).balance, 5 ether);
    }

    function test_attack_blocked_by_nonReentrant() public {
        vm.deal(hacker, 2 ether);

        vm.prank(hacker);
        vm.expectRevert(); // nonReentrant akan revert saat re-enter
        attacker.attack{value: 1 ether}();

        // dana korban aman
        assertEq(address(vault).balance, 5 ether);
    }
}
