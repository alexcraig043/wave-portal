pragma solidity ^0.8.0;

import "hardhat/console.sol";

contract WavePortal {
    address addressOfMostWaves;
    uint numberOfMostWaves;

    mapping(address => uint) public wavesByAddress;
    uint256 totalWaves;

    constructor() {
        console.log("Yo yo, I am a contract and I am smart");
    }

    function wave() public {
        totalWaves += 1;
        console.log("%s has waved!", msg.sender);
        wavesByAddress[msg.sender] = wavesByAddress[msg.sender] + 1;

        if (wavesByAddress[msg.sender] > numberOfMostWaves) {
            addressOfMostWaves = msg.sender;
            numberOfMostWaves = wavesByAddress[msg.sender];
        }
    }

    function getTotalWaves() public view returns (uint256) {
        console.log("We have %d total waves", totalWaves);
        return totalWaves;
    }

    function getWavesOfAddress(address adr) public view returns (uint) {
        console.log(adr, "has waved", wavesByAddress[adr], "times");
        return wavesByAddress[adr];
    }

    function getMostWaves() public view returns (address, uint) {
        console.log(addressOfMostWaves, "has waved the most at", numberOfMostWaves, "waves!");
        return (addressOfMostWaves, numberOfMostWaves);
    }
}