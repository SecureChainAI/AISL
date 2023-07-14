function destroyContract() ownerRestricted {
    selfdestruct(owner);
}
