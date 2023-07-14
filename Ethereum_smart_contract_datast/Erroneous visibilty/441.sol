function increaseApproval(
    address _spender,
    uint _addedValue
) returns (bool success) {
    allowed[msg.sender][_spender] = allowed[msg.sender][_spender].add(
        _addedValue
    );
    Approval(msg.sender, _spender, allowed[msg.sender][_spender]);
    return true;
}

function decreaseApproval(
    address _spender,
    uint _subtractedValue
) returns (bool success) {
    uint oldValue = allowed[msg.sender][_spender];
    if (_subtractedValue > oldValue) {
        allowed[msg.sender][_spender] = 0;
    } else {
        allowed[msg.sender][_spender] = oldValue.sub(_subtractedValue);
    }
    Approval(msg.sender, _spender, allowed[msg.sender][_spender]);
    return true;
}
