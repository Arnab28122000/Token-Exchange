// SPDX-License-Identifier: MIT
pragma solidity >=0.5.0 <0.9.0;

import "openzeppelin-solidity/contracts/math/SafeMath.sol";

import "./Token.sol";

// TODO:
// [X] Set the fee account
// [X] Deposit Ether
// [X] Withdraw Ether
// [X] Deposit tokens
// [X] Withdraw Tokens
// [X] Check Balances
// [ ] Make Orders
// [ ] Cancel order
// [ ] Fill Order
// [ ] Charge Fees

contract Exchange{
    using SafeMath for uint;

    // Variables
    address public feeAccount;// the account that receives exchange fees
    uint256 public feePercent;// the fee percentage
    address constant ETHER = address(0); // store ether in tokens mapping with blank address
    mapping(address => mapping(address => uint256)) public tokens;

    //Events
    event Deposit(address token, address user, uint256 amount, uint256 balance);
    event Withdraw(address token, address user, uint256 amount, uint256 balance);


    constructor(address _feeAccount, uint256 _feePercent) public {
        feeAccount = _feeAccount;
        feePercent = _feePercent;
    }

    // Fallback: reverts if Ether is sent to this smart contract by mistake
    // fallback() external payable {
    //     revert();
    // }

    function depositEther() payable public {
        tokens[ETHER][msg.sender] = tokens[ETHER][msg.sender].add(msg.value);
        emit Deposit(ETHER, msg.sender, msg.value, tokens[ETHER][msg.sender]);
    }

    function withdrawEther(uint _amount) payable public {
        require(tokens[ETHER][msg.sender] >= _amount);
        tokens[ETHER][msg.sender] = tokens[ETHER][msg.sender].sub(_amount);
        msg.sender.transfer(_amount);
        emit Withdraw(ETHER, msg.sender, _amount, tokens[ETHER][msg.sender]);
    }

    function depositToken(address _token, uint256 _amount) public {
        // Don't allow Ether deposits
        require(_token != ETHER);

        require(Token(_token).transferFrom(msg.sender, address(this), _amount));
        tokens[_token][msg.sender] = tokens[_token][msg.sender].add(_amount);
        emit Deposit(_token, msg.sender, _amount, tokens[_token][msg.sender]);
    }

    function withdrawToken(address _token, uint256 _amount) public {
        require(_token != ETHER);
        require(tokens[_token][msg.sender] >= _amount);
        tokens[_token][msg.sender] = tokens[_token][msg.sender].sub(_amount);
        require(Token(_token).transfer(msg.sender, _amount));
        emit Withdraw(_token, msg.sender, _amount, tokens[_token][msg.sender]);
    }

    function balanceOf(address _token, address _user) public view returns (uint256){
        return tokens[_token][_user];
    }
}



