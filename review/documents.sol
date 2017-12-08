// REMARK: давай хоть 0.4.15
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

	// REMARK: непонятно что такое UINT - id пользователя?
	// почему не используем массивы? public Document[] documents?
	mapping (uint => Document) public documents;

	// REMARK: непонятно UINT - номер паспорта? мб string?
	mapping (uint => address) public owners; //номер паспорта к адресу

	// REMARK: пожалуйста придерживайся одного стиля наименования перменных
	// lastDocumentId
	uint lastDocid;

	function Documents() public {
		lastDocid = 0;
	}

	// Transactions

	// REMARK: транзакции ничего не возвращаются
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

	// REMARK: ??? что это? люблю тебя
	function getThisAddresDocNumber() constant public returns (uint) {		
		uint result = 0;
		for (uint i = 0; i < lastDocid; i++ ){
			if(documents[i].owner == msg.sender) {
				result++;
			}
		}

		// Artem's way
		for (uint i = 0; documents.size; i++) { 
			if (documents[i].owner == msg.sender) 
				return i;
		}

		return 0;
	}

	function getThisAddresDocById(uint id) constant public returns 
		(uint, 		//id в мапке
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