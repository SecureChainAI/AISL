function safeTransferFrom(
    ERC20 token,
    address from,
    address to,
    uint256 value
) internal {
    assert(token.transferFrom(from, to, value));
}
