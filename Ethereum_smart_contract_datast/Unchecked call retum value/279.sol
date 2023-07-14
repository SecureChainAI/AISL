function transfer(
    address to,
    uint256 value
) public onlyReleased returns (bool) {
    super.transfer(to, value);
}

function allowance(
    address _owner,
    address _spender
) public view onlyReleased returns (uint256) {
    super.allowance(_owner, _spender);
}

function transferFrom(
    address from,
    address to,
    uint256 value
) public onlyReleased returns (bool) {
    super.transferFrom(from, to, value);
}

function approve(
    address spender,
    uint256 value
) public onlyReleased returns (bool) {
    super.approve(spender, value);
}
