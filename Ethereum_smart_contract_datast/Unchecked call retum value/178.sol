pragma solidity 0.4.20;

contract Token {
    function totalSupply() constant returns (uint supply) {}

    function balanceOf(address _owner) constant returns (uint balance) {}

    function transfer(address _to, uint _value) returns (bool success) {}

    function transferFrom(
        address _from,
        address _to,
        uint _value
    ) returns (bool success) {}

    function approve(address _spender, uint _value) returns (bool success) {}

    function allowance(
        address _owner,
        address _spender
    ) constant returns (uint remaining) {}
}
