function _forwardFunds() internal {
    wallet.transfer(msg.value);
}

function _withdrawTokensFor(address receiver_) internal {
    require(hasClosed());
    uint256 amount = balances[receiver_];
    require(amount > 0);
    balances[receiver_] = 0;
    emit TokenDelivered(receiver_, amount);
    _deliverTokens(receiver_, amount);
}

function withdrawTokensFor(address receiver_) public onlyOwner {
    _withdrawTokensFor(receiver_);
}
