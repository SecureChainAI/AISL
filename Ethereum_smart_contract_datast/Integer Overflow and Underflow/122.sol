    function deposit() public payable {
        if (msg.value >= 0.5 ether) {
            deposits[msg.sender] += msg.value;
        }
    }