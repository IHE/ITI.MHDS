Instance: IHE.MHDS.DocumentRegistry
InstanceOf: CapabilityStatement
Title: "MHDS Document Registry"
Description: """
CapabilityStatement Requirements for the MHDS Document Registry Actor

- **[MHD](https://profiles.ihe.net/ITI/MHD/index.html) - [Document Recipient](https://profiles.ihe.net/ITI/MHD/1331_actors_and_transactions.html#133113-document-recipient)** supports publication requests by the [MHD Document Source](https://profiles.ihe.net/ITI/MHD/1331_actors_and_transactions.html#133111-document-source). The Comprehensive Metadata Option is required.
- **[MHD](https://profiles.ihe.net/ITI/MHD/index.html) - [Document Responder](https://profiles.ihe.net/ITI/MHD/1331_actors_and_transactions.html#133114-document-responder)** supports the discovery and retrieval of documents by [MHD](https://profiles.ihe.net/ITI/MHD/index.html) [Document Consumer](https://profiles.ihe.net/ITI/MHD/1331_actors_and_transactions.html#133112-document-consumer).
- **[PMIR](https://profiles.ihe.net/ITI/TF/Volume1/ch-49.html) - Patient Identity Consumer** provides patient identity synchronization and specifically the merge function to be applied to any data managed in the Document Registry.
- **[SVCM](https://profiles.ihe.net/ITI/TF/Volume1/ch-51.html) – Terminology Consumer** enables the Document Registry to gain access to ValueSets that the Registry is enforcing Metadata consistency.
- **[mCSD](https://profiles.ihe.net/ITI/mCSD/index.html) – Care Services Selective Consumer** enables the Registry to have access to Organization and Practitioner resources.
- **[IUA](https://profiles.ihe.net/ITI/IUA/index.html) – Authorization Server** and **Resource Server** enforces access control decisions.
- **[ATNA](https://profiles.ihe.net/ITI/TF/Volume1/ch-9.html) - [Secure Node](https://profiles.ihe.net/ITI/TF/Volume1/ch-9.html#9.1.1.1)** enable the Document Registry to be secure, record audit records, and support secure transactions.
- **[CT](https://profiles.ihe.net/ITI/TF/Volume1/ch-7.html) - Time Client** assures that all records of time done by the Document Registry are aligned with the Time Source.
"""
Usage: #definition
* url = "http://profiles.ihe.net/ITI/MHDS/CapabilityStatement/IHE.MHDS.DocumentRegistry"
* name = "IHE_MHDS_DocumentRegistry"
* title = "MHDS Document Registry"
* description =  "MHD Document Registry Actor definition"
* status = #active
* experimental = false
* date = "2021-12-16"
* kind = #requirements
* fhirVersion = #4.0.1
* format[0] = #application/fhir+xml
* format[+] = #application/fhir+json
* imports[+] = "http://profiles.ihe.net/ITI/MHD/CapabilityStatement/IHE.MHD.DocumentRecipient"
* imports[+] = "http://profiles.ihe.net/ITI/MHD/CapabilityStatement/IHE.MHD.DocumentResponder"
* imports[+] = "http://ihe.net/fhir/CapabilityStatement/capabilitystatement-IHE.PDQm.server"
* rest.mode = #server
* rest.documentation = """
CapabilityStatement Requirements for the MHDS Document Registry Actor

- **[MHD](https://profiles.ihe.net/ITI/MHD/index.html) - [Document Recipient](https://profiles.ihe.net/ITI/MHD/1331_actors_and_transactions.html#133113-document-recipient)** supports publication requests by the [MHD Document Source](https://profiles.ihe.net/ITI/MHD/1331_actors_and_transactions.html#133111-document-source). The Comprehensive Metadata Option is required.
- **[MHD](https://profiles.ihe.net/ITI/MHD/index.html) - [Document Responder](https://profiles.ihe.net/ITI/MHD/1331_actors_and_transactions.html#133114-document-responder)** supports the discovery and retrieval of documents by [MHD](https://profiles.ihe.net/ITI/MHD/index.html) [Document Consumer](https://profiles.ihe.net/ITI/MHD/1331_actors_and_transactions.html#133112-document-consumer).
- **[PMIR](https://profiles.ihe.net/ITI/TF/Volume1/ch-49.html) - Patient Identity Consumer** provides patient identity synchronization and specifically the merge function to be applied to any data managed in the Document Registry.
- **[SVCM](https://profiles.ihe.net/ITI/TF/Volume1/ch-51.html) – Terminology Consumer** enables the Document Registry to gain access to ValueSets that the Registry is enforcing Metadata consistency.
- **[mCSD](https://profiles.ihe.net/ITI/mCSD/index.html) – Care Services Selective Consumer** enables the Registry to have access to Organization and Practitioner resources.
- **[IUA](https://profiles.ihe.net/ITI/IUA/index.html) – Authorization Server** and **Resource Server** enforces access control decisions.
- **[ATNA](https://profiles.ihe.net/ITI/TF/Volume1/ch-9.html) - [Secure Node](https://profiles.ihe.net/ITI/TF/Volume1/ch-9.html#9.1.1.1)** enable the Document Registry to be secure, record audit records, and support secure transactions.
- **[CT](https://profiles.ihe.net/ITI/TF/Volume1/ch-7.html) - Time Client** assures that all records of time done by the Document Registry are aligned with the Time Source.
"""
