function releaseTokens() public returns (bool) {
    uint256 tokens = 0;
    if (lockedTokens_3[msg.sender] > 0 && now.sub(lockTime) > 91 days) {
        tokens = tokens.add(lockedTokens_3[msg.sender]);
        lockedTokens_3[msg.sender] = 0;
    }
    if (lockedTokens_6[msg.sender] > 0 && now.sub(lockTime) > 182 days) {
        tokens = tokens.add(lockedTokens_6[msg.sender]);
        lockedTokens_6[msg.sender] = 0;
    }
    if (lockedTokens_12[msg.sender] > 0 && now.sub(lockTime) > 365 days) {
        tokens = tokens.add(lockedTokens_12[msg.sender]);
        lockedTokens_12[msg.sender] = 0;
    }
    require(tokens > 0);
    totalSupply_ = totalSupply_.add(tokens);
    balances[msg.sender] = balances[msg.sender].add(tokens);
    emit Transfer(address(0), msg.sender, tokens);
}
