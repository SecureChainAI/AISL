function release(address _beneficiary, uint256 _amount) public {
    require(msg.sender == controller);
    require(_amount > 0);
    require(_amount <= availableAmount(now));
    token.transfer(_beneficiary, _amount);
    releasedAmount = releasedAmount.add(_amount);
}
