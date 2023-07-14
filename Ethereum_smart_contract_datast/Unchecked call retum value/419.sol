function transferTokens(
    address token,
    uint amount,
    address destination
) public onlyBy(maintainer) {
    require(destination != address(0));
    SnooKarma tokenContract = SnooKarma(token);
    tokenContract.transfer(destination, amount);
}
