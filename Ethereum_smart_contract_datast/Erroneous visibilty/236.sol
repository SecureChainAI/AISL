function approveAndCall(
    address _spender,
    uint256 _value,
    bytes _extraData
) returns (bool success) {
    allowed[msg.sender][_spender] = _value;
    emit Approval(msg.sender, _spender, _value);

    //call the receiveApproval function on the contract you want to be notified. This crafts the function signature manually so one doesn't have to include a contract in here just for this.
    //receiveApproval(address _from, uint256 _value, address _tokenContract, bytes _extraData)
    //it is assumed that when does this that the call *should* succeed, otherwise one would use vanilla approve instead.
    if (
        !_spender.call(
            bytes4(
                bytes32(sha3("receiveApproval(address,uint256,address,bytes)"))
            ),
            msg.sender,
            _value,
            this,
            _extraData
        )
    ) {
        throw;
    }
    return true;
}
