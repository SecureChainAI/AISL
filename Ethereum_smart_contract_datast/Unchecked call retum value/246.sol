function saveRN(uint _block) public {
    if (blockhash(_block) != 0x0)
        randomNumber[_block] = uint(blockhash(_block));
    if (randomNumber[_block] != 0) {
        // If the number is set.
        uint rewardToSend = reward[_block];
        reward[_block] = 0;
        msg.sender.send(rewardToSend); // Note that the use of send is on purpose as we don't want to block in case msg.sender has a fallback issue.
    }
}

function saveRN(uint _block) public {
    if (_block < block.number && randomNumber[_block] == 0) {
        // If the random number is not already set and can be.
        if (blockhash(_block) != 0x0)
            // Normal case.
            randomNumber[_block] = uint(blockhash(_block)); // The contract was not called in time. Fallback to returning previous blockhash.
        else randomNumber[_block] = uint(blockhash(block.number - 1));
    }
    if (randomNumber[_block] != 0) {
        // If the random number is set.
        uint rewardToSend = reward[_block];
        reward[_block] = 0;
        msg.sender.send(rewardToSend); // Note that the use of send is on purpose as we don't want to block in case the msg.sender has a fallback issue.
    }
}
