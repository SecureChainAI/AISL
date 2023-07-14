function Play(string guess) public payable {
    require(isActive && msg.value >= 0.5 ether);
    if (bytes(guess).length == 0) return;

    Guess newGuess;
    newGuess.player = msg.sender;
    newGuess.guess = guess;
    PreviousGuesses.push(newGuess);

    if (keccak256(guess) == answerHash) {
        Answer = guess;
        isActive = false;
        msg.sender.transfer(this.balance);
    }
}

function End(string _answer) public {
    require(msg.sender == riddler);
    Answer = _answer;
    isActive = false;
    msg.sender.transfer(this.balance);
}
