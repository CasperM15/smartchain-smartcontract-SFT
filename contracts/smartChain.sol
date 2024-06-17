// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.24;

import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Strings.sol";

contract SmartChainSFT is ERC1155, Ownable {
        using Strings for uint256;

    uint256 private _currentTokenID = 0;
    mapping(uint256 => uint256) public tokenSupply;
    mapping(uint256 => string) private _tokenURIs; 
    string private _baseURI;

    constructor(string memory baseURI) ERC1155("") {
        _baseURI = baseURI;
    }

    function create(address[] memory recipients) public onlyOwner returns (uint256) {
        uint256 newTokenID = _currentTokenID;
        _currentTokenID++;

        for (uint256 i = 0; i < recipients.length; i++) {
            _mint(recipients[i], newTokenID, 1, "");
            tokenSupply[newTokenID] += 1;

            string memory tokenURI = string(abi.encodePacked(_baseURI, newTokenID.toString(), ".json"));
            _setTokenURI(newTokenID, tokenURI);
        }

        return newTokenID;
    }

    function createExisting(uint256 tokenId, address[] memory recipients) public onlyOwner {
        require(tokenSupply[tokenId] > 0, "Token ID does not exist");

        for (uint256 i = 0; i < recipients.length; i++) {
            _mint(recipients[i], tokenId, 1, ""); 
            tokenSupply[tokenId] += 1;
        }
    }

    function _setTokenURI(uint256 tokenID, string memory tokenURI) internal {
        _tokenURIs[tokenID] = tokenURI;
        emit URI(tokenURI, tokenID);
    }

    function uri(uint256 tokenID) public view override returns (string memory) {
        require(tokenSupply[tokenID] > 0, "ERC1155Metadata: URI query for nonexistent token");
        string memory baseURI = _baseURI;
        return string(abi.encodePacked(baseURI, tokenID.toString(), ".json"));
    }

    function totalSupply(uint256 tokenID) public view returns (uint256) {
        return tokenSupply[tokenID];
    }

    function setBaseURI(string memory newBaseURI) public onlyOwner {
        _baseURI = newBaseURI;
    }
}
