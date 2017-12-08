pragma solidity ^0.4.11;

import "truffle/Assert.sol";
import "truffle/DeployedAddresses.sol";
import "../contracts/Documents.sol";

contract TestDocuments {
  	Documents documents = Documents(DeployedAddresses.Documents());


	function testAddDocument() {
    documents.addDocument("data","FIO");
    uint returnedId = documents.getDocumentsNumber();
    Assert.equal(returnedId, 1, "Document with ID = 1 shoul be added.");
	}
  function testGetDocById() {
    var (id, owner, data, fio) = documents.getDocById(0);
    Assert.equal(id, 0, "Id is expected to be 1.");
    Assert.equal(owner, this, "Owner is expected to be this test contract.");
  }

  function testGetThisAddresDocNumber() {
    documents.addDocument("data","FIO");
    documents.addDocument("data","FIO");
    documents.addDocument("data","FIO");
    uint res = documents.getThisAddresDocNumber();
    Assert.equal(res, 4, "I added 4 documents.");
  }
}
