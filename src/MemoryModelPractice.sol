// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/// @title Memory Model Practice (Day 3–4)
/// @notice Fokus: storage vs memory vs calldata, visibility, view/pure, require/revert/custom error
contract MemoryModelPractice {
    struct User {
        uint256 balance;
        bool active;
    }

    mapping(address => User) public users;

    // ===== Custom errors (lebih hemat gas daripada string) =====
    error InactiveUser(address user);

    /// @notice Set user untuk msg.sender
    /// @dev Kita tulis langsung ke storage karena ini update state.
    function setUser(bool active, uint256 balance) external {
        users[msg.sender] = User({balance: balance, active: active});
    }

    /// @notice Update balance: versi "storage reference"
    /// @dev `User storage u = users[msg.sender];` membuat POINTER ke storage.
    ///      Mengubah `u.balance` = mengubah state.
    function updateBalance_storage(uint256 newBalance) external {
        User storage u = users[msg.sender];
        if (!u.active) revert InactiveUser(msg.sender);

        u.balance = newBalance;
    }

    /// @notice Update balance: versi "memory copy" (buat bandingin)
    /// @dev `User memory u = users[msg.sender];` membuat COPY sementara.
    ///      Mengubah `u.balance` TIDAK mengubah state, kecuali kita tulis balik ke storage.
    function updateBalance_memory_copy(uint256 newBalance) external {
        User memory u = users[msg.sender];
        if (!u.active) revert InactiveUser(msg.sender);

        u.balance = newBalance; // cuma ubah copy di memory
        users[msg.sender] = u;  // tulis balik supaya state berubah
    }

    /// @notice Contoh view: baca state
    function getMyBalance() external view returns (uint256) {
        return users[msg.sender].balance;
    }

    /// @notice Contoh pure: hitung dari input, tidak baca state
    function add(uint256 a, uint256 b) external pure returns (uint256) {
        return a + b;
    }
}
