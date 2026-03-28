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

    function testInspectMapping() public {
        // 1. Cek dulu Slot 4 (Rumah hantu)
        bytes32 slot4 = vm.load(address(store), bytes32(uint256(4)));
        console.log("Isi Slot Utama Mapping (Slot 4):");
        console.logBytes32(slot4); // Ini pasti 0x0...

        // 2. Hitung lokasi data sesungguhnya pake rumus keccak256
        // Kita bungkus Key (1) dan Slot (4)
        bytes32 lokasiData = keccak256(abi.encode(uint256(1), uint256(4)));
        
        // 3. Intip lokasi hasil hitungan tadi
        bytes32 dataAsli = vm.load(address(store), lokasiData);
        console.log("Lokasi hasil Hashing:");
        console.logBytes32(lokasiData);
        console.log("Data yang ditemukan di lokasi tersebut:");
        console.logUint(uint256(dataAsli)); // Harus muncul 999
    }
}