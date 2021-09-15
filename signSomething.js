const EthCrypto = require("eth-crypto");
const signerIdentity = EthCrypto.createIdentity();
const message = EthCrypto.hash.keccak256(
[
  { type: "string", value: "Banana" }
]
);
const signature = EthCrypto.sign(signerIdentity.privateKey, message);
const publicKey = EthCrypto.publicKeyByPrivateKey(signerIdentity.privateKey);


console.log(`hashed message: ${message}`);
console.log(`signature: ${signature}`);
console.log(`signer's private_key: ${signerIdentity.privateKey}`);
console.log(`signer's public_key: ${publicKey}`);
console.log(`signer's wallet_address: ${signerIdentity.address}`);
