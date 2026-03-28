// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract StorageLayout {
    // Slot 0: 32 bytes penuh
    uint256 public a = 0xAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA;

    // Slot 1: Packing! uint128(16 bytes) + uint128(16 bytes) = 32 bytes
    uint128 public b = 0xBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB;
    uint128 public c = 0xCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC;

    // Slot 2: Address (20 bytes) + bool (1 byte). Sisa 11 bytes kosong.
    address public d = 0xd8dA6BF26964aF9D7eEd9e03E53415D37aA96045;
    bool public e = true;
}