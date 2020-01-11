pragma solidity ^0.5.0;

contract ClassContractWithEvent{
    event studentDetails(string,bool,gender,addmissionType);
    uint private counter = 0;
    address payable private myAddress;
        enum gender{
            male,
            female
        }
        enum addmissionType{
            onsite,
            online
        }
    struct Student{
        string name;
        bool haveBSDegree;
        gender studentGender;
        addmissionType studentAddmissionType;
    }
    
    constructor() public {
        myAddress = msg.sender;
    }
    
    mapping(uint => Student) addressToStudents;
    
    modifier isActualfee(uint value){
        if(value >= 2000000000000000000){
            _;
        }
    }
    
    function getAddmission(string memory name, bool haveBSDegree, gender yourGender, addmissionType OnlineOrOnsite) isActualfee(msg.value) public payable {
       Student memory _studentStruct = Student(name, haveBSDegree, yourGender, OnlineOrOnsite);
       addressToStudents[counter++] = _studentStruct;
       myAddress.transfer(msg.value);
       
    }
    modifier isOwner(address Address){
        if(Address == myAddress){
            _;
        }
    }
    
    function getTotalAmount() public view isOwner(msg.sender) returns(uint) {
        return myAddress.balance;
    }
    function getCounterValue() public view returns(uint){
        return counter;
    }
    function getAlltheEnrolledstudents() public{
        
        for(uint localCounter = 0; localCounter <= counter - 1; localCounter++ ){
            Student memory structStudent = addressToStudents[localCounter];
            emit studentDetails(structStudent.name,structStudent.haveBSDegree,structStudent.studentGender,structStudent.studentAddmissionType);
            
        }
    }
    
}