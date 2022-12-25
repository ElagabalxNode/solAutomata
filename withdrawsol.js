const { Client } = require('solana-web3.js');
const Binance = require('binance-api-node').default;
const { Ed25519Keypair } = require('@solana/web3.js');

// Replace with the actual address of your identity account
const identityAccount = 'YOUR_VALIDATOR_KEY';

// Replace with the path to your identity keypair file
const keypair = Ed25519Keypair.fromFile('/home/solana/.secrets/validator-keypair.json');

// Replace with your own Binance API key and secret
const binance = Binance({
apiKey: 'YOUR_API_KEY',
apiSecret: 'YOUR_API_SECRET',
});

async function main() {
    // Connect to a Solana node
    const client = new Client('https://mainnet.solana.com');

    // Get the balance of the identity account
    const balance = await client.getBalance(identityAccount);
    const balanceInSol = ((balance / 1000000) - 1.8);

    // Check if the balance is greater than 5 SOL
    if (balanceInSol > 2) {
    // Send the coins to Binance
    const response = await binance.deposit.crypto({
    asset: 'SOL',
    address: identityAccount,
    });

    // Check if the deposit was successful
    if (response.success) {
        // Construct a transaction to send the coins to Binance
        const transaction = client.newTransaction();
        transaction.add(
        client.transfer({
            to: response.address,
            amount: balanceInSol,
            fromPubkey: identityAccount,
        })
        );
    
        // Sign the transaction with the private key
        transaction.sign(keypair);
    
        // Submit the transaction to the network
        const result = await client.sendTransaction(transaction);
    
        // Check if the transaction was successful
        if (result.success) {
        console.log(`Coins sent to Binance: ${balance} SOL`);
    
        // Sell the coins on Binance for USDT
        const order = await binance.order({
            symbol: 'SOLUSDT',
            side: 'SELL',
            type: 'MARKET',
            quantity: balance,
        });
    
        console.log(`Order placed: ${order.symbol} ${order.side} ${order.type} ${order.quantity}`);
        } else {
            console.error(`Error depositing coins: ${response.msg}`);
        }
        } else {
        console.log(`Not enough balance to sell: ${balance} SOL`);
        }
    }
};

main();