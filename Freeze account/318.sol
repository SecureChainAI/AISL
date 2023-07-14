function freezeTo(address _to, uint _amount, uint64 _until) public {
    require(_to != address(0));
    require(_amount <= balances[msg.sender]);

    balances[msg.sender] = balances[msg.sender].sub(_amount);

    bytes32 currentKey = toKey(_to, _until);
    freezings[currentKey] = freezings[currentKey].add(_amount);
    freezingBalance[_to] = freezingBalance[_to].add(_amount);

    freeze(_to, _until);
    emit Transfer(msg.sender, _to, _amount);
    emit Freezed(_to, _until, _amount);
}

function freeze(address _to, uint64 _until) internal {
    require(_until > block.timestamp);
    bytes32 key = toKey(_to, _until);
    bytes32 parentKey = toKey(_to, uint64(0));
    uint64 next = chains[parentKey];

    if (next == 0) {
        chains[parentKey] = _until;
        return;
    }

    bytes32 nextKey = toKey(_to, next);
    uint parent;

    while (next != 0 && _until > next) {
        parent = next;
        parentKey = nextKey;

        next = chains[nextKey];
        nextKey = toKey(_to, next);
    }

    if (_until == next) {
        return;
    }

    if (next != 0) {
        chains[key] = next;
    }

    chains[parentKey] = _until;
}
