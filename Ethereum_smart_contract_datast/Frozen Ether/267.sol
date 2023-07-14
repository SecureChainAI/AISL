    function freezeAccount(address _to, bool _freeze) public onlyOwner {
        require(_to != address(0));
        frozenAccount[_to] = _freeze;
        emit FrozenFunds(_to, _freeze);
    }
