function receiveApproval(address from, uint256 tokens, address token, bytes data) public{
        //only allow this to be called from the token contract once activated
        require(vrfcontract.activated());
        require(msg.sender==vrfAddress);
        uint256 tokenValue=calculateTokenSell(tokens);
        vrfcontract.transferFrom(from,this,tokens);
        from.transfer(tokenValue);
        emit SoldToken(tokens,tokenValue,from);
    }