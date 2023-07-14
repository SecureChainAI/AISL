function setNewAddress(address newContract) external onlyCEO whenPaused {
    newContractAddress = newContract;
    emit ContractUpgrade(newContract);
}
