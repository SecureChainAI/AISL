function reset() public onlyCreator {
    selfdestruct(ownerAddress);
}
