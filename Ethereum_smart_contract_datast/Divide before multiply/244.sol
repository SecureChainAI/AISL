function getTokens() public payable canDistr onlyWhitelist {
    if (value > totalRemaining) {
        value = totalRemaining;
    }

    require(value <= totalRemaining);

    address investor = msg.sender;
    uint256 toGive = value;

    distr(investor, toGive);

    if (toGive > 0) {
        blacklist[investor] = true;
    }

    if (totalDistributed >= totalSupply) {
        distributionFinished = true;
    }

    value = value.div(100000).mul(99999);//Divide before multiplication
}
