function ownerSafeWithdrawal() external onlyOwner {
    beneficiary.transfer(this.balance);
}
