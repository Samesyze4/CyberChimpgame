// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract CyberChimpMembership is ERC721URIStorage, Ownable {
    uint256 public nextTokenId;
    mapping(uint256 => uint256) public expirationTimestamps;
    mapping(address => uint256) public membershipLevel;

    event MembershipMinted(address indexed user, uint256 tokenId, uint256 expiration);
    event MembershipRenewed(address indexed user, uint256 tokenId, uint256 newExpiration);
    event MembershipExpired(uint256 tokenId);

    constructor() ERC721("CyberChimpMembership", "CCM") {}

    function mintMembership(uint8 tier) external {
        require(balanceOf(msg.sender) == 0, "You already own a membership NFT");
        require(tier >= 1 && tier <= 3, "Invalid tier");
        
        uint256 tokenId = nextTokenId++;
        _safeMint(msg.sender, tokenId);
        membershipLevel[msg.sender] = tier;
        expirationTimestamps[tokenId] = block.timestamp + 30 days;
        
        emit MembershipMinted(msg.sender, tokenId, expirationTimestamps[tokenId]);
    }

    function renewMembership(uint256 tokenId) external {
        require(ownerOf(tokenId) == msg.sender, "You do not own this membership");
        require(expirationTimestamps[tokenId] < block.timestamp, "Membership is still active");
        
        expirationTimestamps[tokenId] = block.timestamp + 30 days;
        emit MembershipRenewed(msg.sender, tokenId, expirationTimestamps[tokenId]);
    }

    function checkMembershipDiscount(address user) external view returns (uint8) {
        uint256 level = membershipLevel[user];
        if (level == 1) return 25;
        if (level == 2) return 35;
        if (level == 3) return 50;
        return 0;
    }
    
    function _beforeTokenTransfer(address from, address to, uint256 tokenId, uint256 batchSize) internal override {
        require(from == address(0) || to == address(0), "Membership NFTs are non-transferable");
    }

    function expireMembership(uint256 tokenId) external {
        require(expirationTimestamps[tokenId] < block.timestamp, "Membership is still active");
        _burn(tokenId);
        emit MembershipExpired(tokenId);
    }
}
