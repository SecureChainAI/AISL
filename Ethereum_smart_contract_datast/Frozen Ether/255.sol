function freezeAccounts(address[] targets, bool isFrozen) public onlyOwner {
    require(targets.length > 0);

    for (uint i = 0; i < targets.length; i++) {
        require(targets[i] != 0x0);
        frozenAccount[targets[i]] = isFrozen;
        FrozenFunds(targets[i], isFrozen);
    }
}
