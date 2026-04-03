// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import "../src/LowLevelCall.sol"; 

contract LowLevelCallTest is Test {
    Target public target;
    Caller public caller;

    
    function setUp() public {
        target = new Target();
        caller = new Caller();
    }

    
    function test_Call_SetNumber() public {
        caller.setTargetNumber(address(target), 888);
        assertEq(caller.targetNumber(), 888, "Decode di Caller gagal");
        assertEq(target.number(), 888, "State di Target tidak berubah");
    }

    function test_StaticCall_GetAdmin() public {
        string memory hasilReturn = caller.getTargetAdmin(address(target));
        assertEq(hasilReturn, "Amir La Ode", "Return value salah");
        assertEq(caller.targetAdmin(), "Amir La Ode", "State targetAdmin salah");
    }

   
    function test_DelegateCall_AddNumbers() public {
        uint256 hasil = caller.addNumbersss(address(target), 10, 15);
        assertEq(hasil, 25, "Hasil return penjumlahan salah");
        assertEq(caller.sum(), 25, "State sum salah");
    }
}