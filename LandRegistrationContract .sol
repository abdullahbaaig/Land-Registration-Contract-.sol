// SPDX-License-Identifier: GPL-3.0 g 

pragma solidity >=0.7 <0.9.0;

contract  landregistry{
    
struct Landreg 
{
    uint landid; 
    string Area;
    string City;
    string State;
    uint landPrice;
    uint  PropertyPID;
    address Owner;
}

struct Buyerdetail
{
    string Name; 
    uint Age;
    string City;
    uint CNIC;
    string Email;
}

struct Sellerdetail
{
    string Name; 
    uint Age;
    string City;
    uint CNIC;
    string Email;
}

struct LandInspectordetail
{ 
    address id;
    string Name;
    uint Age;
    string Designation;
}

//////////mapping///////

mapping(uint => Landreg) public land_details;
mapping(address => Buyerdetail) public Buyer_details;
mapping(address => Sellerdetail) public Seller_details;
mapping(uint => LandInspectordetail) public Inspector_details;
mapping(address => bool) public Verify_seller;
mapping(address => bool) public Verify_buyer;
mapping(uint => bool) public Verify_land;
mapping(address => bool) public Verify_landinspector;

////////////Landreg//////////

function Landdetails(uint landid, string memory Area, string memory City, string memory State, uint landPrice, uint PropertyPID, address) public
{
   land_details[landid]=Landreg(landid, Area, City, State, landPrice, PropertyPID, msg.sender);
} 

////////Buyer_details////////

function Buyerdetails(string memory Name, uint Age, string memory City, uint CNIC, string memory Email) public
{
    Buyer_details[msg.sender]=Buyerdetail(Name, Age, City, CNIC, Email);
}

//////////Seller_details////////

function sellerdetails(string memory Name, uint Age, string memory City, uint CNIC, string memory Email) public
{
    Seller_details[msg.sender]=Sellerdetail(Name, Age, City, CNIC, Email);
}

///////LandInspector_details/////

function LandInspectordetails(uint id, address Id, string memory Name, uint Age, string memory Designation) public
{
   Inspector_details[id]=LandInspectordetail(Id, Name, Age, Designation); 
}

///////verify_seller/////////

function verifyseller(address id) public
{
    Verify_seller [id] = true;
}

///////reject_seller/////////

function rejectseller(address id) public
{
    Verify_seller [id] = false;
}

//////verifyland////////

function verifyland(uint id) public
{
    Verify_land [id] =true;
}

function rejectland(uint id) public
{
    Verify_land [id] =false;
}

//////////updateseller//////

function updateseller(address id, string memory Name, uint Age, string memory City, uint CNIC, string memory Email) public
{
    Seller_details [id].Name= Name;
    Seller_details [id].Age= Age;
    Seller_details [id].City= City;
    Seller_details [id].CNIC= CNIC;
    Seller_details [id].Email= Email;
}

///////check_who_the_owner_of_this_land/////////// 

function ownercheck(uint landid) public view returns (address)
{
    return land_details [landid].Owner;
}

///////verify_buyer/////////

function verifybuyer(address id) public
{
    Verify_buyer [id] = true;
}

///////reject_buyer/////////

function rejectbuyer(address id) public
{
    Verify_buyer [id] = false;
}

///////verify_landinspector/////////

function verifylandinspector(address id) public
{
    Verify_landinspector [id] = true;
}

///////reject_landinspector/////////

function rejectlandinspector(address id) public
{
    Verify_landinspector [id] = false;
}

/////////updatebuyer//////

function updatebuyer(address id, string memory Name, uint Age, string memory City, uint CNIC, string memory Email) public
{
    Buyer_details [id].Name= Name;
    Buyer_details [id].Age= Age;
    Buyer_details [id].City= City;
    Buyer_details [id].CNIC= CNIC;
    Buyer_details [id].Email= Email;
}

//////We_can_check_who_is_the_curren_owner//////

function GetLandOwner(uint landid) public view returns(address)
    {
        return land_details[landid].Owner;
    } 

/////////Buyer_can_buy_the_land/////////

function BuyLand(uint landid) public payable
    {
        require(Verify_buyer[msg.sender] == true,"verify_buyer");
        require(Verify_land[landid] == true,"verify_land");
        payable(land_details[landid].Owner).transfer(msg.value);
        land_details[landid].Owner = msg.sender;
    }

///////Get_land_city///////

function GetLandCity(uint ID) public view returns (string memory)
    {
        return(land_details[ID].City);
    }

///////Get_land_price///////

function GetLandprice(uint ID) public view returns (uint)
    {
        return(land_details[ID].landPrice);
    }

///////Get_land_area//////

function GetLandArea(uint ID) public view returns (string memory)
    {
        return(land_details[ID].Area);
    }

/////////Transfer_Ownership/////////

function TransferOwnerShip(uint landiD, address newOwner) public
    {
        land_details[landiD].Owner = newOwner;
    }
}
