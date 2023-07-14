pragma solidity ^0.4.21;

function safeTransferFrom(
    P4WDToken token,
    address from,
    address to,
    uint256 value
) internal {
    assert(token.transferFrom(from, to, value));
}

function transferFrom(
    address _from,
    address _to,
    uint256 _value
) public whenNotPaused returns (bool) {
    require(_to != address(0));
    require(_value <= balances[_from]);
    require(_value <= allowed[_from][msg.sender]);

    balances[_from] = balances[_from].sub(_value);
    balances[_to] = balances[_to].add(_value);
    allowed[_from][msg.sender] = allowed[_from][msg.sender].sub(_value);
    emit Transfer(_from, _to, _value);
    return true;
}
