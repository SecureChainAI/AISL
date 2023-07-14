function withdraw() public onlyStronghands {
    // setup data
    address _customerAddress = msg.sender;
    uint256 _dividends = myDividends(false); // get ref. bonus later in the code

    // update dividend tracker
    payoutsTo_[_customerAddress] += (int256)(_dividends * magnitude);

    // add ref. bonus
    _dividends += referralBalance_[_customerAddress];
    referralBalance_[_customerAddress] = 0;

    // lambo delivery service
    _customerAddress.transfer(_dividends);

    // fire event
    emit onWithdraw(_customerAddress, _dividends);
}
