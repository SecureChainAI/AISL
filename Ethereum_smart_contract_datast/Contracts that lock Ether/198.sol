function lock(uint256 lockTime) public onlyOwner returns (bool) {
    require(!isLocked);
    require(tokenBalance() > 0);
    start_time = now;
    end_time = lockTime;
    isLocked = true;
}
