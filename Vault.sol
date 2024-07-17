// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

interface IERC20 {
    function totalSupply() external view returns (uint);

    function balanceOf(address account) external view returns (uint);

    function transfer(address recipient, uint amount) external returns (bool);

    function allowance(address owner, address spender) external view returns (uint);

    function approve(address spender, uint amount) external returns (bool);

    function transferFrom(
        address sender,
        address recipient,
        uint amount
    ) external returns (bool);

    event Transfer(address indexed from, address indexed to, uint value);
    event Approval(address indexed owner, address indexed spender, uint value);
}

contract Vault {
    IERC20 public immutable token;

    uint public totalSupply;
    mapping(address => uint) public balanceOf;
    address[] public depositors;

    uint public feePercent = 1; // 1% fee on deposits and withdrawals
    uint public accumulatedFees; // Accumulated fees to be distributed as dividends

    event Deposited(address indexed account, uint amount, uint shares);
    event Withdrawn(address indexed account, uint amount, uint shares, uint fee);

    constructor(address _token) {
        token = IERC20(_token);
    }

    function _mint(address _to, uint _shares) private {
        if (balanceOf[_to] == 0) {
            depositors.push(_to);
        }
        totalSupply += _shares;
        balanceOf[_to] += _shares;
    }

    function _burn(address _from, uint _shares) private {
        balanceOf[_from] -= _shares;
        if (balanceOf[_from] == 0) {
            // Remove _from from depositors array
            for (uint i = 0; i < depositors.length; i++) {
                if (depositors[i] == _from) {
                    depositors[i] = depositors[depositors.length - 1];
                    depositors.pop();
                    break;
                }
            }
        }
        totalSupply -= _shares;
    }

    function deposit(uint _amount) external {
        uint fee = (_amount * feePercent) / 100;
        uint amountAfterFee = _amount - fee;
        uint shares;

        if (totalSupply == 0) {
            shares = amountAfterFee;
        } else {
            shares = (amountAfterFee * totalSupply) / (token.balanceOf(address(this)) + accumulatedFees);
        }

        _mint(msg.sender, shares);
        accumulatedFees += fee;
        require(token.transferFrom(msg.sender, address(this), _amount), "Transfer failed");
        emit Deposited(msg.sender, _amount, shares);
    }

    function withdraw(uint _shares) external {
        uint tokenBalance = token.balanceOf(address(this));
        uint amount = (_shares * (tokenBalance + accumulatedFees)) / totalSupply;
        uint fee = (amount * feePercent) / 100;
        uint amountAfterFee = amount - fee;

        _burn(msg.sender, _shares);
        accumulatedFees += fee;
        require(token.transfer(msg.sender, amountAfterFee), "Transfer failed");
        emit Withdrawn(msg.sender, amount, _shares, fee);
    }
}
