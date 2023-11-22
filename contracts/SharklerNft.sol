// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract SharklerNft is ERC721, ERC721URIStorage, Ownable {
    uint256 private _nextTokenId;
    mapping(string => uint8) existingURIs;

    constructor(
        address initialOwner
    ) ERC721("SharklerNft", "SKR") Ownable(initialOwner) {}

    function withdrawAll(
        address recipient
    ) public onlyOwner {
        withdraw(recipient, address(this).balance);
    }

    function withdraw(
        address recipient,
        uint256 amount
    ) public onlyOwner {
        uint256 balance = address(this).balance;
        require(balance > 0, "Nothing to withdraw; contract balance empty");
        require(balance >= amount, "Contract insuffcient fund");

        (bool sent, ) = payable(recipient).call{value: amount}("");
        require(sent, "Failed to send Ether");
    }

    function freeMint(
        address recipient,
        string memory metadataURI
    ) public onlyOwner returns (uint256) {
        return mintDedup(recipient, metadataURI);
    }

    function payToMint(
        address recipient,
        string memory metadataURI
    ) public payable returns (uint256) {
        require(msg.value >= 0.05 ether, "Need to pay up!");
        return mintDedup(recipient, metadataURI);
    }

    function mintDedup(
        address recipient,
        string memory metadataURI
    ) private returns (uint256) {
        require(existingURIs[metadataURI] != 1, "NFT already minted!");
        uint256 newItemId = _nextTokenId++;
        existingURIs[metadataURI] = 1;

        _safeMint(recipient, newItemId);
        _setTokenURI(newItemId, metadataURI);
        return newItemId;
    }

    function isContentOwned(string memory uri) public view returns (bool) {
        return existingURIs[uri] == 1;
    }

    function count() public view returns (uint256) {
        return _nextTokenId;
    }

    // The following functions are overrides required by Solidity.

    function tokenURI(
        uint256 tokenId
    ) public view override(ERC721, ERC721URIStorage) returns (string memory) {
        return super.tokenURI(tokenId);
    }

    function supportsInterface(
        bytes4 interfaceId
    ) public view override(ERC721, ERC721URIStorage) returns (bool) {
        return super.supportsInterface(interfaceId);
    }
}
