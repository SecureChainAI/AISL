function claimToken(
    address tokenContract,
    address _to,
    uint256 _value
) public onlyAdmin returns (bool) {
    require(tokenContract != address(0));
    require(_to != address(0));
    require(_value > 0);

    ERC20 token = ERC20(tokenContract);

    return token.transfer(_to, _value);
}
