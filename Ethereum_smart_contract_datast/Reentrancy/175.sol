function finalizeCrowdSale() external {
    require(!isCrowdSaleFinalized);
    require(multisig != 0 && vault != 0 && now > end);
    require(safeAdd(totalSupply, 250000000 ether) <= maxTokenSupply);
    assignTokens(multisig, 250000000 ether);
    require(safeAdd(totalSupply, 150000000 ether) <= maxTokenSupply);
    assignTokens(vault, 150000000 ether);
    isCrowdSaleFinalized = true;
    require(multisig.send(address(this).balance));
}
