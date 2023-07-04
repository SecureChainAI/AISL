function freezeAccount(address target, bool freeze) onlyOwner public {
      frozenAccount[target]=freeze;
      FrozenFunds(target, freeze);
    }