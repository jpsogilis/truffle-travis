pragma solidity 0.4.19;


import "../token/Clive.sol";


// mock class using BasicToken
contract CliveMock is Clive {

  function CliveMock(address initialAccount, uint256 initialBalance) public {
    balances[initialAccount] = initialBalance;
    totalSupply_ = initialBalance;
  }

}
