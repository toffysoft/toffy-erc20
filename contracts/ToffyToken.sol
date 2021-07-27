// SPDX-License-Identifier: MIT

pragma solidity >=0.6.6;

import "./ERC20.sol";
import "./Ownable.sol";
import "./SafeMath.sol";


contract ToffyToken is ERC20("Toffy Coin", "TOFFY"), Ownable {
    using SafeMath for uint256;
    uint256 public constant CAP = 10000000000e18; //10000M

    bool private minted = false;


    function mintTo(address _to, uint256 _amount) public onlyOwner {
        require(!minted, "supply has minted");
        require(totalSupply().add(_amount) <= CAP, "cap exceeded");
        _mint(_to, _amount);
        minted = true;
    }

    function mintMax() public onlyOwner {
        require(!minted, "supply has minted");
        _mint(_msgSender(), CAP);
        minted = true;
    }

    function mint(uint256 _amount) public onlyOwner {
        require(!minted, "supply has minted");
        require(totalSupply().add(_amount) <= CAP, "cap exceeded");
        _mint(_msgSender(), _amount);
        minted = true;
    }

    function transfer(address recipient, uint256 amount)
        public
        virtual
        override
        returns (bool)
    {
        _transfer(_msgSender(), recipient, amount);
        return true;
    }

    function transferFrom(
        address sender,
        address recipient,
        uint256 amount
    ) public virtual override returns (bool) {
        _transfer(sender, recipient, amount);
        _approve(
            sender,
            _msgSender(),
            allowance(sender, _msgSender()).sub(
                amount,
                "ERC20: transfer amount exceeds allowance"
            )
        );
        return true;
    }
}
