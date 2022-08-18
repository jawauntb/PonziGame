// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.10;

contract GradualPonzi {
    address[] public investors;
    mapping (address => uint256) public balances;
    uint256 public constant MINIMUM_INVESTMENT = 1e15;

    constructor () {
        investors.push(msg.sender);
    }

    receive () external payable {
        require(msg.value >= MINIMUM_INVESTMENT);
        uint256 investorPayout = msg.value/investors.length;
        for (uint256 i=0; i< investors.length; i++){
            balances[investors[i]] += investorPayout;
        }
        investors.push(msg.sender);
    }

    function withdraw() public {
        uint256 payout = balances[msg.sender];
        balances[msg.sender] = 0;
        payable(msg.sender).transfer(payout);
    }
        
}