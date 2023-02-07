// SPDX-License-Identifier:GPL-3.0
pragma solidity ^0.8.0;

contract Banking{
    mapping(address => uint256) public balances;
    address payable owner;

    constructor() {
        owner = payable(msg.sender);
    }

    function deposit() public payable {
        require(msg.value > 0,"Deposit amount must greater than 0");
        balances[msg.sender] += msg.value;
    }

    function withdraw(uint256 amount) public {
        require(amount <= balances[msg.sender],"Insufficient Funds");
        require(amount > 0,"Withdrawal amount must be greater than zero");
        payable(msg.sender).transfer(amount);
        balances[msg.sender] -= amount;
    }

    function transfer(address payable recipient, uint256 amount) public{
        require(amount <= balances[msg.sender],"you dont have balance to transfer");
        require(amount > 0,"Transfer amount should be greater than zero");
        balances[msg.sender] -= amount;
        balances[recipient] += amount;
    }
    function getBalance(address payable user) public view returns(uint256){
        return balances[user];
    }
     

    function grantAccess(address payable user) public{
        require(msg.sender == owner,"Only owner can grant access");
        owner = user;
    }

    function destroy() public {
        require(msg.sender == owner,"Only the owner can destroy the contract.");
        selfdestruct(owner);
    }
}