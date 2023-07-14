function play(string guess) public payable {
    require(isActive);
    require(msg.value >= 0.25 ether);
    require(bytes(guess).length > 0);

    Guess newGuess; //Uninitialized storage variables
    newGuess.player = msg.sender;
    newGuess.guess = guess;
    PreviousGuesses.push(newGuess);

    if (keccak256(guess) == answerHash) {
        Answer = guess;
        isActive = false;
        msg.sender.transfer(this.balance);
    }
}
