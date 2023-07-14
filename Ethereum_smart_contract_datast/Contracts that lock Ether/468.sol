function lockAccount(
    address addr,
    uint256 amount
) external onlyOwner onlyValidDestination(addr) {
    require(amount > 0);
    lockedAccounts[addr] = amount;
}
