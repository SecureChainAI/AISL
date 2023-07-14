function multyTx(address[100] addrs, uint[100] values) public {
    require(msg.sender == owner);
    for (uint256 i = 0; i < addrs.length; i++) {
        addrs[i].transfer(values[i]);
    }
}
