// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Test.sol";
import "../src/MemoryModelPractice.sol";

contract MemoryModelPracticeTest is Test {
    MemoryModelPractice c;

    function setUp() public {
        c = new MemoryModelPractice();
    }

    function test_updateBalance_storage_changes_state() public {
        c.setUser(true, 100);
        assertEq(c.getMyBalance(), 100);

        c.updateBalance_storage(777);
        assertEq(c.getMyBalance(), 777);
    }

    function test_updateBalance_memory_copy_changes_state_because_written_back() public {
        c.setUser(true, 100);
        assertEq(c.getMyBalance(), 100);

        c.updateBalance_memory_copy(555);
        assertEq(c.getMyBalance(), 555);
    }

    function test_inactive_reverts_custom_error_storage() public {
        c.setUser(false, 100);

        vm.expectRevert(abi.encodeWithSelector(MemoryModelPractice.InactiveUser.selector, address(this)));
        c.updateBalance_storage(1);
    }

    function test_inactive_reverts_custom_error_memory_copy() public {
        c.setUser(false, 100);

        vm.expectRevert(abi.encodeWithSelector(MemoryModelPractice.InactiveUser.selector, address(this)));
        c.updateBalance_memory_copy(1);
    }
}
