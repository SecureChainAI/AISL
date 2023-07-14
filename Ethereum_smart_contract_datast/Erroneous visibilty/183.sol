pragma solidity ^0.4.4;

contract Token {
    function totalSupply() constant returns (uint256 supply) {}

    function balanceOf(address _owner) constant returns (uint256 balance) {}

    function transfer(address _to, uint256 _value) returns (bool success) {}

    function transferFrom(
        address _from,
        address _to,
        uint256 _value
    ) returns (bool success) {}

    function approve(address _spender, uint256 _value) returns (bool success) {}

    function allowance(
        address _owner,
        address _spender
    ) constant returns (uint256 remaining) {}
}
