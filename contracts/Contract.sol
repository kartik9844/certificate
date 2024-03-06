// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract CertificateContract {
    // Struct to represent a certificate
    struct Certificate {
        uint256 certificateId;
        string fullName;
        string courseCompleted;
        string studyCenter;
        uint256 fromDate;  // Date
        uint256 toDate;    // Date
        string obtainedGrade;
    }

    mapping(uint256 => Certificate) public certificates;  // Mapping from certificateId to Certificate
    mapping(bytes32 => uint256) public hashToCertificateId;  // Mapping from hash to certificateId
    uint256[] public certificateIdsArray;  // Array to store certificate IDs

    // Function to create a new certificate
    function createCertificate(
        uint256 _certificateId,
        string memory _fullName,
        string memory _courseCompleted,
        string memory _studyCenter,
        uint256 _fromDate,
        uint256 _toDate,
        string memory _obtainedGrade
    ) external {
        Certificate memory newCertificate = Certificate({
            certificateId: _certificateId,
            fullName: _fullName,
            courseCompleted: _courseCompleted,
            studyCenter: _studyCenter,
            fromDate: _fromDate,
            toDate: _toDate,
            obtainedGrade: _obtainedGrade
        });

        certificates[_certificateId] = newCertificate;
        certificateIdsArray.push(_certificateId);
        
        // Generate hash using keccak256 for the certificate details
        bytes32 hash = keccak256(abi.encodePacked(_fullName, _courseCompleted, _studyCenter, _fromDate, _toDate, _obtainedGrade));
        
        // Map the hash to the certificateId
        hashToCertificateId[hash] = _certificateId;
    }

    // Function to list all certificates with certificateId, full name, and hash
    function listCertificates() external view returns (uint256[] memory, string[] memory, bytes32[] memory) {
        uint256[] memory certificateIds = new uint256[](certificateIdsArray.length);
        string[] memory fullNames = new string[](certificateIdsArray.length);
        bytes32[] memory hashes = new bytes32[](certificateIdsArray.length);

        for (uint256 i = 0; i < certificateIdsArray.length; i++) {
            uint256 certificateId = certificateIdsArray[i];
            certificateIds[i] = certificates[certificateId].certificateId;
            fullNames[i] = certificates[certificateId].fullName;
            // Generate hash using keccak256 for the certificate details
            hashes[i] = keccak256(abi.encodePacked(certificates[certificateId].fullName, certificates[certificateId].courseCompleted, certificates[certificateId].studyCenter, certificates[certificateId].fromDate, certificates[certificateId].toDate, certificates[certificateId].obtainedGrade));
        }

        return (certificateIds, fullNames, hashes);
    }

    // Function to get certificate information using hash
    function getCertificateByHash(bytes32 _hash) external view returns (uint256, string memory, string memory, string memory, uint256, uint256, string memory) {
        uint256 certificateId = hashToCertificateId[_hash];
        return (
            certificates[certificateId].certificateId,
            certificates[certificateId].fullName,
            certificates[certificateId].courseCompleted,
            certificates[certificateId].studyCenter,
            certificates[certificateId].fromDate,
            certificates[certificateId].toDate,
            certificates[certificateId].obtainedGrade
        );
    }

    // Function to get certificate information using certificateId
    function getCertificateById(uint256 _certificateId) external view returns (uint256, string memory, string memory, string memory, uint256, uint256, string memory) {
        return (
            certificates[_certificateId].certificateId,
            certificates[_certificateId].fullName,
            certificates[_certificateId].courseCompleted,
            certificates[_certificateId].studyCenter,
            certificates[_certificateId].fromDate,
            certificates[_certificateId].toDate,
            certificates[_certificateId].obtainedGrade
        );
    }

    // Function to get the total count of certificates generated
    function getCertificateCount() external view returns (uint256) {
        return certificateIdsArray.length;
    }
}
