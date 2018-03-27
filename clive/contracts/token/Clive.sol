pragma solidity 0.4.19;

import 'zeppelin-solidity/contracts/token/ERC20/BurnableToken.sol';

contract Clive is BurnableToken {
    string public name = "CLIVE";
    string public symbol = "CLI";
    uint8 public decimals = 18;

/*    function Clive() public {
        totalSupply_ = 3000000;
    }*/
}
