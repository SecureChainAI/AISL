function kill() public {
    require(msg.sender == owner);
    selfdestruct(owner);
}
