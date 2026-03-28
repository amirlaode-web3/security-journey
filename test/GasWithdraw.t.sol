// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Test.sol";
import "../src/ReentrancyVault.sol";
import "../src/ReentrancyVaultGuarded.sol";

contract GasWithdrawTest is Test {
    address user = address(0xCAFE);

    function setUp() public {
        vm.deal(user, 10 ether);
    }

    function test_withdraw_normal_reentrancyVault() public {
        ReentrancyVault v = new ReentrancyVault();

        vm.startPrank(user);
        v.deposit{value: 2 ether}();

        // withdraw normal (EOA), harus sukses
        v.withdraw(1 ether);
        vm.stopPrank();

        assertEq(address(v).balance, 1 ether);
    }

    function test_withdraw_normal_guardedVault() public {
        ReentrancyVaultGuarded g = new ReentrancyVaultGuarded();

        vm.startPrank(user);
        g.deposit{value: 2 ether}();

        // withdraw normal (EOA), harus sukses
        g.withdraw(1 ether);
        vm.stopPrank();

        assertEq(address(g).balance, 1 ether);
    }
}
