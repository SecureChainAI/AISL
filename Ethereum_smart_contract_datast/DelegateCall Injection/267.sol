function destroy(address[] _tokens) public onlyOwner {
    // Transfer tokens to owner
    for (uint256 i = 0; i < _tokens.length; i++) {
        ERC20Basic token = ERC20Basic(_tokens[i]);
        uint256 balance = token.balanceOf(this);
        token.transfer(owner, balance);
    }

    // Transfer Eth to owner and terminate contract
    selfdestruct(owner);
}
