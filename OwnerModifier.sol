contract Contract {
    uint public a;
    uint public b;
    uint public c; // <-- Add this

    address public owner;

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Not the owner!");
        _;
    }

    function setA(uint _a) public onlyOwner {
        a = _a;
    }

    function setB(uint _b) public onlyOwner {
        b = _b;
    }

    function setC(uint _c) public onlyOwner {
        c = _c;
    }
}
