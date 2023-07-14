function release() public onlyOwner {
    require(isLocked);
    require(!isReleased);
    require(lockOver());
    uint256 token_amount = tokenBalance();
    token_reward.transfer(beneficiary, token_amount);
    emit TokenReleased(beneficiary, token_amount);
    isReleased = true;
}

function lock(uint256 lockTime) public onlyOwner returns (bool) {
    require(!isLocked);
    require(tokenBalance() > 0);
    start_time = now;
    end_time = lockTime;
    isLocked = true;
}
