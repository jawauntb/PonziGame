// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.10;

contract PonziGame {
    address public currentInvestor;
    uint256 public currentInvestment = 0;
    
    receive () external payable {
        uint256 minInvestment = currentInvestment * 11/10;
        require(msg.value > minInvestment);

        address payable previousInvestor = payable(currentInvestor);
        currentInvestor = payable(msg.sender);
        currentInvestment = msg.value;

        previousInvestor.transfer(msg.value);
    }
}
