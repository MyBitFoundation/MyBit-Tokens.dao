# MyBit Tokens Aragon App
## Rinkeby Deployment
### mybit-tokens.open.aragonpm.eth v2.0.4:
 - Contract address: 0x6a44c7C94D91D72AbFd5963488CbB2c26e5d9cab
 - Content (ipfs): QmbL2tQjHSNATkzXeEtJkkCjLkNY1p2QKmjNWueaNUZVkX
 - Transaction hash: 0xa6294193dd12f8cad3f90e1b6a65854cc9c8a1eaa6d5cbf8f2ccf63e209df353

### mybit-tokens.open.aragonpm.eth v2.0.3:
 - Contract address: 0x6a44c7C94D91D72AbFd5963488CbB2c26e5d9cab
 - Content (ipfs): QmfE3VdjcYgK1mQUASRYKVvghG7oH1dZs9tpV5DKVNGRBA
 - Transaction hash: 0xe5f385e7b47ca4f1904b5baa99f61ce30038ce4afd0c3a3a28a20157bd65a406

### mybit-tokens.open.aragonpm.eth v2.0.2:
 - Contract address: 0x6a44c7C94D91D72AbFd5963488CbB2c26e5d9cab
 - Content (ipfs): QmR2TQw3ba84hcw9gzZhPHPZMBnFtZ7gP8VoLcSac7QLap
 - Transaction hash: 0x7bfcc41c2575575fd0e82f9eebc9cd522d10c65174a8d225b67d5e5ea51376b1

###  mybit-tokens.open.aragonpm.eth v2.0.1:
 - Contract address: 0x6a44c7C94D91D72AbFd5963488CbB2c26e5d9cab
 - Content (ipfs): QmYMPeuAFtD1pSAChBBycF27TgMmBXvZPDVj5LXvKF99Ke
 - Transaction hash: 0xf0ed2b6b1d92b91854dbcfc55ad135e81a729e9d8e19b9e26a66c059d925ee79

### mybit-tokens.open.aragonpm.eth v2.0.0:
 - Contract address: 0x6a44c7C94D91D72AbFd5963488CbB2c26e5d9cab
 - Content (ipfs): QmSbSjDbjigLZBUTYpAzhxmf7cC6DwYh5ZgzR5ARyNi1gz
 - Transaction hash: 0xff1ea154139de35e7b1958c97855d4f1523638d81a665cb271eece98e8203679

### mybit-tokens.open.aragonpm.eth v1.0.2:
 - Contract address: 0x300d51e1084256B79A5FD09f153B20920b48e150
 - Content (ipfs): QmaRs1fhbxHw22oBA3Hx5UNEEeNAuRjHBvgUYYhweXL6du
 - Transaction hash: 0xae4ea03fc8f9af632e0dcecb5b7db42f0159199be8cdea3816df63b252c2c20e

### mybit-tokens.open.aragonpm.eth v1.0.1:
 - Contract address: 0x300d51e1084256B79A5FD09f153B20920b48e150
 - Content (ipfs): QmYXZaanjYZMyA6ciirpp9HmU9sPMzsMZAA5c2DQJzGSEX
 - Transaction hash: 0x99d4eb4de0e9fcc1ee483605f35f1537bd5b654ff1e18a7774a991d5053fc03e


### mybit-tokens.open.aragonpm.eth v1.0.0:
 - Contract address: 0x300d51e1084256B79A5FD09f153B20920b48e150
 - Content (ipfs): QmWcJR7JTBBKYC46eC4GJqAB3U76TFdd4AUewvdBdjizL3
 - Transaction hash: 0x5d3d6e8bc6e6825411ee69ccb98b97c0c3cbcc6e4dda1e36f2478c8b27e9a762


## Run the kit

```sh
aragon run --kit Kit --kit-init @ARAGON_ENS
```

## Running your app

### Using HTTP

Running your app using HTTP will allow for a faster development process of your app's front-end, as it can be hot-reloaded without the need to execute `aragon run` every time a change is made.

- First start your app's development server running `npm run start:app`, and keep that process running. By default it will rebuild the app and reload the server when changes to the source are made.

- After that, you can run `npm run start:aragon:http` or `npm run start:aragon:http:kit` which will compile your app's contracts, publish the app locally and create a DAO. You will need to stop it and run it again after making changes to your smart contracts.

Changes to the app's background script (`app/script.js`) cannot be hot-reloaded, after making changes to the script, you will need to either restart the development server (`npm run start:app`) or rebuild the script `npm run build:script`.

### Using IPFS

Running your app using IPFS will mimic the production environment that will be used for running your app. `npm run start:aragon:ipfs` will run your app using IPFS. Whenever a change is made to any file in your front-end, a new version of the app needs to be published, so the command needs to be restarted.

## What's in the box?

### npm Scripts

- **start** or **start:aragon:ipfs**: Runs your app inside a DAO served from IPFS
- **start:aragon:http**: Runs your app inside a DAO served with HTTP (hot reloading)
- **start:aragon:ipfs:kit**: Creates a DAO with the Kit and serves the app from IPFS
- **start:aragon:http:kit**: Creates a DAO with the Kit and serves the app with HTTP (hot reloading)
- **start:app**: Starts a development server for your app
- **compile**: Compile the smart contracts
- **build**: Builds the front-end and background script
- **build:app**: Builds the front-end
- **build:script**: Builds the background script
- **test**: Runs tests for the contracts
- **publish:minor**: Release a minor version to aragonPM
- **publish:major**: Release a major version to aragonPM with a potentially new contract address for on-chain upgrades

### Libraries

- [**@aragon/os**](https://github.com/aragon/aragonos): Aragon interfaces
- [**@aragon/client**](https://github.com/aragon/aragon.js/tree/master/packages/aragon-client): Wrapper for Aragon application RPC
- [**@aragon/ui**](https://github.com/aragon/aragon-ui): Aragon UI components (in React)

## Licensing

Note that the [Kit contract](contracts/Kit.sol) has a special requirement on licensing because it includes contract dependencies that are licensed as `GPL-3.0-or-later`. This is the only file in your project that is required to be licensed this way, and you are free to choose a different license for the rest of the project.
