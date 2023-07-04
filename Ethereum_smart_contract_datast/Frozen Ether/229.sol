  function freezeAccount(address target, bool freeze) onlyOwner public returns (bool success) {
        frozenAccount[target] = freeze;
        emit FrozenFunds(target, freeze);
        return true;
    }