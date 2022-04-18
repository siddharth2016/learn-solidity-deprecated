pragma solidity >=0.5.0;

import "./ownable.sol";

contract ZombieFactory is Ownable {
    event NewZombie(uint id, string name, uint dna);

    uint dnaDigits = 16;
    uint dnaModulus = 10 ** dnaDigits;
    uint cooldownTime = 1 days;

    struct Zombie {
        string name;
        uint dna;
        uint32 level;
        uint32 readyTime;
    }

    Zombie[] public zombies;

    mapping (uint => address) public zombieToOwner;
    mapping (address => uint) ownerZombieCount;

    function _createZombie(string memory _name, uint _dna) internal {
        zombies.push(Zombie(_name, _dna, 1, uint32(block.timestamp + cooldownTime)));
        zombieToOwner[zombies.length - 1] = msg.sender;
        ownerZombieCount[msg.sender]++;
        emit NewZombie(zombies.length - 1, _name, _dna);
    }

    function _generateRandomDna(string memory _name) private view returns (uint){
        uint rand = uint(keccak256(abi.encodePacked(_name)));
        return rand % dnaModulus;
    }

    function createRandomZombie(string memory _name) public {
        require(ownerZombieCount[msg.sender] == 0);
        uint dna = _generateRandomDna(_name);
        _createZombie(_name, dna);
    }
}