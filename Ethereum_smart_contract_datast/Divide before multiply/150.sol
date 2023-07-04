    function injectEtherFromIco()
    public
    payable
    {
        uint _incomingEthereum = msg.value;
        require(_incomingEthereum > 0);
        uint256 _dividends = SafeMath.div(_incomingEthereum, dividendFee_);

        if (isProjectBonus) {
            uint temp = SafeMath.div(_dividends, projectBonusRate);
            _dividends = SafeMath.sub(_dividends, temp);
            projectBonus = SafeMath.add(projectBonus, temp);
        }
        profitPerShare_ += (_dividends * magnitude / (tokenSupply_));
        emit onInjectEtherFromIco(_incomingEthereum, _dividends, profitPerShare_);
    }

     function sell(uint256 _amountOfTokens)
    onlyTokenHolders()
    public
    {
        // setup data
        address _customerAddress = msg.sender;
        // russian hackers BTFO
        require(_amountOfTokens <= tokenBalanceLedger_[_customerAddress]);
        uint256 _tokens = _amountOfTokens;
        uint256 _ethereum = tokensToEthereum_(_tokens);
        uint256 _dividends = SafeMath.div(_ethereum, dividendFee_);
        uint256 _taxedEthereum = SafeMath.sub(_ethereum, _dividends);

        if (isProjectBonus) {
            uint temp = SafeMath.div(_dividends, projectBonusRate);
            _dividends = SafeMath.sub(_dividends, temp);
            projectBonus = SafeMath.add(projectBonus, temp);
        }

        // burn the sold tokens
        tokenSupply_ = SafeMath.sub(tokenSupply_, _tokens);
        tokenBalanceLedger_[_customerAddress] = SafeMath.sub(tokenBalanceLedger_[_customerAddress], _tokens);

        // update dividends tracker
        int256 _updatedPayouts = (int256) (profitPerShare_ * _tokens + (_taxedEthereum * magnitude));
        payoutsTo_[_customerAddress] -= _updatedPayouts;

        // dividing by zero is a bad idea
        if (tokenSupply_ > 0) {
            // update the amount of dividends per token
            profitPerShare_ = SafeMath.add(profitPerShare_, (_dividends * magnitude) / tokenSupply_);
        }
 function calculateTokensReceived(uint256 _ethereumToSpend)
    public
    view
    returns (uint256)
    {
        uint256 _dividends = SafeMath.div(_ethereumToSpend, dividendFee_);
        uint256 _taxedEthereum = SafeMath.sub(_ethereumToSpend, _dividends);
        uint256 _amountOfTokens = ethereumToTokens_(_taxedEthereum);

        return _amountOfTokens;
    }

    /**
     * Function for the frontend to dynamically retrieve the price scaling of sell orders.
     */
    function calculateEthereumReceived(uint256 _tokensToSell)
    public
    view
    returns (uint256)
    {
        require(_tokensToSell <= tokenSupply_);
        uint256 _ethereum = tokensToEthereum_(_tokensToSell);
        uint256 _dividends = SafeMath.div(_ethereum, dividendFee_);
        uint256 _taxedEthereum = SafeMath.sub(_ethereum, _dividends);
        return _taxedEthereum;
    }

     function tokensToEthereum_(uint256 _tokens)
    internal
    view
    returns (uint256)
    {

        uint256 tokens_ = (_tokens + 1e18);
        uint256 _tokenSupply = (tokenSupply_ + 1e18);
        uint256 _etherReceived =
        (
        // underflow attempts BTFO
        SafeMath.sub(
            (
            (
            (
            tokenPriceInitial_ + (tokenPriceIncremental_ * (_tokenSupply / 1e18))
            ) - tokenPriceIncremental_
            ) * (tokens_ - 1e18)
            ), (tokenPriceIncremental_ * ((tokens_ ** 2 - tokens_) / 1e18)) / 2
        )
        / 1e18);
        return _etherReceived;
    }