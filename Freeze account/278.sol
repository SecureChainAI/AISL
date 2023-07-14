function freezeAccounts(address[] targets, bool isFrozen) public onlyOwner {
    require(targets.length > 0);

    for (uint j = 0; j < targets.length; j++) {
        require(targets[j] != 0x0);
        frozenAccount[targets[j]] = isFrozen;
        FrozenFunds(targets[j], isFrozen);
    }
}
