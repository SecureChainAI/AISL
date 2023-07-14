function transfer(address _to, uint256 _value) {
    if (balanceOf[msg.sender] < _value) throw; // Check if the sender has enough
    if (balanceOf[_to] + _value < balanceOf[_to]) throw; // Check for overflows
    balanceOf[msg.sender] -= _value; // Subtract from the sender
    balanceOf[_to] += _value; // Add the same to the recipient
}

/* This unnamed function is called whenever someone tries to send ether to it */
function() {
    throw; // Prevents accidental sending of ether
}
