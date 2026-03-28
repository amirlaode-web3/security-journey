// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Test.sol";
import "../src/Vault.sol";
import "../src/Attacker.sol";

contract VaultTest is Test {
    Vault vault;
    Attacker attacker;

    address owner = address(0xA11CE);
    address hacker = address(0xB0B);

    function setUp() public {
        vm.prank(owner);
        vault = new Vault();

        attacker = new Attacker(vault);

        // owner deposit 1 ether
        vm.deal(owner, 2 ether);
        vm.prank(owner);
        vault.deposit{value: 1 ether}();
    }

    function test_anyone_can_changeOwner() public {
        vm.prank(hacker);
        vault.changeOwner(hacker);

        assertEq(vault.owner(), hacker);
    }

    function test_txOrigin_phishing_sends_eth_to_attacker_contract() public {
        // hacker minta owner manggil attacker.trickWithdraw(...)
        vm.prank(owner, owner); // set msg.sender = owner, tx.origin = owner
         attacker.trickWithdraw(0.5 ether);


        // ETH masuk ke attacker contract (msg.sender saat transfer adalah attacker)
        assertEq(address(attacker).balance, 0.5 ether);
    }
}
