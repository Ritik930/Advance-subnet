# Advance-subnet
# ERC20 Token and Vault Contract

This Solidity smart contract implementation includes an ERC20 token and a vault for managing deposits and withdrawals with a fee system. Users can interact with the token and store their assets securely.

## Contract Details

**SPDX-License-Identifier:** MIT  
**Solidity Version:** ^0.8.17

### ERC20 Token

#### State Variables

- `totalSupply`: Total supply of the token.
- `balanceOf`: Mapping to track balances of each address.
- `allowance`: Mapping to track approved allowances.
- `name`: Name of the token.
- `symbol`: Symbol of the token.
- `decimals`: Number of decimal places.
- `maxSupply`: Maximum supply of the token.
- `owner`: Address of the contract owner.
- `paused`: Boolean indicating if transfers are paused.

#### Events

- `Transfer`: Emitted when tokens are transferred.
- `Approval`: Emitted when an approval is made.
- `Mint`: Emitted when new tokens are minted.
- `Burn`: Emitted when tokens are burned.
- `Paused`: Emitted when transfers are paused.
- `Unpaused`: Emitted when transfers are unpaused.

#### Functions

- `constructor(uint initialSupply)`: Sets the contract owner and mints initial tokens.
- `transfer(address recipient, uint amount)`: Transfers tokens to a recipient. Emits the `Transfer` event.
- `approve(address spender, uint amount)`: Approves an address to spend tokens on behalf of the caller.
- `transferFrom(address sender, address recipient, uint amount)`: Transfers tokens from one address to another.
- `mint(uint amount)`: Mints new tokens. Can only be called by the owner.
- `burn(uint amount)`: Burns tokens from the caller's balance. Can only be called by the owner.
- `pause()`: Pauses all token transfers. Can only be called by the owner.
- `unpause()`: Resumes token transfers. Can only be called by the owner.

### Vault Contract

#### State Variables

- `token`: The ERC20 token being managed by the vault.
- `totalSupply`: Total shares issued by the vault.
- `balanceOf`: Mapping to track user shares.
- `depositors`: Array of addresses that have deposited.
- `feePercent`: Percentage fee on deposits and withdrawals.
- `accumulatedFees`: Accumulated fees for distribution.

#### Events

- `Deposited`: Emitted when a user deposits tokens.
- `Withdrawn`: Emitted when a user withdraws tokens.

#### Functions

- `deposit(uint _amount)`: Allows users to deposit tokens into the vault. Emits the `Deposited` event.
- `withdraw(uint _shares)`: Allows users to withdraw tokens based on their shares. Emits the `Withdrawn` event.

## Getting Started

### Prerequisites

- Access to an Ethereum development environment (e.g., Hardhat, Truffle, or Remix IDE).

### Deploying the Contracts

#### Compile the Contracts:

1. Copy the contract code into your Solidity IDE (e.g., Remix).
2. Ensure the Solidity compiler version is set to ^0.8.17.
3. Compile the contracts.

#### Deploy the Contracts:

1. Go to the "Deploy & Run Transactions" tab in your IDE.
2. Click on the "Deploy" button to deploy the ERC20 contract.
3. Deploy the Vault contract by passing the address of the deployed ERC20 contract.

### Interacting with the Contracts

#### Deposit Tokens:

- Call the `deposit(uint _amount)` function on the Vault contract to deposit tokens.

#### Withdraw Tokens:

- Call the `withdraw(uint _shares)` function on the Vault contract to withdraw tokens based on your shares.

#### Mint and Burn Tokens:

- The owner can call `mint(uint amount)` to mint new tokens or `burn(uint amount)` to burn tokens.

## Authors

- Ritik Kumar (https://www.linkedin.com/in/ritik-kumar-8376ba225/)

## License

This project is licensed under the MIT License - see the LICENSE file for details.

