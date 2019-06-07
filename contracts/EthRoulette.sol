pragma solidity ^0.5.8;

//ディーラーとプレイヤー
contract Environment {
    address public dealer;
    address public player;

    constructor(address _player)public{
        dealer = "0xc289e22143536dB9e0556d87E45dC17cF3f84aCD";
        player = msg.sender;
    }
}

//乱数生成
contract RandomNumber {
    uint public numberMax = 36;

    struct draw {
        uint blockNumber;
    }

    struct draws {
        uint numDraws;
        mapping(uint => draw) draws;
    }

    mapping(address => draws) requests;

    event ReturnNextIndex(uint _index);

    function request() public returns (uint) {
        uint _nextIndex = requests[msg.sender].numDraws;
        requests[msg.sender].draws[_nextIndex].blockNumber = block.number;
        requests[msg.sender].numDraws = _nextIndex + 1;
        ReturnNextIndex(_nextIndex);
        return _nextIndex;
    }

    // (1) デバッグ用に、blockhashとseed値を返すように変更
    function get(uint _index) public view returns (int status, uint drawnNumber){
        if (_index >= requests[msg.sender].numDraws) {
            return (- 2, 0);
        } else {
            uint _nextBlockNumber = requests[msg.sender].draws[_index].blockNumber + 1;
            if (_nextBlockNumber >= block.number) {
                return (- 1, 0);
            } else {
                bytes32 _blockhash = block.blockhash(_nextBlockNumber);
                // (2) ブロックハッシュ値、ユーザのアドレス、予約番号を元にseed値を計算
                bytes32 _seed = sha256(_blockhash, msg.sender, _index);
                // (3) seed値を元に乱数を計算 0~36
                uint _drawnNumber = uint(_seed) % (numberMax + 1);
                // (4) 計算された乱数を返す
                return (0, _drawnNumber);
            }
        }
    }
}


contract Transaction {
    /*状態変数の宣言*/
    string public name;         /*tokenの名前*/
    string public symbol;       /*tokenの単位*/
    uint8 public decimals;      /*小数点以下の桁数*/
    uint256 public totalSupply; /*tokenの総量*/
    mapping(address => uint256) public balanceOf; /*各アドレスの残高*/

    /*イベント通知*/
    event Transfer(address indexed from, address indexed to, uint256 value);

    /*コンストラクタ*/
    constructor(uint256 _supply, string memory _name, string memory _symbol, uint8 _decimals, bool _gameResult)public{
        balanceOf[player] = _supply;
        name = _name;
        symbol = _symbol;
        decimals = _decimals;
        totalSupply = _supply;
    }

    /*送金*/
    function transfer(address _from, address _to, uint256 _value) public {


        /*不正送金チェック*/
        if (balanceOf[msg.sender] < _value) revert();
        if (balanceOf[_to] + _value < balanceOf[_to]) revert();

        /*送金アドレスと受信アドレスの残高を更新*/
        balanceOf[msg.sender] -= _value;
        balanceOf[_to] += _value;

        /*イベント通知*/
        emit Transfer(msg.sender, _to, _value);
    }
}
