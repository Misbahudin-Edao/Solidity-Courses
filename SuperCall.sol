// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

import "./Hero.sol";

contract Mage is Hero(50) {
    function attack(Enemy enemy) public override {
        // Mage specific attack
        enemy.takeAttack(AttackTypes.Spell);

        // Call base attack to decrement energy
        super.attack(enemy);
    }
}

contract Warrior is Hero(200) {
    function attack(Enemy enemy) public override {
        // Warrior specific attack
        enemy.takeAttack(AttackTypes.Brawl);

        // Call base attack to decrement energy
        super.attack(enemy);
    }
}
