# Lottery Smart Contract

This project contains a smart contract called `Lottery`, written in Solidity, which enables participants to join a lottery game by sending 1 ether. The manager of the contract can set a lottery period, and after the period ends, a winner is selected randomly. The winner receives the total balance of the contract.

---

## Features

1. **Manager Role**: The manager sets the lottery period and selects the winner.
2. **Participation**: Anyone can participate by sending exactly 1 ether during the active lottery period.
3. **Random Winner Selection**: A winner is chosen randomly using a pseudo-random function.
4. **Participant Restriction**: A single address can only participate once per lottery period.



---

## Instructions

### 1. **Deploy the Contract**

1. Open the Solidity file in your development environment (e.g., Remix).
2. Ensure you have connected your wallet to the desired Ethereum network.
3. Compile the contract using Solidity version `^0.8.26`.
4. Deploy the contract.

### 2. **Set the Lottery Period**

After deployment, only the manager can set the lottery period:

1. Call the `setLotteryPeriod(uint256 durationInMinutes)` function from the deployed contract.
2. Provide the duration in minutes. This sets the start and end time for the lottery.

### 3. **Participate in the Lottery**

Participants can join the lottery by sending exactly 1 ether to the contract address:

1. Use the `receive` function by sending 1 ether to the contract address.
2. Ensure you are participating within the lottery period.

### 4. **Check Contract Balance**

The manager can check the balance of the contract:

1. Call the `getBalance()` function.
2. The function will return the total ether in the contract.

### 5. **Select the Winner**

After the lottery period ends, the manager can select a winner:

1. Call the `selectWinner()` function.
2. Ensure the lottery period has ended and there are at least three participants.
3. The function will transfer the contract balance to the winner and reset the lottery.

---

## Notes

1. Participants cannot join if the lottery period has not started or has already ended.
2. Only the manager can perform administrative actions like setting the lottery period, checking the balance, and selecting the winner.
3. Ensure that participants send exactly 1 ether. Any other amount will result in a failed transaction.
4. The pseudo-random function (`random`) is not secure for production use and should be improved for a real-world scenario.

---

## Example Interaction (Using Remix)

1. **Deploy the Contract**: Deploy `Lottery.sol` in Remix IDE.
2. **Set Lottery Period**: As the manager, call `setLotteryPeriod(10)` to set a 10-minute lottery period.
3. **Participate**: Have multiple addresses send 1 ether to the contract address during the lottery period.
4. **Check Balance**: Call `getBalance()` to view the total ether in the contract.
5. **Select Winner**: After the period ends, call `selectWinner()` to transfer the balance to the randomly selected winner.



