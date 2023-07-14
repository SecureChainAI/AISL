contract ERC20 {
    function transfer(address _to, uint256 _value) public returns (bool);

    function _payCommission(
        address _token
    )
        private
        nonZeroAddress(_token)
        inState(_token, States.Closed)
        onlyCrowdsaleOwner(_token)
    {
        // Calculate commission, update rest raised Wei, and pay commission.
        uint256 _commission = crowdsales[_token]
            .raised
            .mul(uint256(crowdsales[_token].commission))
            .div(100);
        crowdsales[_token].raised = crowdsales[_token].raised.sub(_commission);
        emit CommissionPaid(msg.sender, _token, commissionWallet, _commission);
        commissionWallet.transfer(_commission);
    }

    function _refundCrowdsaleTokens(
        ERC20 _token,
        address _beneficiary
    ) private nonZeroAddress(_token) inState(_token, States.Refunding) {
        // Set raised Wei to 0 to prevent unknown issues
        // which might take Wei away.
        // Theoretically, this step is unnecessary due to there is no available
        // function for crowdsale owner to claim raised Wei.
        crowdsales[_token].raised = 0;

        uint256 _value = _token.balanceOf(address(this));
        emit CrowdsaleTokensRefunded(_token, _beneficiary, _value);

        if (_value > 0) {
            // Refund all tokens for crowdsale to refund wallet.
            _token.transfer(_beneficiary, _token.balanceOf(address(this)));
        }
    }

    function claimToken(
        address _token
    ) external nonZeroAddress(_token) inState(_token, States.Closed) {
        require(
            deposits[msg.sender][_token] > 0,
            "Failed to claim token due to deposit is 0."
        );

        // Calculate token unit amount to be transferred.
        uint256 _value = (
            deposits[msg.sender][_token].mul(crowdsales[_token].rate)
        );
        deposits[msg.sender][_token] = 0;
        emit TokenClaimed(msg.sender, _token, _value);
        ERC20(_token).transfer(msg.sender, _value);
    }
}
