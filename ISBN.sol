pragma solidity ^0.4.25;

contract Owned {
    address owner;
    
    constructor() public {
        owner = msg.sender;
    }
    
   modifier onlyOwner {
       require(msg.sender == owner);
       _;
   }
}

contract Books is Owned {
    
    struct ISBN {
        string country;
        string language;
        string title;
        string publisher;
        string author;
    }
    
    mapping (address => ISBN) isbns;
    address[] public isbnAccts;
    
    event isbnInfo(
        string country,
        string language,
        string title,
        string publisher,
        string author
    );
    
    function setISBN(address _address, string _country, string _language, string _title, string _publisher, string _author) onlyOwner public {
        ISBN storage isbn = isbns[_address];
        
        isbn.country = _country;
        isbn.language = _language;
        isbn.title = _title;
        isbn.publisher = _publisher;
        isbn.author = _author;
        
        isbnAccts.push(_address) -1;
        emit isbnInfo(_country, _language, _title, _publisher, _author);
    }
    
    function getISBNs() view public returns(address[]) {
        return isbnAccts;
    }
    
    function getISBN(address _address) view public returns (string, string, string, string, string) {
        return (isbns[_address].country, isbns[_address].language, isbns[_address].title, isbns[_address].publisher, isbns[_address].author);
    }
    
}
