pragma solidity ^0.4.4; 

contract Documents {

	struct Document {		
		 
		address owner; 		//? подумать как лучше хранить адрес владельца
		string document;
		// educationType; 		// Тип образования
		// institution; 		// Учебное заведение
		// specialty; 			// Специальность
		// qualification; 		// квалификация
		// dateOfAdmission; 	// Год поступления
		// dateOfGraduation; 	// Год окончания
		// dateOfIssuance; 		// Дата выдачи
		// number;				// Номер
		string FIO;			//ФИО
		


	}
	mapping (uint => Document) public documents;
	mapping (uint => address) public owners; //номер паспорта к адресу
	uint lastDocid;

	function Documents() public {
		lastDocid = 0;
	}

	//Transactions
	function addDocument(string data, string fio) public returns (uint) {
		
		documents[lastDocid] = Document(msg.sender, data, fio); //передавать адрес владельца, а не отправителя	
		lastDocid++;	
		return lastDocid;

	}

	//Functions
	function getDocById(uint id) public constant returns 
		(uint, 		//id в мапке
		address, //владелец
		string, //содержимое
		string) //фио
	{
		return (id, documents[id].owner, documents[id].document, documents[id].FIO);
	}

	function getDocumentsNumber() public constant returns (uint) {
		return lastDocid;
	}

	function getThisAddresDocNumber() constant public returns (uint) {		
		uint result = 0;
		for (uint i = 0; i < lastDocid; i++ ){
			if(documents[i].owner == msg.sender) {
				result++;
			}
		}
		return result;
	}

	function getThisAddresDocById(uint id) constant public returns (uint, 		//id в мапке
		address, //владелец
		string, //содержимое
		string) //фио
	{		
		uint j = 0;
		for (uint i = 0; i < lastDocid; i++ ){
			if(documents[i].owner == msg.sender) {
				if (j == id) return (i, documents[i].owner, documents[i].document, documents[i].FIO);
				else j++;	
			}
		}
		return (0,0x00,"","");
	}

}