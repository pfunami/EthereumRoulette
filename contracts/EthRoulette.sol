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

contract Num {

    Num[36] public Nums;

    struct Num {
        string strNum;
        string color;
        string odd_even;
        string high_low;
    }

    function init(){
        for (int num = 0; num <= 36; num++) {
            Num memory number;
            number.strNum = string(num);
            /*range*/
            if (num == 0) {
                number.range = "ZERO";
            } else if (num <= 12) {
                number.range = "SMALL";
            } else if (num <= 24) {
                number.range = "MEDIUM";
            } else if (num <= 36) {
                number.range = "LARGE";
            }
            /*color*/
            if (num == 0) {
                number.color = "none";
            } else if (num / 10 = 0 || num / 10 = 2) {
                if (num % 2 == 1 && num != 29) {
                    number.color = "RED";
                } else {
                    number.color = "BLACK";
                }
            } else {
                if ((num % 2 == 0 && num != 10) || num == 19) {
                    number.color = "RED";
                } else {
                    number.color = "BLACK";
                }
            }
            /*odd_even*/
            if (num == 0) {
                number.odd_even = "none";
            } else if (num % 2 == 1) {
                number.odd_even = "ODD";
            } else {
                number.odd_even = "EVEN";
            }
            /*high_low*/
            if (num == 0) {
                number.high_low = "none";
            } else if (num <= 18) {
                number.high_low = "LOW";
            } else {
                number.high_low = "HIGH";
            }
            Nums[num] = number;
        }
    }
}

//乱数生成
import "github.com/oraclize/ethereum-api/oraclizeAPI_0.5.sol";

contract RandomNumberOraclized is usingOraclize {
    uint public randomNumber;
    bytes32 public request_id;

    function RandomNumberOraclized() {
        // (1) Oraclize Address Resolver の読み込み
        // <OARアドレスを指定。deterministic OAR の場合、この行の指定は必要ない
        // OAR = OraclizeAddrResolverI(0x45831C2e2e081F7373003502D1D490e62b09A0dD);
    }

    function request() {
        // (2) OraclizeへWolframAlphaによる計算を依頼
        // デバッグのため、request_idにOraclizeへの処理依頼番号を保存しておきます
        request_id = oraclize_query("WolframAlpha", "random number between 0 and 36");
    }

    // (3) Oraclize側で外部処理が実行されると、この__callback関数を呼び出してくれる
    function __callback(bytes32 request_id, string result) {
        if (msg.sender != oraclize_cbAddress()) {
            throw;
        }

        // (4) 実行結果resultをdrawnNumberへ保存
        randomNumber = parseInt(result);
    }
}


contract Play {

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
