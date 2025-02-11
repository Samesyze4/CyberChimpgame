// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract CyberChimpToken is ERC20, Ownable {
    uint256 public constant MAX_SUPPLY = 5000000 * 10**18;
    mapping(address => bool) public approvedContracts;
    mapping(address => uint256) public playerMiningRewards;

    event ContractApproved(address indexed contractAddress, bool status);
    event MiningRewardClaimed(address indexed player, uint256 amount);

    constructor() ERC20("CyberChimp Token", "CYBERCHYMP") {
        _mint(msg.sender, MAX_SUPPLY);
    }

    function approveContract(address contractAddress, bool status) external onlyOwner {
        approvedContracts[contractAddress] = status;
        emit ContractApproved(contractAddress, status);
    }

    function transferFrom(address sender, address recipient, uint256 amount) public override returns (bool) {
        require(approvedContracts[msg.sender] || sender == owner(), "Contract not approved");
        return super.transferFrom(sender, recipient, amount);
    }

    function setMiningReward(address player, uint256 amount) external {
        require(approvedContracts[msg.sender], "Only approved contracts can set rewards");
        playerMiningRewards[player] += amount;
    }

    function claimMiningReward() external {
        uint256 reward = playerMiningRewards[msg.sender];
        require(reward > 0, "No mining rewards available");
        require(totalSupply() + reward <= MAX_SUPPLY, "Max supply reached");
        _mint(msg.sender, reward);
        playerMiningRewards[msg.sender] = 0;
        emit MiningRewardClaimed(msg.sender, reward);
    }
}
