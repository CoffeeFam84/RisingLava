// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import '@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol';
import '@openzeppelin/contracts/access/Ownable.sol';

contract RisingLava is ERC721Enumerable, Ownable {

  using Strings for uint256;

  string _baseTokenURI;
  uint256 private BUYABLE = 10;
  uint256 private PRICE = 0.00004 ether; //0.00004 ETH;
  // address private finance = 0x45DdfeDaDA7D19b2ed38848b0F5Ce183f204Ee16;
  address private finance = 0xBBC6232725EAf504c53A09cFf63b1186BCAc6316;
  uint public constant MAX_ENTRIES = 2500;

  uint256 public sold;

  uint256[MAX_ENTRIES] internal availableIds;

  constructor() 
    ERC721("RisingLava", "RisingLava")  {
    setBaseURI("https://ipfs.io/ipfs/QmS63wPgfr44trva1mrQ5yDrvhqbAfHGp48SaBfbRyKuXi/");
    //premint 10 NFTs
    availableIds[0] = 2499;
    availableIds[1] = 2498;
    availableIds[2] = 2497;
    availableIds[3] = 2496;
    availableIds[4] = 2495;
    availableIds[1750] = 2494;
    availableIds[1751] = 2493;
    availableIds[1752] = 2492;
    availableIds[2250] = 2491;
    availableIds[2251] = 2490;
    _mint(finance , 1);
    _mint(finance , 2);
    _mint(finance , 3);
    _mint(finance , 4);
    _mint(finance , 5);
    _mint(finance , 1751);
    _mint(finance , 1752);
    _mint(finance , 1753);
    _mint(finance , 2251);
    _mint(finance , 2252);
    sold = 10;
  }

  function _getNewId(uint256 _totalMinted) internal returns(uint256 value) {
		uint256 remaining = MAX_ENTRIES - _totalMinted;
    uint rand = uint256(keccak256(abi.encodePacked(msg.sender, block.difficulty, block.timestamp, remaining))) % remaining;
		value = 0;
		// if array value exists, use, otherwise, use generated random value
		if (availableIds[rand] != 0)
			value = availableIds[rand];
		else
			value = rand;
		// store remaining - 1 in used ID to create mapping
		if (availableIds[remaining - 1] == 0)
			availableIds[rand] = remaining - 1;
		else
			availableIds[rand] = availableIds[remaining - 1];

    value += 1;
	} 

  function mint() external payable {
		require(msg.value >= PRICE, "RisingLava: incorrect price");
    uint256 tokenCount = balanceOf(msg.sender);
		require(tokenCount + 1 <= BUYABLE, "RisingLava: Buyable amount has been reached");
    payable(finance).transfer(address(this).balance);
    _mint(msg.sender, _getNewId(sold));
		sold ++;
    PRICE += 0.00004 ether;
  }

  function getPrice() public view returns (uint256){
      return PRICE;
  }

  function _baseURI() internal view virtual override returns (string memory) {
      return _baseTokenURI;
  }

  function setBaseURI(string memory baseURI) public onlyOwner {
      _baseTokenURI = baseURI;
  }

  function tokenURI(uint256 tokenId) public view override returns (string memory) {
    return string(abi.encodePacked(super.tokenURI(tokenId), ".json"));
  }
}