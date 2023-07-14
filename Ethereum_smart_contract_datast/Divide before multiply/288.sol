function sell(uint256 _amountOfTokens) public onlyBagholders {
    // setup data
    address _customerAddress = msg.sender;

    require(_amountOfTokens <= tokenBalanceLedger_[_customerAddress]);
    uint256 _tokens = _amountOfTokens;
    uint256 _ethereum = tokensToEthereum_(_tokens);

    uint256 _dividends = SafeMath.div(
        SafeMath.mul(_ethereum, dividendFee_),
        100
    );
    uint256 _charityPayout = SafeMath.div(
        SafeMath.mul(_ethereum, charityFee_),
        100
    );

    // Take out dividends and then _charityPayout
    uint256 _taxedEthereum = SafeMath.sub(
        SafeMath.sub(_ethereum, _dividends),
        _charityPayout
    );

    // Add ethereum to send to charity
    totalEthCharityCollected = SafeMath.add(
        totalEthCharityCollected,
        _charityPayout
    );

    // burn the sold tokens
    tokenSupply_ = SafeMath.sub(tokenSupply_, _tokens);
    tokenBalanceLedger_[_customerAddress] = SafeMath.sub(
        tokenBalanceLedger_[_customerAddress],
        _tokens
    );

    // update dividends tracker
    int256 _updatedPayouts = (int256)(
        profitPerShare_ * _tokens + (_taxedEthereum * magnitude)
    );
    payoutsTo_[_customerAddress] -= _updatedPayouts;

    // dividing by zero is a bad idea
    if (tokenSupply_ > 0) {
        // update the amount of dividends per token
        profitPerShare_ = SafeMath.add(
            profitPerShare_,
            (_dividends * magnitude) / tokenSupply_
        );
    }

    // fire event
    emit onTokenSell(_customerAddress, _tokens, _taxedEthereum);
}
