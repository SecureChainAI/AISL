function withdraw(uint amount) public {
    if (isOwner() && now >= openDate) {
        uint max = deposits[msg.sender];
        if (amount <= max && max > 0) {
            msg.sender.transfer(amount);
        }
    }
}
