function freezeAll() public {
    require(msg.sender == _creator);
    bIsFreezeAll = !bIsFreezeAll;
}
