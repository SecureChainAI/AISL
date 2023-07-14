pragma solidity ^0.4.19;

function transferFrom(
    address _from,
    address _to,
    uint256 _value
) public returns (uint);

function buy(
    string _packageName,
    string _sku,
    uint256 _amount,
    address _addr_appc,
    address _dev,
    address _appstore,
    address _oem,
    bytes2 _countryCode
) public view returns (bool) {
    require(_addr_appc != 0x0);
    require(_dev != 0x0);
    require(_appstore != 0x0);
    require(_oem != 0x0);

    AppCoins appc = AppCoins(_addr_appc);
    uint256 aux = appc.allowance(msg.sender, address(this));
    if (aux < _amount) {
        emit Error("buy", "Not enough allowance");
        return false;
    }

    uint[] memory amounts = new uint[](3);
    amounts[0] = division(_amount * dev_share, 100);
    amounts[1] = division(_amount * appstore_share, 100);
    amounts[2] = division(_amount * oem_share, 100);

    appc.transferFrom(msg.sender, _dev, amounts[0]);
    appc.transferFrom(msg.sender, _appstore, amounts[1]);
    appc.transferFrom(msg.sender, _oem, amounts[2]);

    emit Buy(
        _packageName,
        _sku,
        _amount,
        msg.sender,
        _dev,
        _appstore,
        _oem,
        _countryCode
    );

    return true;
}
