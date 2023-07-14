function withdraw() public {
    require(msg.sender == owner);
    owner.transfer(address(this).balance);
}
