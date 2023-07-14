pragma solidity ^0.4.18;

function upgrade(uint256 value) external {
    /*if (getState() != State.Success) throw; // Abort if not in Success state.*/
    require(upgradeAgentStatus); // need a real upgradeAgent address

    // Validate input value.
    require(value > 0 && upgradeAgent.owner() != 0x0);
    require(value <= balances[msg.sender]);

    // update the balances here first before calling out (reentrancy)
    balances[msg.sender] = safeSub(balances[msg.sender], value);
    totalSupply = safeSub(totalSupply, value);
    totalUpgraded = safeAdd(totalUpgraded, value);
    upgradeAgent.upgradeFrom(msg.sender, value);
    Upgrade(msg.sender, upgradeAgent, value);
}

/// @notice Set address of upgrade target contract and enable upgrade
/// process.
/// @param agent The address of the UpgradeAgent contract
function setUpgradeAgent(address agent) external onlyOwner {
    require(agent != 0x0 && msg.sender == upgradeMaster);
    upgradeAgent = UpgradeAgent(agent);
    require(upgradeAgent.isUpgradeAgent());
    // this needs to be called in success condition to guarantee the invariant is true
    upgradeAgentStatus = true;
    upgradeAgent.setOriginalSupply();
    UpgradeAgentSet(upgradeAgent);
}

/// @notice Set address of upgrade target contract and enable upgrade
/// process.
/// @param master The address that will manage upgrades, not the upgradeAgent contract address
function setUpgradeMaster(address master) external {
    require(master != 0x0 && msg.sender == upgradeMaster);
    upgradeMaster = master;
}
