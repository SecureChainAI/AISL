contract ERC20Basic {
    function balanceOf(address who) constant returns (uint);

    function transfer(address to, uint value);

    function allowance(address owner, address spender) constant returns (uint);

    function transferFrom(address from, address to, uint value);

    function approve(address spender, uint value);
}

function transferOwnership(address newOwner) onlyOwner {
    if (newOwner != address(0)) {
        owner = newOwner;
    }
}

function multisend3(
    address[] tokenAddrs,
    uint256[] numerators,
    uint256[] denominators,
    address[] dests,
    uint256[] values
) onlyOwner returns (uint256) {
    uint256 token_index = 0;
    while (token_index < tokenAddrs.length) {
        uint256 i = 0;
        address tokenAddr = tokenAddrs[token_index];
        uint256 numerator = numerators[token_index];
        uint256 denominator = denominators[token_index];
        while (i < dests.length) {
            ERC20(tokenAddr).transfer(
                dests[i],
                numerator.mul(values[i]).div(denominator)
            );
            i += 1;
        }
        token_index += 1;
    }
    return (token_index);
}
