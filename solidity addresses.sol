// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Contract {
    address public owner;
    address public charity;

     constructor(address _charity) {
        owner = msg.sender;
        charity = _charity;
    }
      receive() external payable {}
     function tip() public payable {
        payable(owner).transfer(msg.value);
    }
    function donate() public {
        uint balance = address(this).balance;
        require(balance > 0, "No funds to donate");
        payable(charity).transfer(balance);
        selfdestruct(payable(charity));
    }
}