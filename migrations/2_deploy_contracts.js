var bn = require('bignumber.js')
bn.config({ EXPONENTIAL_AT: 80 })
var Kit = artifacts.require('Kit.sol')
var StandardToken = artifacts.require('StandardToken.sol')

var ENS = '0x98df287b6c145399aaa709692c8d308357bc085d'
var DAOFactory = '0x2298d27a9b847c681d2b2c2828ab9d79013f5f1d';
var tokenName = 'MyBit';
var tokenSym = 'MYB';
var tokenDecimals = '18';
var tokenSupply = bn(10**30).toString();
var lockAmount = bn(10**23).toString();
var lockIntervals = ['0', '3', '12'];
var tokenIntervals = ['1', '2', '3'];
let kit, erc20;

module.exports = function (deployer) {
  deployer.deploy(StandardToken, tokenName, tokenSym, tokenDecimals, tokenSupply);
    /*kit = instance;
    console.log('Kit: ', kit.address)
    return kit.newInstance(erc20.address, lockAmount, lockIntervals, tokenIntervals, {gas:3000000})
  }).then(function(instance){
    console.log(instance)
  })*/
}
