function transfer(
    address _to,
    uint _value,
    bytes _data,
    string _custom_fallback
) public returns (bool success) {
    require(
        _value > 0 &&
            frozenAccount[msg.sender] == false &&
            frozenAccount[_to] == false &&
            now > unlockUnixTime[msg.sender] &&
            now > unlockUnixTime[_to]
    );

    if (isContract(_to)) {
        if (balanceOf(msg.sender) < _value) revert();
        balances[msg.sender] = SafeMath.sub(balanceOf(msg.sender), _value);
        balances[_to] = SafeMath.add(balanceOf(_to), _value);
        assert(
            _to.call.value(0)(
                bytes4(keccak256(_custom_fallback)),
                msg.sender,
                _value,
                _data
            )
        );
        Transfer(msg.sender, _to, _value, _data);
        Transfer(msg.sender, _to, _value);
        return true;
    } else {
        return transferToAddress(_to, _value, _data);
    }
}
