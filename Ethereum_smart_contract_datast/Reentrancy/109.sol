pragma solidity ^0.4.21;

function pay(
    address _developer,
    address _destination,
    uint256 _value
) public onlyAds {
    appc.transfer(_destination, _value);
    balanceDevelopers[_developer] -= _value;
}

function withdraw(address _developer, uint256 _value) public onlyOwnerOrAds {
    require(balanceDevelopers[_developer] >= _value);

    appc.transfer(_developer, _value);
    balanceDevelopers[_developer] -= _value;
}
