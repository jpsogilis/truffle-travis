pragma solidity 0.4.21;

import "../token/Clive.sol";

contract CliveMock is Clive {

  function CliveMock(address initialAccount, uint256 initialBalance) public {
    balances[initialAccount] = initialBalance;
    totalSupply_ = initialBalance;
  }

}
