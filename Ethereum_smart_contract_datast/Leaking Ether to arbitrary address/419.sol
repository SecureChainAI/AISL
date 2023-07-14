function transferEthereum(
    uint amount,
    address destination
) public onlyBy(maintainer) {
    require(destination != address(0));
    destination.transfer(amount);
}
