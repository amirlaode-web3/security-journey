// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Test.sol";
import "../src/ReentrancyVault.sol";
import "../src/ReentrancyAttacker.sol";

contract ReentrancyTest is Test {

    ReentrancyVault vault;
    ReentrancyAttacker attacker;

    address user = address(0x1);

    function setUp() public {
        vault = new ReentrancyVault();
        attacker = new ReentrancyAttacker(vault);

        vm.deal(user, 5 ether);
        vm.prank(user);
        vault.deposit{value: 5 ether}();
    }

         function test_reentrancy_attack() public {
	address hacker = address(0xBEEF);
	 // hacker punya duit buat mulai attack
   	 vm.deal(hacker, 2 ether);

   	 // Karena vault sekarang sudah FIX (CEI), attack seharusnya GAGAL.
	    vm.prank(hacker);
 	   vm.expectRevert(); // gak peduli revert reason, yang penting attack gagal
 	   attacker.attack{value: 1 ether}();

  	  // Dana korban tetap aman
  	  assertEq(address(vault).balance, 5 ether);
	}

}
