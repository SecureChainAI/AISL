function freezeAccount(address target, bool freeze) public onlyOwner {
    frozenAccount[target] = freeze;
    FrozenFunds(target, freeze);
}
