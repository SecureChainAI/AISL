function freeze(
    address _spender,
    uint256 _value
) public onlyOwner whenNotPaused returns (bool success) {
    require(_value < balances[_spender]);
    require(_value >= 0);
    balances[_spender] = balances[_spender].sub(_value);
    freezed[_spender] = freezed[_spender].add(_value);
    emit Freeze(_spender, _value);
    return true;
}
