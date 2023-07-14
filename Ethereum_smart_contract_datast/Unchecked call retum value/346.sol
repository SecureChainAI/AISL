function emergencyERC20Drain(ERC20 token, uint256 amount) external onlyOwner {
    // owner can drain tokens that are sent here by mistake
    token.transfer(owner, amount);
}
