contract Token {
    function transfer(
        address _to,
        uint256 _value
    ) public returns (bool success);
}

function recoverUnawardedMILs() public {
    uint256 MILs = militaryToken.balanceOf(address(this));
    if (totalAwards < MILs) {
        militaryToken.transfer(owner, MILs - totalAwards);
    }
}
