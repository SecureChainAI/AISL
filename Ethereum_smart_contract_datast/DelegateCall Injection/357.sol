function kill() external payable {
    require(now >= destroy_time);
    selfdestruct(owner);
}
