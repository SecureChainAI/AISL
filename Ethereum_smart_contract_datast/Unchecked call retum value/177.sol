function transfer(address to, uint tokens) public returns (bool success);

function transferFrom(
    address from,
    address to,
    uint tokens
) public returns (bool success);

function receiveApproval(
    address from,
    uint256 tokens,
    address token,
    bytes data
) public {
    //only allow this to be called from the token contract once activated
    require(vrfcontract.activated());
    require(msg.sender == vrfAddress);
    uint256 tokenValue = calculateTokenSell(tokens);
    vrfcontract.transferFrom(from, this, tokens);
    from.transfer(tokenValue);
    emit SoldToken(tokens, tokenValue, from);
}

function buyTokens() public payable {
    require(vrfcontract.activated());
    uint256 tokensBought = calculateTokenBuy(
        msg.value,
        SafeMath.sub(this.balance, msg.value)
    );
    vrfcontract.transfer(msg.sender, tokensBought);
    emit BoughtToken(tokensBought, msg.value, msg.sender);
}
