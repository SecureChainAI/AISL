function tokenDrain(ERC20 _token, uint256 _amount) public onlyOwner {
    _token.transfer(owner, _amount);
}
