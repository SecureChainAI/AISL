function destroy() public onlyOwner {
    selfdestruct(owner);
}
