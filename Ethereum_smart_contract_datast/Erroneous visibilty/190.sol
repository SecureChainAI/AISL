contract Token {
    function totalSupply() public returns (uint256 supply);

    function transfer(address _to, uint256 _value) returns (bool success);

    function transferFrom(
        address _from,
        address _to,
        uint256 _value
    ) returns (bool success);

    function approve(address _spender, uint256 _value) returns (bool success);

    function allowance(
        address _owner,
        address _spender
    ) constant returns (uint256 remaining);
}
