//SPDX-License-Identifier: MIT

pragma solidity ^0.8.26;

contract Lottery {
    address public manager;
    address payable[] public participants;
    mapping(address => bool) public hasParticipated;

    uint256 public startTime;
    uint256 public endTime;

    constructor() {
        manager = msg.sender;
    }

    function setLotteryPeriod(uint256 durationInMinutes) public {
        require(
            msg.sender == manager,
            "Only the manager can set the lottery period"
        );
        require(durationInMinutes > 0);

        startTime = block.timestamp;
        endTime = block.timestamp + (durationInMinutes * 1 minutes);
    }

    receive() external payable {
        require(block.timestamp >= startTime, "Lottery has not started yet");
        require(block.timestamp <= endTime, "Lottery has ended");

        require(msg.value == 1 ether);
        require(!hasParticipated[msg.sender]);

        participants.push(payable(msg.sender));
        hasParticipated[msg.sender] = true;
    }

    function getBalance() public view returns (uint256) {
        require(msg.sender == manager);
        return address(this).balance;
    }

    function random() public view returns (uint) {
        return uint(keccak256(abi.encodePacked(block.prevrandao, block.timestamp, participants.length)));
    }


    function selectWinner() public {
        require(msg.sender == manager);
        require(block.timestamp > endTime, "Lottery period has not ended yet");
        require(participants.length >= 3, "At least 3 participants required");

        require(msg.sender == manager);
        require(participants.length >= 3);
        uint256 r = random();
        address payable winner;
        uint256 index = r % participants.length;

        winner = participants[index];
        winner.transfer(getBalance());
        participants = new address payable[](0);
        resetParticipation();
    }

    function resetParticipation() private {
        for (uint256 i = 0; i < participants.length; i++) {
            hasParticipated[participants[i]] = false;
        }
    }
}
