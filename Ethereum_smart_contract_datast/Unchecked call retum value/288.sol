function buy(address _referredBy) public payable returns (uint256) {
    purchaseInternal(msg.value, _referredBy);
}
