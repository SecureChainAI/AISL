function clear() public {
    if (isOwner()) selfdestruct(Owner);
}
