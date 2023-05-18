// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import "@openzeppelin/contracts/utils/Strings.sol";

contract DegenGamingToken is ERC20, Ownable, ERC20Burnable {
    constructor() ERC20("Degen", "DGN") {}
    event Message(string message);

    function decimals() public pure override returns(uint8){
        return 0;
    }
    function mintToken(address to, uint256 amount) public onlyOwner {
        _mint(to, amount);
    }

    function burnToken(uint amount) public {
        require(balanceOf(msg.sender)>=amount,"Balance insufficient");
        _burn(msg.sender, amount);
    }

    function checkBalance() external view returns (uint){
        return this.balanceOf(msg.sender);
    }

    function transferToken(address to, uint amount) external{
        require(balanceOf(msg.sender)>=amount,"Insufficient balance");
        approve(msg.sender,amount);
        transferFrom(msg.sender, to, amount);
    }

    function redeemShop(uint num, uint amount) public payable{
        address owner=0x6dD2ce862Be56e8b20cd1AD4e54288c4D4F2143A;
        if (num==1 && amount>0){
            require(balanceOf(msg.sender)>=(2*amount),"Insufficient balance: Gems cost 2 tokens each");
            transfer(owner, 2*amount);
            emit Message(string.concat("Received ", Strings.toString(amount), " Gem"));
        }
        else if (num==2 && amount>0){
            require(balanceOf(msg.sender)>=(3*amount),"Insufficient balance: Potion cost 3 tokens each");
            transfer(owner, 3*amount);
            emit Message(string.concat("Received ", Strings.toString(amount), " Potion"));
        }
        else if (num==3 && amount>0){
            require(balanceOf(msg.sender)>=(5*amount),"Insufficient balance: Armour cost 5 tokens each");
            transfer(owner, 5*amount);
            emit Message(string.concat("Received ", Strings.toString(amount)," Armour"));
        }
        else{
            revert("Input not included in the redeem Shop");
        }

    }




}
