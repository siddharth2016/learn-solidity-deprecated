pragma solidity >=0.5.0;

import "./zombiehelper.sol";

contract ZombieAttack is ZombieHelper {

    uint randNonce = 0;

    uint attackVictoryProbability = 70;

    function randNumber(uint _modulus) internal returns (uint) {
        randNonce++;
        return uint(keccak256(abi.encodePacked(block.timestamp, msg.sender, randNonce)));
    }

    function attack(uint _zombieId, uint _targetId) external {
        
    }
}