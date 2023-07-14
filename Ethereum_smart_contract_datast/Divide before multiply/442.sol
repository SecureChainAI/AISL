function buyTokens(address beneficiary) public payable saleIsOn {
    require(beneficiary != address(0));
    uint256 weiAmount = (msg.value).div(10 ** 10);
    uint256 all = 100;
    uint256 timeBonusNow = getTimeBonus(weiAmount);
    // calculate token amount to be created
    uint256 tokens = weiAmount.mul(rate);
    require(tokens >= minTokensToSale);
    uint256 tokensSumBonus = tokens.add(tokens.mul(timeBonusNow).div(all));
    require(tokensToSale > tokensSumBonus.add(token.totalSupply()));
    weiRaised = weiRaised.add(msg.value);
    token.mint(beneficiary, tokensSumBonus);
    emit TokenPurchase(msg.sender, beneficiary, weiAmount, tokensSumBonus);

    wallet.transfer(msg.value);
}
