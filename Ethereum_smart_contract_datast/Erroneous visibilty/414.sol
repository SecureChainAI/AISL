function transferOwnership(address newOwner) onlyOwner {
    if (newOwner != address(0)) {
        owner = newOwner;
    }
}

contract ERC20Basic {
    function balanceOf(address who) constant returns (uint);

    function transfer(address to, uint value);
}

contract ERC20 is ERC20Basic {
    function allowance(address owner, address spender) constant returns (uint);

    function transferFrom(address from, address to, uint value);

    function approve(address spender, uint value);
}
