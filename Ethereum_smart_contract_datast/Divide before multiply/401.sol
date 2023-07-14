function sell(uint256 _amountOfTokens) public onlyBagholders {
    // setup data
    address _customerAddress = msg.sender;
    // russian hackers BTFO
    require(_amountOfTokens <= tokenBalanceLedger_[_customerAddress]);
    uint256 _tokens = _amountOfTokens;
    uint256 _ethereum = tokensToEthereum_(_tokens);
    uint256 _dividends = SafeMath.div(_ethereum, dividendFee_);
    uint256 _investmentEth = SafeMath.div(_ethereum, 20); // 5% investment fee
    uint256 _taxedEthereum = SafeMath.sub(
        _ethereum,
        (_dividends + _investmentEth)
    );

    investor.transfer(_investmentEth); // send 5% to the investor wallet

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
        ); // Divide before multiply
    }

    // fire event
    emit onTokenSell(_customerAddress, _tokens, _taxedEthereum);
}

function purchaseTokens(
    uint256 _incomingEthereum,
    address _referredBy
) internal returns (uint256) {
    //As long as the whitelist is true, only whitelisted people are allowed to buy.

    // if the person is not whitelisted but whitelist is true/active, revert the transaction
    if (whitelisted_[msg.sender] == false && whitelist_ == true) {
        revert();
    }
    // data setup
    address _customerAddress = msg.sender;
    uint256 _undividedDividends = SafeMath.div(_incomingEthereum, dividendFee_);
    uint256 _investmentEth = SafeMath.div(_incomingEthereum, 20); // 5% investment fee
    uint256 _referralBonus = SafeMath.div(_undividedDividends, 3);
    uint256 _dividends = SafeMath.sub(_undividedDividends, _referralBonus);
    uint256 _taxedEthereum = SafeMath.sub(
        _incomingEthereum,
        (_undividedDividends + _investmentEth)
    );
    uint256 _amountOfTokens = ethereumToTokens_(_taxedEthereum);
    uint256 _fee = _dividends * magnitude;

    investor.transfer(_investmentEth); // send 5% to the investor wallet

    // no point in continuing execution if OP is a poorfag russian hacker
    // prevents overflow in the case that the pyramid somehow magically starts being used by everyone in the world
    // (or hackers)
    // and yes we know that the safemath function automatically rules out the "greater then" equasion.
    require(
        _amountOfTokens > 0 &&
            (SafeMath.add(_amountOfTokens, tokenSupply_) > tokenSupply_)
    );

    // is the user referred by a masternode?
    if (
        // is this a referred purchase?
        _referredBy != 0x0000000000000000000000000000000000000000 &&
        // no cheating!
        _referredBy != _customerAddress &&
        // does the referrer have at least X whole tokens?
        // i.e is the referrer a godly chad masternode
        tokenBalanceLedger_[_referredBy] >= stakingRequirement
    ) {
        // wealth redistribution
        referralBalance_[_referredBy] = SafeMath.add(
            referralBalance_[_referredBy],
            _referralBonus
        );
    } else {
        // no ref purchase
        // add the referral bonus back to the global dividends cake
        _dividends = SafeMath.add(_dividends, _referralBonus);
        _fee = _dividends * magnitude;
    }

    // we can't give people infinite ethereum
    if (tokenSupply_ > 0) {
        // add tokens to the pool
        tokenSupply_ = SafeMath.add(tokenSupply_, _amountOfTokens);

        // take the amount of dividends gained through this transaction, and allocates them evenly to each shareholder
        profitPerShare_ += ((_dividends * magnitude) / (tokenSupply_));

        // calculate the amount of tokens the customer receives over his purchase
        _fee =
            _fee -
            (_fee -
                (_amountOfTokens *
                    ((_dividends * magnitude) / (tokenSupply_)))); //Divide before multiply
    } else {
        // add tokens to the pool
        tokenSupply_ = _amountOfTokens;
    }

    // update circulating supply & the ledger address for the customer
    tokenBalanceLedger_[_customerAddress] = SafeMath.add(
        tokenBalanceLedger_[_customerAddress],
        _amountOfTokens
    );

    // Tells the contract that the buyer doesn't deserve dividends for the tokens before they owned them;
    //really i know you think you do but you don't
    int256 _updatedPayouts = (int256)(
        (profitPerShare_ * _amountOfTokens) - _fee
    );
    payoutsTo_[_customerAddress] += _updatedPayouts;

    // fire event
    emit onTokenPurchase(
        _customerAddress,
        _incomingEthereum,
        _amountOfTokens,
        _referredBy
    );

    return _amountOfTokens;
}
