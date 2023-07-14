function transferOwnership(address newOwner) onlyOwner {
    if (newOwner != address(0)) {
        owner = newOwner;
    }
}
