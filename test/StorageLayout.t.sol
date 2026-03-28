// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import "../src/StorageLayout.sol";

contract StorageLayoutTest is Test {
    StorageLayout store;

    function setUp() public {
        store = new StorageLayout();
    }

    function testInspectStorage() public {
        // Mengintip Slot 0 (Variabel a)
        bytes32 slot0 = vm.load(address(store), bytes32(uint256(0)));
        console.log("Isi Slot 0 (a):");
        console.logBytes32(slot0);

        // Mengintip Slot 1 (Variabel b dan c bergabung!)
        bytes32 slot1 = vm.load(address(store), bytes32(uint256(1)));
        console.log("Isi Slot 1 (b dan c di-packing):");
        console.logBytes32(slot1);

        // Mengintip Slot 2 (Variabel d dan e)
        bytes32 slot2 = vm.load(address(store), bytes32(uint256(2)));
        console.log("Isi Slot 2 (d dan e):");
        console.logBytes32(slot2);

        //UPDATE 
        bytes32 slot3 = vm.load(address(store), bytes32(uint256(3)));
        console.log("Isi Slot 3 (Struct Koordinat - x dan y):");
        console.logBytes32(slot3);
    }
}