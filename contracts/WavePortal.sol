pragma solidity ^0.8.0;

import "hardhat/console.sol";

contract WavePortal {
    address addressOfMostWaves;
    uint32 mostWaves;
    mapping(address => uint32) public wavesByAddress;

    function getWavesOfAddress(address adr) public view returns (uint32) {
        console.log(adr, "has waved", wavesByAddress[adr], "times");
        return wavesByAddress[adr];
    }

    function getMostWaves() public view returns (address, uint32) {
        console.log(addressOfMostWaves, "has waved the most at", mostWaves, "waves!");
        return (addressOfMostWaves, mostWaves);
    }

    uint256 totalWaves;

    /*
     * A little magic, Google what events are in Solidity!
     */
    event NewWave(address indexed from, uint256 timestamp, string message);

    /*
     * I created a struct here named Wave.
     * A struct is basically a custom datatype where we can customize what we want to hold inside it.
     */
    struct Wave {
        address waver; // The address of the user who waved.
        string message; // The message the user sent.
        uint256 timestamp; // The timestamp when the user waved.
    }

    /*
     * I declare a variable waves that lets me store an array of structs.
     * This is what lets me hold all the waves anyone ever sends to me!
     */
    Wave[] waves;

    constructor() {
        console.log("I AM SMART CONTRACT. POG.");
    }

    /*
     * You'll notice I changed the wave function a little here as well and
     * now it requires a string called _message. This is the message our user
     * sends us from the frontend!
     */
    function wave(string memory _message) public {
        totalWaves += 1;
        console.log("%s waved w/ message %s", msg.sender, _message);
        
        wavesByAddress[msg.sender] = wavesByAddress[msg.sender] + 1;

        /*
         * This is where I actually store the wave data in the array.
         */
        waves.push(Wave(msg.sender, _message, block.timestamp));

        if (wavesByAddress[msg.sender] > mostWaves) {
            addressOfMostWaves = msg.sender;
            mostWaves = wavesByAddress[msg.sender];
        }

        /*
         * I added some fanciness here, Google it and try to figure out what it is!
         * Let me know what you learn in #general-chill-chat
         */
        emit NewWave(msg.sender, block.timestamp, _message);

    }

    /*
     * I added a function getAllWaves which will return the struct array, waves, to us.
     * This will make it easy to retrieve the waves from our website!
     */
    function getAllWaves() public view returns (Wave[] memory) {
        return waves;
    }

    function getTotalWaves() public view returns (uint256) {
        // Optional: Add this line if you want to see the contract print the value!
        // We'll also print it over in run.js as well.
        console.log("We have %d total waves!", totalWaves);
        return totalWaves;
    }

} 