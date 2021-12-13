pragma solidity >=0.5.0 <0.9.0;

contract Token{
    string public name = "Arnab";
    string public symbol = "AB";
    uint256 public decimals = 18;
    uint256 public totalSupply;

    constructor() public {
        totalSupply = 1000000 * (10 ** decimals);
    }
}