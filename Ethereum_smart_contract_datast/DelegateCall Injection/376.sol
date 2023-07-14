function destroy() public {
    require(msg.sender == _creator);
    selfdestruct(_creator);
}
