interface IBridgeValidators {
    function isValidator(address _validator) public view returns(bool);
    function requiredSignatures() public view returns(uint256);
    function owner() public view returns(address);
}