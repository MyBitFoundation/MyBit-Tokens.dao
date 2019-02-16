/*
 * SPDX-License-Identitifer:    GPL-3.0-or-later
 *
 * This file requires contract dependencies which are licensed as
 * GPL-3.0-or-later, forcing it to also be licensed as such.
 *
 * This is the only file in your project that requires this license and
 * you are free to choose a different license for the rest of the project.
 */

pragma solidity 0.4.24;

import "@aragon/os/contracts/factory/DAOFactory.sol";
import "@aragon/os/contracts/apm/Repo.sol";
import "@aragon/os/contracts/lib/ens/ENS.sol";
import "@aragon/os/contracts/lib/ens/PublicResolver.sol";
import "@aragon/os/contracts/apm/APMNamehash.sol";

import "@aragon/apps-voting/contracts/Voting.sol";
import "@aragon/apps-vault/contracts/Vault.sol";
//import "@aragon/apps-finance/contracts/Finance.sol";
import "./TokenLocker.sol";
import "./StandardToken.sol";
import "./TokenSale.sol";
import "@aragon/apps-shared-minime/contracts/MiniMeToken.sol";

contract KitBase is APMNamehash {
    ENS public ens;
    DAOFactory public fac;

    event DeployInstance(address dao);
    event InstalledApp(address appProxy, bytes32 appId);

    constructor(DAOFactory _fac, ENS _ens) {
        ens = _ens;

        // If no factory is passed, get it from on-chain bare-kit
        if (address(_fac) == address(0)) {
            bytes32 bareKit = apmNamehash("bare-kit");
            fac = KitBase(latestVersionAppBase(bareKit)).fac();
        } else {
            fac = _fac;
        }
    }

    function latestVersionAppBase(bytes32 appId) public view returns (address base) {
        Repo repo = Repo(PublicResolver(ens.resolver(appId)).addr(appId));
        (,base,) = repo.getLatest();

        return base;
    }
}

contract Kit is KitBase {
    MiniMeTokenFactory tokenFactory;

    uint64 constant PCT = 10 ** 16;
    address constant ANY_ENTITY = address(-1);
    uint64 constant PERIOD = 2592000; //30 days
    uint256 constant TOKEN_SUPPLY = 10**30;

    string tokenName = 'MyBit';
    string tokenSym = 'MYB';
    uint8 tokenDecimals = 18;
    //uint256 lockAmount = 10**23;
    uint256[] lockAmounts = [10**21, 10**22, 10**23];
    uint256[] lockIntervals = [0, 3, 12];
    uint256[] tokenIntervals = [1, 2, 3];

    constructor(ENS ens) KitBase(DAOFactory(0), ens) {
        tokenFactory = new MiniMeTokenFactory();
    }

    function newInstance() {
        Kernel dao = fac.newDAO(this);
        ACL acl = ACL(dao.acl());
        acl.createPermission(this, dao, dao.APP_MANAGER_ROLE(), this);
        address root = msg.sender;
        bytes32 votingAppId = apmNamehash("voting");
        bytes32 vaultAppId = apmNamehash("vault");
        //bytes32 financeAppId = apmNamehash("finance");
        bytes32 tokenLockerAppId = apmNamehash("token-locker");

        Vault vault = Vault(dao.newAppInstance(vaultAppId, latestVersionAppBase(vaultAppId)));
        //Finance finance = Finance(dao.newAppInstance(financeAppId, latestVersionAppBase(financeAppId)));
        Voting voting = Voting(dao.newAppInstance(votingAppId, latestVersionAppBase(votingAppId)));
        TokenLocker tokenLocker = TokenLocker(dao.newAppInstance(tokenLockerAppId, latestVersionAppBase(tokenLockerAppId)));

        MiniMeToken token = tokenFactory.createCloneToken(MiniMeToken(0), 0, "MyVote", 0, "MYV", true);
        //token.generateTokens(msg.sender, 1);
        token.changeController(tokenLocker);

        StandardToken erc20 = new StandardToken(tokenName, tokenSym, tokenDecimals, TOKEN_SUPPLY);
        TokenSale tokensale = new TokenSale(address(erc20), address(0), address(0));
        erc20.transfer(msg.sender, TOKEN_SUPPLY/4);
        //erc20.transfer(address(0x8401Eb5ff34cc943f096A32EF3d5113FEbE8D4Eb), TOKEN_SUPPLY/4);
        erc20.approve(address(tokensale), TOKEN_SUPPLY/2);
        tokensale.startSale(now);
        tokensale.fund(0, 10**18, address(0xb4124cEB3451635DAcedd11767f004d8a28c6eE7));
        tokensale.fund(1, 10**18, address(0x8401Eb5ff34cc943f096A32EF3d5113FEbE8D4Eb));

        // Initialize apps
        vault.initialize();
        //finance.initialize(vault, PERIOD);
        tokenLocker.initialize(token, address(erc20), address(tokensale), address(vault), lockAmounts, lockIntervals, tokenIntervals);
        voting.initialize(token, 50 * PCT, 20 * PCT, 1 days);

        //acl.createPermission(this, tokenLocker, tokenLocker.LOCK_ROLE(), this);
        //tokenLocker.mint(root, 1); // Give one token to root
        acl.createPermission(ANY_ENTITY, voting, voting.CREATE_VOTES_ROLE(), root);
        acl.createPermission(voting, tokenLocker, tokenLocker.BURN_ROLE(), voting);
        acl.createPermission(voting, vault, vault.TRANSFER_ROLE(), voting);
        /*
        acl.createPermission(finance, vault, vault.TRANSFER_ROLE(), voting);
        acl.createPermission(voting, finance, finance.CREATE_PAYMENTS_ROLE(), voting);
        acl.createPermission(voting, finance, finance.EXECUTE_PAYMENTS_ROLE(), voting);
        acl.createPermission(voting, finance, finance.MANAGE_PAYMENTS_ROLE(), voting);
        */

        // Clean up permissions
        acl.grantPermission(root, dao, dao.APP_MANAGER_ROLE());
        acl.revokePermission(this, dao, dao.APP_MANAGER_ROLE());
        acl.setPermissionManager(root, dao, dao.APP_MANAGER_ROLE());

        acl.grantPermission(root, acl, acl.CREATE_PERMISSIONS_ROLE());
        acl.revokePermission(this, acl, acl.CREATE_PERMISSIONS_ROLE());
        acl.setPermissionManager(root, acl, acl.CREATE_PERMISSIONS_ROLE());

        emit DeployInstance(dao);
    }
}
