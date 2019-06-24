// 0x692a70d2e424a56d2c6c27aa97d1a86395877b3a

if (typeof web3 !== 'undefined') {
    web3 = new Web3(web3.currentProvider);
    ethereum.enable();
    web3.version.getNetwork((error, result) => {
        console.log('Network ID: ' + result)
    });
    var account;
    web3.eth.getAccounts((error, result) => {
        account = result[0];
        console.log('Your accounts: ' + account);
    });

    let addr = "0x9dd1e8169e76a9226b07ab9f85cc20a5e1ed44dd";
    let abi = [
        {
            "constant": false,
            "inputs": [
                {
                    "name": "place",
                    "type": "string"
                },
                {
                    "name": "number",
                    "type": "uint256"
                },
                {
                    "name": "betVal",
                    "type": "uint256"
                }
            ],
            "name": "betOut",
            "outputs": [],
            "payable": false,
            "stateMutability": "nonpayable",
            "type": "function"
        },
        {
            "constant": false,
            "inputs": [
                {
                    "name": "_val",
                    "type": "uint256"
                }
            ],
            "name": "buyChip",
            "outputs": [],
            "payable": false,
            "stateMutability": "nonpayable",
            "type": "function"
        },
        {
            "constant": false,
            "inputs": [
                {
                    "name": "_exChip",
                    "type": "uint256"
                }
            ],
            "name": "exchangeChip",
            "outputs": [],
            "payable": false,
            "stateMutability": "nonpayable",
            "type": "function"
        },
        {
            "constant": false,
            "inputs": [
                {
                    "name": "num",
                    "type": "uint256"
                }
            ],
            "name": "init",
            "outputs": [],
            "payable": false,
            "stateMutability": "nonpayable",
            "type": "function"
        },
        {
            "constant": false,
            "inputs": [
                {
                    "name": "_ranNum",
                    "type": "uint256"
                }
            ],
            "name": "payOut",
            "outputs": [],
            "payable": false,
            "stateMutability": "nonpayable",
            "type": "function"
        },
        {
            "constant": false,
            "inputs": [
                {
                    "name": "_from",
                    "type": "address"
                },
                {
                    "name": "_to",
                    "type": "address"
                },
                {
                    "name": "_value",
                    "type": "uint256"
                }
            ],
            "name": "transfer",
            "outputs": [
                {
                    "name": "",
                    "type": "bool"
                }
            ],
            "payable": false,
            "stateMutability": "nonpayable",
            "type": "function"
        },
        {
            "inputs": [
                {
                    "name": "_supply",
                    "type": "uint256"
                },
                {
                    "name": "_name",
                    "type": "string"
                },
                {
                    "name": "_symbol",
                    "type": "string"
                },
                {
                    "name": "_decimals",
                    "type": "uint256"
                },
                {
                    "name": "_dealer",
                    "type": "address"
                }
            ],
            "payable": false,
            "stateMutability": "nonpayable",
            "type": "constructor"
        },
        {
            "anonymous": false,
            "inputs": [
                {
                    "indexed": true,
                    "name": "from",
                    "type": "address"
                },
                {
                    "indexed": true,
                    "name": "to",
                    "type": "address"
                },
                {
                    "indexed": false,
                    "name": "value",
                    "type": "uint256"
                }
            ],
            "name": "Transfer",
            "type": "event"
        },
        {
            "anonymous": false,
            "inputs": [
                {
                    "indexed": false,
                    "name": "getChip",
                    "type": "uint256"
                },
                {
                    "indexed": false,
                    "name": "allChip",
                    "type": "uint256"
                },
                {
                    "indexed": false,
                    "name": "value",
                    "type": "uint256"
                }
            ],
            "name": "GetChip",
            "type": "event"
        },
        {
            "anonymous": false,
            "inputs": [
                {
                    "indexed": false,
                    "name": "exchangeChip",
                    "type": "uint256"
                },
                {
                    "indexed": false,
                    "name": "allChip",
                    "type": "uint256"
                },
                {
                    "indexed": false,
                    "name": "value",
                    "type": "uint256"
                }
            ],
            "name": "ExchangeChip",
            "type": "event"
        },
        {
            "constant": true,
            "inputs": [
                {
                    "name": "",
                    "type": "address"
                }
            ],
            "name": "balanceOf",
            "outputs": [
                {
                    "name": "",
                    "type": "uint256"
                }
            ],
            "payable": false,
            "stateMutability": "view",
            "type": "function"
        },
        {
            "constant": true,
            "inputs": [],
            "name": "chip",
            "outputs": [
                {
                    "name": "",
                    "type": "uint256"
                }
            ],
            "payable": false,
            "stateMutability": "view",
            "type": "function"
        },
        {
            "constant": true,
            "inputs": [],
            "name": "dealer",
            "outputs": [
                {
                    "name": "",
                    "type": "address"
                }
            ],
            "payable": false,
            "stateMutability": "view",
            "type": "function"
        },
        {
            "constant": true,
            "inputs": [],
            "name": "decimals",
            "outputs": [
                {
                    "name": "",
                    "type": "uint256"
                }
            ],
            "payable": false,
            "stateMutability": "view",
            "type": "function"
        },
        {
            "constant": true,
            "inputs": [],
            "name": "inNums",
            "outputs": [
                {
                    "name": "kind",
                    "type": "string"
                },
                {
                    "name": "dividend",
                    "type": "uint256"
                }
            ],
            "payable": false,
            "stateMutability": "view",
            "type": "function"
        },
        {
            "constant": true,
            "inputs": [
                {
                    "name": "_origin",
                    "type": "string"
                },
                {
                    "name": "_target",
                    "type": "string"
                }
            ],
            "name": "isSameString",
            "outputs": [
                {
                    "name": "",
                    "type": "bool"
                }
            ],
            "payable": false,
            "stateMutability": "pure",
            "type": "function"
        },
        {
            "constant": true,
            "inputs": [],
            "name": "name",
            "outputs": [
                {
                    "name": "",
                    "type": "string"
                }
            ],
            "payable": false,
            "stateMutability": "view",
            "type": "function"
        },
        {
            "constant": true,
            "inputs": [],
            "name": "outNums",
            "outputs": [
                {
                    "components": [
                        {
                            "name": "num",
                            "type": "uint256"
                        },
                        {
                            "name": "kind",
                            "type": "string"
                        },
                        {
                            "name": "dividend",
                            "type": "uint256"
                        }
                    ],
                    "name": "range",
                    "type": "tuple"
                },
                {
                    "components": [
                        {
                            "name": "num",
                            "type": "uint256"
                        },
                        {
                            "name": "kind",
                            "type": "string"
                        },
                        {
                            "name": "dividend",
                            "type": "uint256"
                        }
                    ],
                    "name": "color",
                    "type": "tuple"
                },
                {
                    "components": [
                        {
                            "name": "num",
                            "type": "uint256"
                        },
                        {
                            "name": "kind",
                            "type": "string"
                        },
                        {
                            "name": "dividend",
                            "type": "uint256"
                        }
                    ],
                    "name": "odd_even",
                    "type": "tuple"
                },
                {
                    "components": [
                        {
                            "name": "num",
                            "type": "uint256"
                        },
                        {
                            "name": "kind",
                            "type": "string"
                        },
                        {
                            "name": "dividend",
                            "type": "uint256"
                        }
                    ],
                    "name": "high_low",
                    "type": "tuple"
                },
                {
                    "components": [
                        {
                            "name": "num",
                            "type": "uint256"
                        },
                        {
                            "name": "kind",
                            "type": "string"
                        },
                        {
                            "name": "dividend",
                            "type": "uint256"
                        }
                    ],
                    "name": "column",
                    "type": "tuple"
                }
            ],
            "payable": false,
            "stateMutability": "view",
            "type": "function"
        },
        {
            "constant": true,
            "inputs": [],
            "name": "player",
            "outputs": [
                {
                    "name": "",
                    "type": "address"
                }
            ],
            "payable": false,
            "stateMutability": "view",
            "type": "function"
        },
        {
            "constant": true,
            "inputs": [],
            "name": "symbol",
            "outputs": [
                {
                    "name": "",
                    "type": "string"
                }
            ],
            "payable": false,
            "stateMutability": "view",
            "type": "function"
        },
        {
            "constant": true,
            "inputs": [],
            "name": "totalSupply",
            "outputs": [
                {
                    "name": "",
                    "type": "uint256"
                }
            ],
            "payable": false,
            "stateMutability": "view",
            "type": "function"
        }
    ];

    let contract = web3.eth.contract(abi).at(addr);

    $('#spin').on('click', function () {
        let random = Math.floor(Math.random() * 37);    //0~36
        contract.payOut.sendTransaction(random, {
            from: "0x937be33cc76117b967d33966099c81b2d1a9a383",
            gas: 3000000
        }, (error, result) => {
            console.log('Transaction Hash : ' + result);
        });

        $('#output').text(random.toString());

    });


    // $('#getValue1Button').on('click', function () {
    //     contract.getValue1.call($('#getValue1Text').val(), (error, result) => {
    //         $('#call_value1').text('Value1 : ' + result)
    //     });
    // });
    //
    // $('#getValue2Button').on('click', function () {
    //     contract.getValue2.call($('#getValue2Text').val(), (error, result) => {
    //         $('#call_value2').text('Value2 : ' + result)
    //     });
    // });


    // $('#spin').on('click', function () {
    //
    //     contract.setValue.sendTransaction($('#setValueText1').val(), $('#setValueText2').val(), {
    //         from: "0x937be33cc76117b967d33966099c81b2d1a9a383",
    //         gas: 3000000
    //     }, (error, result) => {
    //         $('#tx_hsh').text('Transaction Hash : ' + result);
    //     });
    // });
    //
    // $('#getValue1Button').on('click', function () {
    //     contract.getValue1.call($('#getValue1Text').val(), (error, result) => {
    //         $('#call_value1').text('Value1 : ' + result)
    //     });
    // });
    //
    // $('#getValue2Button').on('click', function () {
    //     contract.getValue2.call($('#getValue2Text').val(), (error, result) => {
    //         $('#call_value2').text('Value2 : ' + result)
    //     });
    // });

} else {
    document.write('Install <a href="https://metamask.io">METAMASK</a>')
}