pragma solidity ^0.5.8;

//ディーラーとプレイヤー
contract Environment {
    address public dealer;
    address public player;

    constructor(address _player)public{
        dealer = 0xc289e22143536dB9e0556d87E45dC17cF3f84aCD;
        player = msg.sender;
    }
}


contract Num {

    struct outsideBet {
        uint num;
        string type;
        uint dividend;
    }

    struct insideBet {
        string type;
        uint dividend;
    }

    struct Outside {
        outsideBet range;
        outsideBet color;
        outsideBet odd_even;
        outsideBet high_low;
        outsideBet column;
    }

    Outside[36] public outNums;
    insideBet[36] public inNums;

    function initOutside() public {
        for (uint num = 0; num <= 36; num++) {
            //inside
            inNums[num].dividend = 36;
            inNums[num].type = "Straight Up";

            //outside
            Outside memory number;
            /*range*/
            number.range.dividend = 3;
            if (num == 0) {
                number.range.type = "ZERO";
            } else if (num <= 12) {
                number.range.type = "SMALL";
            } else if (num <= 24) {
                number.range.type = "MEDIUM";
            } else if (num <= 36) {
                number.range.type = "LARGE";
            }
            /*color*/
            number.color.dividend = 2;
            if (num == 0) {
                number.color.type = "none";
            } else if (num / 10 == 0 || num / 10 == 2) {
                if (num % 2 == 1 && num != 29) {
                    number.color.type = "RED";
                } else {
                    number.color.type = "BLACK";
                }
            } else {
                if ((num % 2 == 0 && num != 10) || num == 19) {
                    number.color.type = "RED";
                } else {
                    number.color.type = "BLACK";
                }
            }
            /*odd_even*/
            number.odd_even.dividend = 2;
            if (num == 0) {
                number.odd_even.type = "none";
            } else if (num % 2 == 1) {
                number.odd_even.type = "ODD";
            } else {
                number.odd_even.type = "EVEN";
            }
            /*high_low*/
            number.high_low.dividend = 2;
            if (num == 0) {
                number.high_low.type = "none";
            } else if (num <= 18) {
                number.high_low.type = "LOW";
            } else {
                number.high_low.type = "HIGH";
            }
            /*column*/
            number.column.dividend = 3;
            if (num == 0) {
                number.column.type = "none";
            } else if (num % 3 == 0) {
                number.column.type = "pat1";
            } else if (num % 3 == 1) {
                number.column.type = "pat2";
            } else {
                number.column.type = "pat3";
            }
            outNums[num] = number;
        }
    }
}

//乱数生成
import "github.com/oraclize/ethereum-api/oraclizeAPI_0.5.sol";

contract RandomNumberOraclized is usingOraclize {
    uint public randomNumber;
    bytes32 public request_id;

    //function RandomNumberOraclized() public{
    // (1) Oraclize Address Resolver の読み込み
    // <OARアドレスを指定。deterministic OAR の場合、この行の指定は必要ない
    //OAR = OraclizeAddrResolverI(0x45831C2e2e081F7373003502D1D490e62b09A0dD);
    //}

    function request() public {
        // (2) OraclizeへWolframAlphaによる計算を依頼
        // デバッグのため、request_idにOraclizeへの処理依頼番号を保存しておきます
        request_id = oraclize_query("WolframAlpha", "random number between 0 and 36");
    }

    // (3) Oraclize側で外部処理が実行されると、この__callback関数を呼び出してくれる
    function __callback(bytes32 request_id, string memory result) public {
        if (msg.sender != oraclize_cbAddress()) {
            revert();
        }

        // (4) 実行結果resultをdrawnNumberへ保存
        randomNumber = parseInt(result);
    }
}


contract Play {

}

contract Transaction is Num {
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
        balanceOf[msg.sender] = _supply;
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
