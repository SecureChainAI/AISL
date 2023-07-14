function withdraw() public onlyOwner {
    uint256 etherBalance = address(this).balance;
    owner.transfer(etherBalance);
}
