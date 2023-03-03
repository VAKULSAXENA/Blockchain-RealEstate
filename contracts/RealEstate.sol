// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

// import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";


contract RealEstate is ERC721URIStorage {

    using Counters for Counters.Counter;
    Counters.Counter private tokenId;

    constructor() ERC721("Real Estate","R"){

    }

    function mintNFT(string memory tokenURI) public returns (uint256){
        tokenId.increment();
        uint256 newId=tokenId.current();
        _mint(msg.sender,newId);
        _setTokenURI(newId, tokenURI);
        return newId;
    }


}