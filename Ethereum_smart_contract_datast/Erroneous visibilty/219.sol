interface AccountRegistryInterface {
    function accountIdForAddress(
        address _address
    ) public view returns (uint256);

    function addressBelongsToAccount(
        address _address
    ) public view returns (bool);
}
