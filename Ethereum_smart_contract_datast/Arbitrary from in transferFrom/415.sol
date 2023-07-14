function receiveApproval(
    address _from,
    uint _amount,
    address,
    bytes
) public onlyBy(pinakion) {
    require(pinakion.transferFrom(_from, this, _amount));

    balance += _amount;
}

function receiveApproval(
    address _from,
    uint _amount,
    address,
    bytes
) public onlyBy(pinakion) {
    require(pinakion.transferFrom(_from, this, _amount));

    jurors[_from].balance += _amount;
}
