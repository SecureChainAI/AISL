 function freeze(
        address _target,
        bool _freeze
    )
    public
    returns (bool) {
        require(msg.sender == owner);
        require(_target != address(0));
        frozenAccount[_target] = _freeze;
        return true;
    }