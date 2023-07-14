function freezeAccount(
    address target,
    bool freeze
) public onlyOwner returns (bool success) {
    frozenAccount[target] = freeze;
    emit FrozenFunds(target, freeze);
    return true;
}
