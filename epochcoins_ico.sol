pragma solidity >=0.4.22 <0.6.0;

contract olicoin_ico {

    uint public max_epochcoins = 1000000;
    uint public usd_to_epochcoins = 1000;
    uint public total_epochcoins_bought = 0;

    mapping(address => uint) equity_epochcoins;
    mapping(address => uint) equity_usd;

    modifier can_by_epochcoins(uint usd_invested) {
        require(usd_invested*usd_to_epochcoins + total_epochcoins_bought <= max_epochcoins);
        _;
    }

    function equity_in_epochcoins(address investor) external view returns(uint) {
        return equity_epochcoins[investor];
    }

    function equity_in_usd(address investor) external view returns(uint) {
        return equity_usd[investor];
    }

    function buy_epochcoins(address investor, uint usd_invested) external can_by_epochcoins(usd_invested) {
        uint epochcoins_bought = usd_invested*usd_to_epochcoins;
        equity_epochcoins[investor] += epochcoins_bought;
        equity_usd[investor] += usd_invested;
        total_epochcoins_bought += epochcoins_bought;

    }

    function sell_epochcoins(address investor, uint epochcoins_sold) external {
        equity_epochcoins[investor] -= epochcoins_sold;
        equity_usd[investor] -= (epochcoins_sold/usd_to_epochcoins);
        total_epochcoins_bought -= epochcoins_sold;

    }

}
