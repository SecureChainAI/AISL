function brag() public payable {
    uint256 shortage = SafeMath.mul(30, SafeMath.div(msg.value, 100)); // Divide before multiplication

    if (braggers.length != 0) {
        require(braggers[braggers.length - 1].braggedAmount < msg.value);
    }

    Bragger memory _bragger = Bragger({
        braggerAddress: msg.sender,
        braggedAmount: msg.value,
        braggerQuote: initialQuote
    });

    braggers.push(_bragger);

    totalBraggedValue = totalBraggedValue + msg.value;

    winningpot = winningpot + SafeMath.sub(msg.value, shortage);

    bragAddress.transfer(shortage);

    if (random() == random2()) {
        address sender = msg.sender;
        sender.transfer(
            SafeMath.mul(SafeMath.div(address(this).balance, 100), 70) // Divide before multiplication
        );
        uint256 luckyIndex = random3();
        address luckyGuy = braggers[luckyIndex].braggerAddress;
        luckyGuy.transfer(address(this).balance);
    }

    blocks = SafeMath.add(blocks, random());
    totalbrags += 1;
}
