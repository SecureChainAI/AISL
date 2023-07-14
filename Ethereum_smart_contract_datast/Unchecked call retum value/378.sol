function buy(address _referredBy) public payable returns (uint256) {
    purchaseTokens(msg.value, _referredBy);
}
