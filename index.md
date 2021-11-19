**TODO**

**DONE**
- simplify front materials
- simplify table of content
- removed the General Intro section, as that Actor is already in appendix A
- fixup markdown to be more simple than got from export
- change references from pointers at old PDF technical framework to the new profiles.ihe.net site
- removed section 50.7 in favor of the more updated HIE-Whitepaper
- multiple markdown tables likely need to be converted to html as they really need merged cells (e.g. actors with multiple options) ( note one can get the right tables with pandoc and markdown_strict)
- bold figure / table titles
- code block `style`
- UML is websequence format, should be plantuml (e.g. -->+ )
- links to IGs (MHD, PIXm, PDQm, FormatCode)
- links to html (IUA, mCSD, metadataHandbook, TF)
- internal section linking
- align to new MHD that does not use DocumentManifest 

**********************************************************************************************************

**Integrating the Healthcare Enterprise**

**[IHE IT Infrastructure](https://profiles.ihe.net/ITI)** **Supplement**

**Mobile Health Document Sharing (MHDS)**

**Revision 2.2 - Public Comment**

Date: December 31, 2021

Author: ITI Technical Committee

Email: [iti@ihe.net](mailto:iti@ihe.net)

**Please verify you have the most recent version of this Supplement. See [here](http://profiles.ihe.net/ITI) for the Published version.

# Foreword

This is a supplement to the [IHE](http://www.ihe.net) [IT Infrastructure Technical Framework](https://profiles.ihe.net/ITI/TF/index.html).
Each supplement undergoes a process of public comment and trial
implementation before being incorporated into the volumes of the
Technical Frameworks.


**CONTENTS**

* [1:50 Mobile Health Document Sharing (MHDS) Profile](#150-mobile-health-document-sharing-mhds-profile)
* [1:50.1 MHDS Actors, Transactions, and Content Modules](#1501-mhds-actors-transactions-and-content-modules)
* [1:50.2 MHDS Actor Options](#1502-mhds-actor-options)
* [1:50.3 MHDS Required Actor Groupings](#1503-mhds-required-actor-groupings)
* [1:50.4 MHDS Overview](#1504-mhds-overview)
* [1:50.5 MHDS Security Considerations](#1505-mhds-security-considerations)
* [1:50.6 MHDS Cross Profile Considerations](#1506-mhds-cross-profile-considerations)


# Introduction to this Supplement

This profile will show how to build a Document Sharing Exchange using
IHE-profiled FHIR<sup>®</sup> standard, rather than the legacy IHE
profiles that are dominated by XDS and HL7<sup>®</sup> v2. This profile
will assemble profiles and define a [Document Registry](#150111-document-registry).

The central HIE infrastructure defined in this Profile might be a single
FHIR Server implementing all the defined central service actors or may
be virtual cloud of the systems implementing the defined profile actors.
These deployment models allow for modularity where each service function
could be provided by different vendors, leveraging as much as possible
from a reference implementation of a FHIR Server, and also leverage as
much as possible of modularity enabled by defined Profiles.

Core business functions provided by MHDS Profile:

- Publication of Document based information
  - Content agnostic but CDA<sup>®</sup> and FHIR preferred
- Persistence and lifecycle management of Documents, DocumentReference, and List resources
  - Enabling centralized document storage, or distributed document storage at a service identified at the source
- Patient Identity Management –
  - specifically, a golden patient identity for use within the domain, cross-reference to other identities, and lifecycle of updates
  - Appropriate comprehensive handling of patient identity updates including merge
- Participant Organizations management
  - Enabling use of mCSD directory for author identity management
- Authorization management
  - Consent
  - User Role-Based-Access-Control (RBAC) or
    Attribute-Based-Access-Control (ABAC)
  - Application
  - PurposeOfUse
- Encryption and Integrity requirements
- Audit Log Management
- Consumption side can be further refined using [mXDE](https://profiles.ihe.net/ITI/TF/Volume1/ch-45.html) and [QEDm](https://www.ihe.net/uploadedFiles/Documents/PCC/IHE_PCC_Suppl_QEDm.pdf)

## Open Issues and Questions

no open issues

## Closed Issues

1.  This profile was renamed from MHD-HIE to Mobile Health Document
    Sharing (MHDS). This name leverages the concept of “Document
    Sharing” as defined in the HIE whitepaper and includes the
    original MHD acronym while removing the word “access” which is
    important in MHD to define it as an API and inserting the word
    “Sharing” which indicates persistence.

2.  There is no action defined for the Document Registry when the PMIR
    feed transaction indicated a Delete action on a Patient that the
    Document Registry has records for. The concern is that this action
    is not clear outside of a policy. It is reasonable that policy may
    choose to ignore Delete, may choose to mark the affected Resources
    inactive, or may choose to delete the affected Resources. Thus, we
    have left this action undefined. It is expected that a Delete action
    is unusual, and that administrative user interface may be the better
    solution.

3.  Where XDS/XCA is used the MHDS Profile does not apply, as the MHD
    Profile provides the API functionality to XDS/XCA

4.  MHDS defines an OAuth scope for use with MHDS and IUA to support
    Patient Privacy Disclosure Consent functionality. This scope is
    crafted to be minimally impacting on uses of IUA and SMART-on-FHIR.
    See the “Consent Management Option” for details.

5.  In this profile, there is no formal Document Repository, although
    the functionality is provided virtually when a Document Source
    chooses to not include the document as a Binary resource, but rather
    include a URL to a repository that is recognized as part of the
    trust domain. This distinction is available in MHD today, although
    it is not pointed out as such and thus not well known. There is
    description of this virtual Document Repository functionality.

6.  The MHDS environment allows for some normally contained Resources be
    recorded as a link to data in the mCSD managed Directory or PMIR
    Patient Identity Manager. This is defined in the “UnContained
    Reference Option”. The necessary change to MHD has not been done yet
    in order to get feedback from Public Comment. CP-ITI-1200 has
    updated. MHD to add an UnContained Reference Option for this support

7.  Removed section 50.7 as the current HIE-Whitepaper contains MHD now.

# 1:50 Mobile Health Document Sharing (MHDS) Profile

The MHDS Profile specifies how a collection of IHE profiles can be used
by communities for exchanging health information. These IHE profiles
include support for patient identification, health document location and
retrieval, provider directories, and the protection of privacy and
security. MHDS shows how several IHE profiles work together to provide a
standards-based, interoperable approach to community health information
sharing.

The IHE IT Infrastructure Domain has published several resources to
support document sharing:

- [ITI Technical Framework](https://profiles.ihe.net/ITI/TF): [Vol. 3 - Section 4.0 Metadata used in Document Sharing](https://profiles.ihe.net/ITI/TF/Volume3/index.html#4)
- [Health Information Exchange: Enabling Document Sharing Using IHE Profiles](https://profiles.ihe.net/ITI/HIE-Whitepaper/index.html)
- [Document Sharing Metadata Handbook](https://www.ihe.net/uploadedFiles/Documents/ITI/IHE_ITI_Handbook_Metadata.pdf)
- [Template for XDS Affinity Domain Deployment Planning](https://www.ihe.net/Technical_Framework/upload/IHE_ITI_White_Paper_XDS_Affinity_Domain_Template_TI_2008-12-02.pdf)

This MHDS Profile defines a Document Sharing Exchange that is based
around the HL7 FHIR standard, following the principles described in the
[Health Information Exchange: Enabling Document Sharing Using IHE
Profiles](https://profiles.ihe.net/ITI/HIE-Whitepaper/index.html) 
whitepaper. This Document Sharing exchange requires the same management
of metadata as described in the [Document Sharing Metadata
Handbook](https://www.ihe.net/uploadedFiles/Documents/ITI/IHE_ITI_Handbook_Metadata.pdf).

![](.//media/image2.png)

**Figure 1:50-1: MHDS High Level View Diagram**

Readers that need background on high level concepts of Document Sharing
should first review the whitepaper [Health Information Exchange: Enabling Document Sharing Using IHE Profiles](https://profiles.ihe.net/ITI/HIE-Whitepaper/index.html). 
The MHDS Profile is described in the following sections:

* [1:50.1 MHDS Actors, Transactions, and Content Modules](#1501-mhds-actors-transactions-and-content-modules)
* [1:50.2 MHDS Actor Options](#1502-mhds-actor-options)
* [1:50.3 MHDS Required Actor Groupings](#1503-mhds-required-actor-groupings)
* [1:50.4 MHDS Overview](#1504-mhds-overview)
* [1:50.5 MHDS Security Considerations](#1505-mhds-security-considerations)
* [1:50.6 MHDS Cross Profile Considerations](#1506-mhds-cross-profile-considerations)

## 1:50.1 MHDS Actors, Transactions, and Content Modules

This profile orchestrates actors in many existing IHE profiles and
creates one new actor. The actor that is specific to this profile is a
[Document Registry](#150111-document-registry). Figure 1:50.1-1 shows a detailed actor diagram for the
[MHDS Document Registry](#150111-document-registry).

![](.//media/image3.png)

**Figure 1:50.1-1: MHDS Registry Actor Diagram**

Table 1:50.1-1 lists the transactions for each actor directly involved in
the MHDS Profile. To claim compliance with this profile, an actor shall
support all required transactions (labeled “R”) and may support the
optional transactions (labeled “O”).

**Table 1:50.1-1: MHDS Profile - Actors and Transactions**

|                   |                                                                           |                        |             |           |
| ----------------- | ------------------------------------------------------------------------- | ---------------------- | ----------- | --------- |
| Actors            | Transactions                                                              | Initiator or Responder | Optionality | Reference |
| [Document Registry](#150111-document-registry) | (none) – transactions supported come from the grouped actors listed below | \--                    | \--         | [1:50.1.1.1 Document Registry](#150111-document-registry) |

The [Document Registry](#150111-document-registry) is grouped with a set of actors from other
profiles:

- **[MHD](https://profiles.ihe.net/ITI/MHD/index.html) - [Document Recipient](https://profiles.ihe.net/ITI/MHD/1331_actors_and_transactions.html#133113-document-recipient)** supports publication requests by the [MHD Document Source](https://profiles.ihe.net/ITI/MHD/1331_actors_and_transactions.html#133111-document-source). The Comprehensive Metadata Option is required.
- **[MHD](https://profiles.ihe.net/ITI/MHD/index.html) - [Document Responder](https://profiles.ihe.net/ITI/MHD/1331_actors_and_transactions.html#133114-document-responder)** supports the discovery and retrieval of documents by [MHD](https://profiles.ihe.net/ITI/MHD/index.html) [Document Consumer](https://profiles.ihe.net/ITI/MHD/1331_actors_and_transactions.html#133112-document-consumer).
- **[PMIR](https://profiles.ihe.net/ITI/TF/Volume1/ch-49.html) - Patient Identity Consumer** provides patient identity synchronization and specifically the merge function to be applied to any data managed in the [Document Registry](#150111-document-registry).
- **[SVCM](https://profiles.ihe.net/ITI/TF/Volume1/ch-51.html) – Terminology Consumer** enables the [Document Registry](#150111-document-registry) to gain access to ValueSets that the Registry is enforcing Metadata consistency.
- **[mCSD](https://profiles.ihe.net/ITI/mCSD/index.html) – Care Services Selective Consumer** enables the Registry to have access to Organization and Practitioner resources.
- **[IUA](https://profiles.ihe.net/ITI/IUA/index.html) – Authorization Server** and **Resource Server** enforces access control decisions.
- **[ATNA](https://profiles.ihe.net/ITI/TF/Volume1/ch-9.html) - [Secure Node](https://profiles.ihe.net/ITI/TF/Volume1/ch-9.html#9.1.1.1)** enable the [Document Registry](#150111-document-registry) to be secure, record audit records, and support secure transactions.
- **[CT](https://profiles.ihe.net/ITI/TF/Volume1/ch-7.html) - Time Client** assures that all records of time done by the [Document Registry](#150111-document-registry) are aligned with the Time Source.

**<ins>HIE Central Infrastructure Requirements</ins>**

In MHDS, the [Document Registry](#150111-document-registry) is part of a 
[Document Sharing Health Information Exchange (HIE)](https://profiles.ihe.net/ITI/HIE-Whitepaper/index.html). 
See Figure 1:50.1-2. The [Document Registry](#150111-document-registry)
relies upon services that would be hosted within the HIE Central
Infrastructure with a set of Service endpoints as illustrated in the
yellow “HIE Central Infrastructure”. The HIE also contains systems,
illustrated in green, that submit and consume documents. The combination
of [MHDS Document Registry](#150111-document-registry) (white), HIE Central Infrastructure (yellow),
and Systems that publish or consume documents (green) make up the
Document Sharing Community (aka Community).

![](.//media/image4.png)

**Figure 1:50.1-2: MHDS Document Sharing Health Information Exchange**

The HIE Central Infrastructure is a set of Services based on IHE
Profiles as shown in Figure 1:50.1-2:

- **[CT](https://profiles.ihe.net/ITI/TF/Volume1/ch-7.html) - Time Server** – to provide consistent time to all participant systems
- **[ATNA](https://profiles.ihe.net/ITI/TF/Volume1/ch-9.html) – [Audit Record Repository](https://profiles.ihe.net/ITI/TF/Volume1/ch-9.html#9.1.1.3)** with support for the ATX: FHIR Feed Option – to capture audit events and provide appropriate audit log access for security and privacy use-cases
- **[PMIR](https://profiles.ihe.net/ITI/TF/Volume1/ch-49.html) – Patient Identity Source and Patient Identity Manager** – to provide patient identity lookup by demographics or identity, and to receive create and update of patient identity from participants
- **[SVCM](https://profiles.ihe.net/ITI/TF/Volume1/ch-51.html) – Terminology Repository** – Provide vocabulary and value set management within the Community
- **[mCSD](https://profiles.ihe.net/ITI/mCSD/index.html) – Care Services Selective Supplier** – a Provider Directory to enable endpoint lookup and optionally provider identity management

There are other useful actors that are compatible with MHDS, but are not
required by the MHDS Profile:

- **[NPFS](https://profiles.ihe.net/ITI/TF/Volume1/ch-47.html) – File Manager** – Provide files that are needed in the community but are not patient specific such as policy documents
- **[mXDE](https://profiles.ihe.net/ITI/TF/Volume1/ch-45.html) – Data Element Extractor** – to enable [QEDm](https://www.ihe.net/uploadedFiles/Documents/PCC/IHE_PCC_Suppl_QEDm.pdf) access to data elements derived from published documents
- **[QEDm](https://www.ihe.net/uploadedFiles/Documents/PCC/IHE_PCC_Suppl_QEDm.pdf) – Clinical Data Source** – to enable access to data elements (aka FHIR clinical Resources)

In addition to these IHE-defined actors, the Community will also select
how they will manage Digital Certificates through a Certificate
Authority, and other functionalities and non-functional requirements
such as response-time, service-level-agreements, remediation-planning,
remediation-access, etc.

The [Document Registry](#150111-document-registry) and the supporting services listed above provide a
set of services that make up a Document Sharing Infrastructure that is
based on FHIR. This set of services enable systems that publish
documents and systems that consume documents. Additionally, the [mXDE](https://profiles.ihe.net/ITI/TF/Volume1/ch-45.html)
Profile may be used to make the information in shared documents more
consumable as FHIR Resources using [QEDm](https://www.ihe.net/uploadedFiles/Documents/PCC/IHE_PCC_Suppl_QEDm.pdf) Profile. See Section [1:50.6 Cross Profile Considerations](#1506-mhds-cross-profile-considerations) for more details.

### 1:50.1.1 Actor Descriptions and Actor Profile Requirements

This profile assumes that some [Health Information Exchange (HIE)](https://profiles.ihe.net/ITI/HIE-Whitepaper/index.html)
authority manages the configuration of the Community. This includes
specification of an appropriate Certificate Authority, Time Source,
Domain Name Service, Valueset Management, Provider Directory, Audit
Record Repository, Patient Identity Manager, and Authorization Service.

The HIE authority is responsible for setting Patient Identity quality
criteria including the minimally acceptable Patient identity
constraints. This would set the data elements that describe the Patient
within the Community and the quality of the identity proofing and
identity confirmation necessary by all participants in the Community.

The HIE authority is responsible for setting Document Sharing Metadata
rules, following the metadata rules and using the Metadata Handbook to
set specific metadata element requirements including the specification
of mandatory ValueSets. See the [Document Sharing Metadata
Handbook](https://www.ihe.net/uploadedFiles/Documents/ITI/IHE_ITI_Handbook_Metadata.pdf).

#### 1:50.1.1.1 Document Registry

The functions of the [MHDS Document Registry](#150111-document-registry) rely on grouped actors from
the other IHE Profiles; see Section 1:50.3.

The Document Registry SHALL include a configuration management function
to enable configuration of the grouped actors, including Metadata rules,
policy, and security.

The Document Registry SHALL be grouped with [CT](https://profiles.ihe.net/ITI/TF/Volume1/ch-7.html) – Time Client to keep
internal clocks synchronized to the identified Time Source so that
records of time are correlated.

The Document Registry SHALL be grouped with an [ATNA Secure Node](https://profiles.ihe.net/ITI/TF/Volume1/ch-9.html#9.1.1.1) or
Secure Application:

- The Document Registry SHALL obtain a Digital Certificate from the HIE-defined Certificate Authority.
- The Document Registry SHALL support at least the [ATNA](https://profiles.ihe.net/ITI/TF/Volume1/ch-9.html) “STX: TLS 1.2 Floor using BCP195” Option.
- The Document Registry SHALL allow only authorized access to the protected resources managed by the Document Registry.
- The Document Registry SHALL record all security relevant events to [ATNA](https://profiles.ihe.net/ITI/TF/Volume1/ch-9.html) [Audit Record Repository](https://profiles.ihe.net/ITI/TF/Volume1/ch-9.html#9.1.1.3) with the “ATX: FHIR Feed” Option. This SHALL include all IHE-defined audit events that are in the control of the Document Registry, including its grouped actors.

##### 1:50.1.1.1.1 When the grouped MHD Document Recipient – is triggered

Triggered by: a Provide Document Bundle \[ITI-65\] transaction.

![](.//media/image5.png)

**Figure 1:50.1.1.1.1-1: Document Publication Process Flow**

1.  The Document Registry SHALL confirm its identity to the requesting system by use of the [ATNA Secure Node](https://profiles.ihe.net/ITI/TF/Volume1/ch-9.html#9.1.1.1) or [Secure Application](https://profiles.ihe.net/ITI/TF/Volume1/ch-9.html#9.1.1.2) TLS protocol using a Certificate assigned to the Document Registry.
2.  When the Authorization Option (Section [1:50.2.1](#15021-authorization-option)) is implemented and enabled, the Document Registry SHALL confirm the client identity using the [IUA](https://profiles.ihe.net/ITI/IUA/index.html) Profile.
3.  The Document Registry SHALL validate to the requirements of [MHD Document Recipient](https://profiles.ihe.net/ITI/MHD/1331_actors_and_transactions.html#133113-document-recipient) using the MHD Comprehensive Metadata Option. Additional policy driven requirements, not specified here, may also apply.
4.  When the UnContained Reference Option is used in the grouped [MHD Document Recipient](https://profiles.ihe.net/ITI/MHD/1331_actors_and_transactions.html#133113-document-recipient), the Document Registry SHALL not require that the references are contained, but SHALL validate that the reference is found in the central registries. (See Section [1:50.2.4 UnContained Reference Option](#15024-uncontained-reference-option).)
5.  The Document Registry SHALL validate that the subject of the DocumentReference, and List Resources is the same Patient, and that Patient is a recognized and active Patient within the Community. The Patient identity must be recognized and active by the [PMIR Patient Identity Manager](https://profiles.ihe.net/ITI/TF/Volume1/ch-49.html) in the document sharing community. This may be accomplished by a query of the [PMIR Patient Identity Manager](https://profiles.ihe.net/ITI/TF/Volume1/ch-49.html), by way of a cached internal patient database, or other means.
6. The Document Registry SHALL validate the metadata conformance received according to the appropriate validation rules, and configured ValueSets to assure that the document submission request is valid. If any of the metadata are found to be not valid then the transaction shall be rejected.
7. When the SVCM Validation Option (Section [1:50.2.3](#15023-svcm-validation-option)) is implemented and enabled, the Document Registry SHALL use the grouped [SVCM](https://profiles.ihe.net/ITI/TF/Volume1/ch-51.html) Terminology Consumer to validate metadata elements as appropriate to configured policy. For example, the DocumentReference.type often must be a value within a ValueSet agreed to by the Community.
8. Provided the request is valid, the Document Registry SHALL persist all DocumentReference, List, and Binary that are received by way of the grouped MHD - [Document Recipient](https://profiles.ihe.net/ITI/MHD/1331_actors_and_transactions.html#133113-document-recipient) – Provide Document Bundle \[ITI-65\] Transaction.
9. When the request includes a DocumentReference intended to replace an existing DocumentReference, the Document Registry SHALL mark the replaced DocumentReference as deprecated. The Replace action in the request is indicated when the Bundle contains a new DocumentReference with `DocumentReference.relatesTo.code` of `replaces` and `DocumentReference.relatesTo.target` pointing at the existing DocumentReference to be deprecated. The Document Registry sets the existing `DocumentReference.status` element to `inactive`.
10. Any of the above checks that fail will result in the whole Provide Document Bundle \[ITI-65\] failing and returning errors as defined in \[ITI-65\].
11. The Document Registry SHALL record success and failure events into the [ATNA Audit Record Repository](https://profiles.ihe.net/ITI/TF/Volume1/ch-9.html#9.1.1.3).

##### 1:50.1.1.1.2 When the grouped MHD Document Responder – is triggered

Triggered by: any Find Document Lists \[ITI-66\], Find Document
References \[ITI-67\], and Retrieve Document \[ITI-68\] Transactions.

![](.//media/image6.png)

**Figure 1:50.1.1.1.2-1: Discovery and Retrieval of Existing Document Process Flow**

1.  The Document Registry SHALL confirm its identity to the requesting system by use of the [ATNA Secure Node](https://profiles.ihe.net/ITI/TF/Volume1/ch-9.html#9.1.1.1) or [Secure Application](https://profiles.ihe.net/ITI/TF/Volume1/ch-9.html#9.1.1.2) TLS protocol using a Certificate assigned to the Document Registry.
2. When the Authorization Option is implemented and enabled, the Document Registry SHALL confirm the client identity using the [IUA](https://profiles.ihe.net/ITI/IUA/index.html) Profile.
3. Additional policy driven requirements, not specified here, may also apply. Such as enforcement at the Document Registry of Patient-specific Consent Directives.
4. The Document Registry SHALL validate that the subject of the find or retrieve request is a Patient that is a recognized Patient within the Community. The Patient identity must be recognized by the approved [PMIR Patient Identity Manager](https://profiles.ihe.net/ITI/TF/Volume1/ch-49.html) system. This may be accomplished by a query of the [PMIR](https://profiles.ihe.net/ITI/TF/Volume1/ch-49.html) manager, by way of a cached internal patient database, or other means.
5. The Document Registry SHALL provide the persisted resources to the grouped [MHD Document Responder](https://profiles.ihe.net/ITI/MHD/1331_actors_and_transactions.html#133114-document-responder) in support of the [Document Responder](https://profiles.ihe.net/ITI/MHD/1331_actors_and_transactions.html#133114-document-responder) duties to return results.
6. The Document Registry, if the Authorization Option is used, SHALL confirm that only authorized results are returned.
7. The Document Registry SHALL record a success or failure event into the [ATNA Audit Record Repository](https://profiles.ihe.net/ITI/TF/Volume1/ch-9.html#9.1.1.3).

##### 1:50.1.1.1.3 When the grouped PMIR Patient Identity Consumer – is triggered

Triggered by: a Mobile Patient Identity Feed \[ITI-93\] transaction with
a Merge:

![](.//media/image7.png)

**Figure 1:50.1.1.1.3-1: Patient Merge Process Flow**

The Document Registry SHALL search for any resources with the deprecated
`_id` value in the `DocumentReference.subject`,
and `List.subject`; and replace subject value of with the surviving id.
The Document Registry SHALL record a single audit event indicating the
Merge action, with an `.entity` element for each of the updated Document
Registry Resources updated. The Document Registry SHOULD create within
the Document Registry a single Provenance Resource indicating the Merge
action, with the .target element pointing at all of the resources
updated by the Document Registry.

No behavior is expected of the Document Registry on receipt of a feed
containing create, delete, or update, although the Document Registry may
consume and persist these to support the Document Registry requirements
to validate Patient references as a recognized Patient within the
Community.

#### 1:50.1.1.2 Storage of Binary

There are two alternatives for storing the Binary Resource for documents
stored in the community: (1) The [Document Source](https://profiles.ihe.net/ITI/MHD/1331_actors_and_transactions.html#133111-document-source) includes the Binary
Resource in the \[ITI-65\] transaction, and the Document Registry is
required to store it. (2) The Community allows the Binary to be stored
elsewhere in the Community.

The second alternative requires that the Community has the alternative
to store the Binary in a system in the Community other than the Document
Registry. This might be other centralized infrastructure, distributed
infrastructure, or within the system implementing the [Document Source](https://profiles.ihe.net/ITI/MHD/1331_actors_and_transactions.html#133111-document-source).
The \[ITI-65\] transaction does not include the Binary, and the
`DocumentReference.content.attachment.url`. value is a persistent URL to
the Binary content. When this is used by the Community, the service
hosting the Binary shall:

- persist the Binary for the lifecycle expected of the Community,
- provide access to the community members,
- use the security model agreed to by the community members

## 1:50.2 MHDS Actor Options

Options that may be selected for each actor in this profile, if any, are
listed in the Table 1:50.2-1. Dependencies between options, when
applicable, are specified in notes.

**Table 1:50.2-1: MHDS – Actors and Options**

<table>
<colgroup>
<col style="width: 33%" />
<col style="width: 33%" />
<col style="width: 33%" />
</colgroup>
<thead>
<tr class="header">
<th>Actor</th>
<th>Option Name</th>
<th>Reference</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td rowspan="4">Document Registry</td>
<td>Authorization Option</td>
<td>Section 1:50.2.1</td>
</tr>
<tr class="even">
<td>Consent Manager Option (Note 1)</td>
<td>Section 1:50.2.2</td>
</tr>
<tr class="odd">
<td>SVCM Validation Option</td>
<td>Section 1:50.2.3</td>
</tr>
<tr class="even">
<td>Uncontained Reference Option</td>
<td>Section 1:50.2.4</td>
</tr>
</tbody>
</table>

Note 1: The Consent Manager Option requires the Authorization Option


### 1:50.2.1 Authorization Option

The Document Registry SHALL be grouped with an [IUA](https://profiles.ihe.net/ITI/IUA/index.html) Resource Server and
[IUA](https://profiles.ihe.net/ITI/IUA/index.html) Authorization Server Actors. The [IUA](https://profiles.ihe.net/ITI/IUA/index.html) Resource Server enforces OAuth
Authorization decisions made by the grouped [IUA](https://profiles.ihe.net/ITI/IUA/index.html) Authorization Server.
Thus, all accesses to the Document Registry must have a token issued by
the [IUA](https://profiles.ihe.net/ITI/IUA/index.html) Authorization Server. These [IUA](https://profiles.ihe.net/ITI/IUA/index.html) Authorization Server decisions
protect both requests from [MHD Document Source](https://profiles.ihe.net/ITI/MHD/1331_actors_and_transactions.html#133111-document-source) Actors for publication,
and from [MHD Document Consumer](https://profiles.ihe.net/ITI/MHD/1331_actors_and_transactions.html#133112-document-consumer) actors for access and disclosure. The
rules used for this authorization decision are not defined in the MHDS
Profile. See the Consent Manager Option for specific access control
rules associated with that option.

![](.//media/image8.png)

**Figure 1:50.2.1-1: Document Publication Process Flow with Authorization Option**

### 1:50.2.2 Consent Manager Option

The Document Registry SHALL be grouped with an [IUA](https://profiles.ihe.net/ITI/IUA/index.html) Resource Server and
the [IUA](https://profiles.ihe.net/ITI/IUA/index.html) Authorization Server in order to enforce simple Permit and Deny
access patient specific privacy disclosure consents for Treatment
purpose. The Consent Manager Option does not affect publication by
[Document Source](https://profiles.ihe.net/ITI/MHD/1331_actors_and_transactions.html#133111-document-source) to the Document Registry, but rather only affects
disclosure activities between a [Document Consumer](https://profiles.ihe.net/ITI/MHD/1331_actors_and_transactions.html#133112-document-consumer) and the Document Registry.

The grouped [IUA](https://profiles.ihe.net/ITI/IUA/index.html) Authorization Server would be used to manage the consent
status and make authorization decisions based on the consent status. The
changing of the status is a functional requirement that is not defined
by IHE. The [IUA](https://profiles.ihe.net/ITI/IUA/index.html) Resource Server that is grouped with the MHDS Document
Registry would enforce these decisions.

![](.//media/image9.png)

**Figure 1:50.2.2-1: Consent Management for Disclosure Process Flow**

The grouped [IUA](https://profiles.ihe.net/ITI/IUA/index.html) Authorization Server SHALL support consent configuration
to enable Implied Consent and Explicit Consent environments. Implied
Consent environments allow disclosure when no Consent has been recorded
for that patient, Explicit Consent environments Deny disclosure when no
Consent has been recorded for that patient.

The Permit policy is specific to requests from an authorized Document
Consumer from authorized identities (applications and/or users) with
appropriate roles, and authorized Treatment PurposeOfUse.

![](.//media/image10.png)

**Figure 1:50.2.2-2: Simple Consent state diagram**

The [IUA](https://profiles.ihe.net/ITI/IUA/index.html) Authorization Server SHALL

- support Permit and Deny policies and may support other policies.
- support through some functionality the patient consent state to be changed: Authorize action to move from Deny to Permit state, and Revoke action to move from Permit to Deny state.
- support consent state for PurposeOfUse of Treatment (HL7 PurposeOfUse code of “TREAT”) and may support consent states for other PurposeOfUse values within the scope of the MHDS community.
- Deny access to any PurposeOfUse not authorized.
- support expiring a consent that results in a Permit state automatically transitioning to Deny at expiration.

The [IUA](https://profiles.ihe.net/ITI/IUA/index.html) Resource Server enforcement point grouped with the MHDS Document
Registry SHALL enforce the security authorization decision. This
includes confirming all data requested are for the specific patient.
This prevents a [Document Consumer](https://profiles.ihe.net/ITI/MHD/1331_actors_and_transactions.html#133112-document-consumer) from requesting access to resources
outside the scope of the security token given it by the [IUA](https://profiles.ihe.net/ITI/IUA/index.html)
Authorization Server.

Note that this option does not protect Binary content stored outside of
the Document Registry; see Section [1:50.1.1.2](#150112-storage-of-binary). When documents are stored
outside of the Document Registry, the [Document Source](https://profiles.ihe.net/ITI/MHD/1331_actors_and_transactions.html#133111-document-source) system takes on
the burden of protecting the document.

In order to support this Consent Manager Option, the following [IUA](https://profiles.ihe.net/ITI/IUA/index.html)
constraint is defined. This constraint impacts the [Document Consumer](https://profiles.ihe.net/ITI/MHD/1331_actors_and_transactions.html#133112-document-consumer)
grouped [IUA](https://profiles.ihe.net/ITI/IUA/index.html) Authorization Client, and the [IUA](https://profiles.ihe.net/ITI/IUA/index.html) actors within the Document
Registry. The important elements for the [Document Consumer](https://profiles.ihe.net/ITI/MHD/1331_actors_and_transactions.html#133112-document-consumer) to convey are
the scope values for PurposeOfUse and the identity of the Patient. This
OAuth Scope specification does not require the use of SMART-on-FHIR but
is compatible with it. There are two defined scope values that are
included in the scope separated by a space and repeated as necessary:

```
“PurposeOfUse” '.' PurposeOfUse

queryParam (e.g. “patient” '=' Patient)
```

e.g., a simple request for Treatment access to patient f5c7395

```
PurposeOfUse.TREAT
patient="http://myserver.example/fhir/Patient/f5c7395"
```

e.g., a request for Treatment, Payment, and Operations access to patient
f5c7395 in addition to SMART-on-FHIR scopes for read access to
DocumentReference, List, and Binary

```
user/DocumentReference.read user/List.read user/Binary.read 
PurposeOfUse.TREAT PurposeOfUse.HPAYMT PurposeOfUse.OPERAT
patient="http://myserver.example/fhir/Patient/f5c7395"
```

### 1:50.2.3 SVCM Validation Option

The Document Registry that supports the SVCM Validation Option SHALL be grouped
with a [SVCM](https://profiles.ihe.net/ITI/TF/Volume1/ch-51.html) Terminology Consumer and uses this interface to do
validation of submitted metadata codes in the \[ITI-65\] submission as
being within in the community assigned valueSet. If any of the codes are
found to be not valid then Document Registry SHALL reject the \[ITI-65\]
transaction.

### 1:50.2.4 UnContained Reference Option

By default in \[ITI-65\], an [MHD Document Source](https://profiles.ihe.net/ITI/MHD/1331_actors_and_transactions.html#133111-document-source) is required to include
by containment the information in the `DocumentReference.author`, 
the `DocumentReference.authenticator`, 
the `DocumentReference.context.sourcePatientInfo`, and 
the `List.source`. This requirement encourages the persisting of
the information at the time the document is published. This supports
lifecycle management that recognizes that these identities change over
time, and often become invalid due to individual retirement or other
reasons to no-longer be active (e.g., the document is utilized 20 years
after it was first published, and thus the original author has long
since retired and would therefore not be in an active provider
directory.)

The UnContained Reference Option recognizes that a Community may choose
to longitudinally maintain their [mCSD](https://profiles.ihe.net/ITI/mCSD/index.html) provider directory and [PMIR Patient Identity Manager](https://profiles.ihe.net/ITI/TF/Volume1/ch-49.html). 
When this longitudinal consistency is managed, then
the entries in the [MHDS Document Registry](#150111-document-registry) do not need to make a copy of
the information known at the time of publication since a Reference to
the information in these directories will be valid over the full
lifecycle of the Document Registry entries.

The UnContained Reference Option requires the grouped MHD Document
Recipient to support the MHD UnContained Option. An [MHD Document Source](https://profiles.ihe.net/ITI/MHD/1331_actors_and_transactions.html#133111-document-source)
may implement the MHD UnContained Option so as to be able to send
UnContained References. The MHD and MHDS UnContained Option allows
`DocumentReference.author`, `DocumentReference.authenticator`,
`DocumentReference.context.sourcePatientInfo`, and `List.source`
to be a `Reference` to a
`(Practitioner|PractitionerRole|Organization|Patient)` Resource, where the
referenced resource is published in the associated centrally managed
[mCSD](https://profiles.ihe.net/ITI/mCSD/index.html) Care Services Selective Supplier, or [PMIR Patient Identity Manager](https://profiles.ihe.net/ITI/TF/Volume1/ch-49.html).

![](.//media/image11.png)

**Figure 1:50.2.4-1: Author Reference Process Flow**

The [mCSD](https://profiles.ihe.net/ITI/mCSD/index.html) Care Services Selective Supplier and the [PMIR Patient Identity Manager](https://profiles.ihe.net/ITI/TF/Volume1/ch-49.html) are persisting long term the data so that the Resources within
the [MHDS Document Registry](#150111-document-registry) are available for the life of the Document
Registry entry.

The Document Registry shall validate publication requests to ensure that
all `DocumentReference.author`, `DocumentReference.authenticator`,
`DocumentReference.context.sourcePatientInfo`, and
`List.author`; elements are either contained or are references
to valid and active entry in the [mCSD](https://profiles.ihe.net/ITI/mCSD/index.html) Care Services Selective Supplier
or [PMIR Patient Identity Manager](https://profiles.ihe.net/ITI/TF/Volume1/ch-49.html). The Document Registry shall validate
this by use of [mCSD](https://profiles.ihe.net/ITI/mCSD/index.html) Care Services Selective Consumer using the Find
Matching Care Services \[ITI-90\] transaction, and Patient identity
either internal Patient identity cache or possibly by [PMIR Patient Identity Manager](https://profiles.ihe.net/ITI/TF/Volume1/ch-49.html) using the PDQm Query \[ITI-78\].

## 1:50.3 MHDS Required Actor Groupings 

An actor from this profile (Column 1) shall implement all of the
required transactions in this profile **in addition to all** of the requirements for the
grouped actor (Column 3).

Section [1:50.5](#1505-mhds-security-considerations) describes some optional groupings that may be of interest
for security considerations and Section [1:50.6](#1506-mhds-cross-profile-considerations) describes some optional
groupings in other related profiles.

**Table 1:50.3-1: Required Actor Groupings**

<table style="width:100%;">
<colgroup>
<col style="width: 15%" />
<col style="width: 25%" />
<col style="width: 45%" />
<col style="width: 15%" />
</colgroup>
<thead>
<tr class="header">
<th>MHDS Actor</th>
<th>Grouping Condition</th>
<th>Actor(s) to be grouped with</th>
<th>Reference</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td rowspan="9">Document Registry</td>
<td>Required</td>
<td>CT / Time Client</td>
<td><a href="https://profiles.ihe.net/ITI/TF/Volume1/ch-7.html">ITI TF-1:7</a></td>
</tr>
<tr class="even">
<td>Required</td>
<td>ATNA / Secure Node or Secure Application with the STX: TLS 1.2 with the BCP195 Option and the ATX: FHIR Feed Option</td>
<td><a href="https://profiles.ihe.net/ITI/TF/Volume1/ch-9.html">ITI TF-1:9</a></td>
</tr>
<tr class="odd">
<td>Required</td>
<td>MHD / Document Responder</td>
<td><a href="https://profiles.ihe.net/ITI/MHD/index.html">ITI TF-1:33</a></td>
</tr>
<tr class="even">
<td>Required</td>
<td>MHD / Document Recipient with the Comprehensive Metadata Option</td>
<td><a href="https://profiles.ihe.net/ITI/MHD/index.html">ITI TF-1:33</a></td>
</tr>
<tr class="odd">
<td>Required</td>
<td>PMIR / Patient Identity Consumer</td>
<td><a href="https://profiles.ihe.net/ITI/TF/Volume1/ch-49.html">ITI TF-1:49</a></td>
</tr>
<tr class="even">
<td>if the Authorization Option</td>
<td>IUA / Resource Server</td>
<td><a href="https://profiles.ihe.net/ITI/TF/Volume1/ch-34.html">ITI TF-1:34</a></td>
</tr>
<tr class="odd">
<td>if the Authorization Option</td>
<td>IUA / Authorization Server</td>
<td><a href="https://profiles.ihe.net/ITI/TF/Volume1/ch-34.html">ITI TF-1:34</a></td>
</tr>
<tr class="even">
<td>if the UnContained References Option</td>
<td>mCSD / Care Services Selective Consumer</td>
<td><a href="https://profiles.ihe.net/ITI/TF/Volume1/ch-46.html">ITI TF-1:46</a></td>
</tr>
<tr class="odd">
<td>if the SVCM Validation Option</td>
<td>SVCM / Terminology Consumer</td>
<td><a href="https://profiles.ihe.net/ITI/TF/Volume1/ch-51.html">ITI TF-1:51</a></td>
</tr>
</tbody>
</table>


## 1:50.4 MHDS Overview

The MHDS Profile provides a Document Registry that persists, manages,
and provides access using the [MHD](https://profiles.ihe.net/ITI/MHD/index.html) access methods. This is in support of
IHE Document Sharing as described in the [Health Information Exchange: Enabling Document Sharing Using IHE Profiles](https://profiles.ihe.net/ITI/HIE-Whitepaper/index.html) whitepaper.

### 1:50.4.1 Concepts

The MHDS Profile supports Document Sharing utilizing only FHIR
infrastructures. This is similar functionality to XDS but using the FHIR
standard and not SOAP. The advantage of the FHIR infrastructure is that
it is based on more accessible technology, especially for mobile
devices; but the solution is not limited to mobile devices.

### 1:50.4.2 Use Cases

#### 1:50.4.2.1 Use Case \#1: Publication of a new document with persistence

This use case utilizes [MHD Document Source](https://profiles.ihe.net/ITI/MHD/1331_actors_and_transactions.html#133111-document-source) using the Provide Document
Bundle \[ITI-65\] transaction to the [Document Recipient](https://profiles.ihe.net/ITI/MHD/1331_actors_and_transactions.html#133113-document-recipient) that is grouped
with the [MHDS Document Registry](#150111-document-registry). The Document Registry validates the
publication request and persists the information if approved. The MHD
Comprehensive Metadata Option is required of the [MHD Document Source](https://profiles.ihe.net/ITI/MHD/1331_actors_and_transactions.html#133111-document-source) as
the [MHD Document Recipient](https://profiles.ihe.net/ITI/MHD/1331_actors_and_transactions.html#133113-document-recipient) within the [MHDS Document Registry](#150111-document-registry) will
implement the Comprehensive Metadata Option. 
See Section [1:50.1.1.1.1](#1501111-when-the-grouped-mhd-document-recipient--is-triggered).

#### 1:50.4.2.2 Use Case \#2: Update of patient identity after an authorized Merge

This use case utilizes the grouped [PMIR](https://profiles.ihe.net/ITI/TF/Volume1/ch-49.html) Patient Identity Consumer to
enable the [Document Registry](#150111-document-registry) to receive updates of Patient Identity, so
that when a Merge is authorized, the [Document Registry](#150111-document-registry) will update any
of the references to the former Patient Identity with the Patient
Identity that survives. 
See Section [1:50.1.1.1.3](#1501113-when-the-grouped-pmir-patient-identity-consumer--is-triggered).

#### 1:50.4.2.3 Use Case \#3: Discovery and Retrieval of existing documents

The [MHD Document Consumer](https://profiles.ihe.net/ITI/MHD/1331_actors_and_transactions.html#133112-document-consumer) is supported by the [Document Registry](#150111-document-registry) grouped
with the [MHD Document Responder](https://profiles.ihe.net/ITI/MHD/1331_actors_and_transactions.html#133114-document-responder) to allow for the [Document Consumer](https://profiles.ihe.net/ITI/MHD/1331_actors_and_transactions.html#133112-document-consumer) to
discover and retrieve document metadata and content. 
See Section [1:50.1.1.1.2](#1501112-when-the-grouped-mhd-document-responder--is-triggered).

#### 1:50.4.2.4 Use Case \#4: Consent Management for disclosure under Use Case \#3

With the use of the Consent Management Option the [Document Registry](#150111-document-registry)
supports simple Allow and Deny patient privacy consents for disclosure.
These controls are available to prevent unauthorized disclosure. These
Consent Management function does not prevent publication from Use Case
\#1 to enable documentation longitudinal consistency and for accesses
not mediated by Patient Privacy Consent. 
See Section [1:50.2.2](#15022-consent-manager-option).

## 1:50.5 MHDS Security Considerations

*The security considerations for a content module are dependent upon the
security provisions defined by the grouped actor(s).*

This section will discuss how a community that leverages the MHDS
Profiles for document sharing can protect patient privacy and
information security.

An especially important aspect that is beyond the scope of IHE is the
definition of the overall Policies of the community. There are
whitepapers and handbooks from IHE 
(see Section [1:50.1](#1501-mhds-actors-transactions-and-content-modules)), but there is no
single policy that must be put in place by an IHE based community to
ensure privacy and security. In this section, we will discuss potential
policy decisions and positions with regard to the profiles. It is
especially important for the reader to understand that the scope of an
IHE profile is only the technical details necessary to ensure
interoperability. It is up to any organization building a community to
understand and carefully implement the policies of that community and to
perform the appropriate risk analysis. Although this section is not
going to define the policies that a community should have, it will
explore some of the policy building activities to demonstrate how such
policies can be supported.

The Policy Environment is made up of many layers of policies. These
policies work together in an interlocking hierarchy. We will introduce
some of these layers in this section and show how they influence the
technology. At the highest layer are international policies, like the
International Data Protection Principles. Countries or regions will have
specific policies. Some examples are USA HIPAA Security and Privacy
Rules, with further refinement by the states. There are horizontal
policies that are common among a specific industry, such as those from
medical professional societies. Then within the enterprise will be
specific information technology policies. As shown in this section, the
IHE Profiles offer not only the means to exchange information, but to do
so in a way that is supportive of many of the policies mentioned.

The policy landscape that the community is built on needs to be defined
well before the community is built.

### 1:50.5.1 Policies and Risk Management

IHE solves interoperability problems via the implementation of
technology standards. It does not ***define*** Privacy or Security
Policies, Risk Management, Healthcare Application Functionality,
Operating System Functionality, Physical Controls, or even general
Network Controls.

While community Policies and Risk Management are outside its scope, IHE
does recognize that these elements are a necessary piece of a system
implementation. IHE IT Infrastructure technical white paper, “Template
for XDS Affinity Domain Deployment Planning” outlines some of the issues
that should be evaluated for inclusion in the local Policy creation and
Risk Management decisions. It is therefore the duty of system
implementers to take this guidance into account as part of their Risk
Management practices.

Implementers need to be aware of different kinds of policies that need
to be harmonized with those policies of the local health enterprises
connected to the community. The following is a list of sample policy
fragments to stimulate discussion:

- Policies for who has access to what type of documents in the  community
- Policies for who is allowed to publish documents into the community
- Policies on the acceptable types of documents that can be published into the community
- Policies that indicate acceptable levels of risk within community
- Policies that indicate what sanctions will be imposed on individuals that violate the community policies
- Policies on training and awareness
- Policies on user provisioning and de-provisioning within the community and local operation
- Policies on emergency mode operations
- Policies on acceptable network use (browser, decency, external-email access, etc.)
- Policies on user authentication methods that are acceptable
- Policies on backup and recovery planning
- Policies on acceptable third-party access
- Policies on secondary use of the information in the community
- Policies on the availability of the community systems (are the community systems considered life critical, normal, or low priority)
- Policies for maintenance downtime
- Policies for length of time that information will be maintained in the community

These policies are not a flat set, but often interlock and at other
times cascade. An important set of policies are those around emergency
modes. There are wide definitions of cases that are referred to as
emergency mode. These emergency modes need to be recognized for the
risks they present. When these use cases are factored in up-front, the
mitigations are reasonable.

- Natural or man-made catastrophic disaster (e.g., hurricane, earthquake) – often times additional workforce migrates into the area from other places to help out. These individuals need to quickly be screened and provisioned with appropriate access.
- Utility failure (e.g., electric failure) – this situation is common and easily handled through uninterruptible power supplies and backup generation
- IT infrastructure failure (e.g., hard drive crash) – this situation is also common and handled through common infrastructural redundancy
- Need to elevate privileges due to a patient emergency, often called break-glass (e.g., nurse needs to prescribe)
- Need to override a patient specified privacy block due to eminent danger to that patient – this override is not a breaking of the policy but would need to be an explicit condition within the policy.

Often times being in the emergency department is considered as an
emergency mode, but the emergency department is really a normal mode for
those scheduled to work there. When looked at as normal mode, the proper
privileges and workflow flexibility can be specified.

Policy development often is frustrated by apparent conflicts in the goal
or effect of multiple layers of policies. These conflicts are often only
on the surface and can be addressed upfront once the details of the
policy are understood. A good example of a policy conflict is in records
retention requirements at the national level vs. at the Medical Records
level. Medical Records regulatory retention is typically fixed at a
short period after death, yet if the patient has black lung then the
records must be preserved well beyond.

### 1:50.5.2 Technical Security and Privacy controls

In 1980, the Organization for Economic Cooperation and Development
(“OECD”) developed Guidelines on the Protection of Privacy and
Transborder Flows of Personal Data. These guidelines were intended to
harmonize national privacy laws, uphold human rights, and promote the
free flow of information among its 30 member countries. The OECD
guidelines have served as a basis for data protection laws in the United
States, Europe, Canada, Japan, Australia, and elsewhere. Together, these
principles and laws provide a useful framework for developing general
data protection requirements for health information systems. For more
information see <http://oecdprivacy.org>.

Based on the experience of the IHE participants in implementing
community environments there is a common set of Security and Privacy
controls that have been identified. These controls are informed by a
combination of the OECD data protection principles, experience with
explicit policies at community implementations, and Security Risk
Management.

These security and privacy controls are:

1.  Audit Log Controls – The controls that can prove the system is protecting the resources in accordance to the policies. This set of controls includes security audit logging, reporting, alerting and  alarming.
2. Identification and Authentication Controls – The controls that prove that a system or person is who they say that they are. For example: personal interactions, Oauth, OpenID-Connect
3. Data Access Controls – The controls that limit access by an authenticated entity to the information and functions that they are authorized to have access to. These controls are often implemented using Role Based Access Controls (RBAC), or Attribute Based Access Controls (ABAC).
4. Secrecy Controls– As sensitive information is created, stored, communicated, and modified; this control protects the information from being exposed. For example: encryption or access controls.
5. Data Integrity Controls – The controls that prove that the data has not changed in an unauthorized way. For example: digital signatures, secure hash algorithms, CRC, and checksum.
6. Non-Repudiation Controls – The controls that ensure that an entity cannot later refute that they participated in an act. For example, author of a document, order of a test, prescribe of medications.
7. Patient Privacy Controls – The controls that enforce patient specific handling instructions.
8. Availability Controls – The controls that ensure that information is available when needed. For example: backup, replication, fault tolerance, RAID, trusted recovery, uninterruptible power supplies, etc. (not an area where Interoperability applies)

### 1:50.5.3 Applying Security and Privacy to Document Sharing

IHE does not set policies but is policy sensitive. Therefore, we now
discuss the policy enabling technologies but not the policies
themselves.

This section shows how the existing security controls in the local
health IT system are leveraged and extended when they become
interconnected through document sharing.

#### 1:50.5.3.1 Basic Security

IHE recognizes that in healthcare, with patient lives at stake, audit
control is the primary method of accountability enforcement. The profile
that provides this basic security principle is Audit Trail and Node
Authentication ([ATNA](https://profiles.ihe.net/ITI/TF/Volume1/ch-9.html)). This profile requires three things of each
system:

1. User authentication and Access Controls are enforced accordingly,
2. Security Audit Logs are recorded, and
3. Strong network authentication and encryption for all communications of sensitive patient data

The Security Audit Logging includes a set of security relevant events
that must be audited. When one of these events happens the record of the
event must be described a specific way. The systems are expected to
support the recording of all of the security relevant events that might
happen in the system. The [ATNA](https://profiles.ihe.net/ITI/TF/Volume1/ch-9.html) Profile offloads the recording,
filtering, alerting, and reporting to an audit service. The more
centralized this audit log analysis can be, the easier it is to prove
accountability across the whole Document Sharing exchange.

Once it is known that the system will enforce Access Controls and Audit
Controls then it can be connected to other systems that have also been
assessed positively. In this way these systems only talk to other
systems that also agree to enforce the common policies. This creates a
basis for a chain of trust through accountability among all of the
systems participating in the Document Sharing exchange. The
communications between these trusted systems is also encrypted.

#### 1:50.5.3.2 Protecting different types of documents

The IHE Document Sharing profiles, like MHDS, allow for many different
types of documents to be shared. These documents are likely to have
different levels of confidential information in them. For instance, one
document might contain the very basic health information that the
patient considers widely distributable. Another document might be made
up totally of information necessary for proper billing such as insurance
carrier and billing address. Yet another document might carry the
results of a very private procedure that the patient wishes to be
available only to direct care providers. This differentiation of the
types of data can be represented using a diagram like found in Table
50.5.3.2-1: Sample Access Control Policies.

**Table 1:50.5.3.2-1: Sample Access Control Policies**

| Confidentiality vs Role             | U | L | M | N | R | V |
| ----------------------------------- | - | - | - | - | - | - |
| Administrative Staff                |   | X | X |   |   |   |
| Dietary Staff                       |   |   | X |   |   |   |
| General Care Provider               |   |   | X | X |   |   |
| Direct Care Provider                |   |   | X | X | X | X |
| Emergency Care Provider (e.g., EMT) |   |   |   | X |   |   |
| Researcher                          | X |   |   |   |   |   |
| Patient or Legal Representative     |   | X | X | X | X |   |

Then documents can be labeled with one or more of the codes on the
columns, and results in the specified Functional Roles to be given
access to that type of document. In this way, the document sharing
metadata informs the Role-Based Access Control (RBAC) decisions through
self-describing sensitivity, known as confidentialityCode.

In the same way that the Document Sharing metadata ‘doctype’ defines
what the document is in terms of the clinical/administrative content,
the confidentialityCode defines what the document is in terms of
privacy/security content, sometimes referred to as sensitivity. The
confidentialityCodes should be looked at as a relatively static
assessment of the document content privacy/security characteristics.
Some documents are so sensitive in nature that they simply should not be
shared or published.

The rows are showing a set of functional roles. These roles would be
conveyed from the requesting organization through the use of the
Internet User Authorization ([IUA](https://profiles.ihe.net/ITI/IUA/index.html)) Profile. This profile defines how a
user and the security/privacy context of the request is defined.
Additional information can be carried such as the PurposeOfUse, what the
user intends to use the data for. Note that Privacy Policies and Access
Control rules can leverage any of the user context, patient identity, or
document metadata discussed above.

#### 1:50.5.3.3 Patient Privacy Consent to participate in Document Sharing

The topic of Patient Privacy Consent (Authorization) to collect, use,
and disclose is a complex topic. This complexity does not always need to
be exposed in full detail across a Document Sharing exchange. That is, a
request for information does need to consider the current status of any
Patient Privacy Consent that the patient has given, but most of the time
explaining the detail of this Privacy Consent to the requesting
system/individual adds no value. Most often the requesting
system/individual is either fully empowered to receive and use the
content, or not authorized at all. In these cases, the use of user
identity context, as discussed above around the [IUA](https://profiles.ihe.net/ITI/IUA/index.html) Profile, is
sufficient to make the Access Control decision. The trust relationship
of the Document Sharing exchange includes background governance on
appropriate use, as discussed above around the [ATNA](https://profiles.ihe.net/ITI/TF/Volume1/ch-9.html) Profile.

Privacy Consents may need to be expressed in a way that all parties in a
Document Exchange can understand. IHE has published 
the [Basic Patient Privacy Consents (BPPC)](https://profiles.ihe.net/ITI/TF/Volume1/ch-19.html) Profile 
that can be used to enable basic privacy
consent controls, and [Advanced Patient Privacy Consents (APPC)](https://profiles.ihe.net/ITI/TF/Volume1/ch-43.html) that can
encode more complex rules specific to a patient consent. The encoding of
Consent and advanced rules in FHIR “Consent” resource is possible but
has not yet been profiled by IHE.

Some examples of the type of policy that can be necessary for Patient
Privacy Consents are:

- Explicit Opt-In (patient elects to have some information shared) is required which enables document sharing
- Explicit Opt-Out (patient elects to not have information shared) stops all document sharing
- Implicit Opt-In allows for document sharing
- Explicit Opt-Out of sharing outside of use in local care events, but does allow emergency override
- Explicit Opt-Out of sharing outside of use in local care events, but without emergency override
- Explicit authorization captured that allows specific research project
- Change the consent policy (change from opt-in to opt-out)

The [BPPC](https://profiles.ihe.net/ITI/TF/Volume1/ch-19.html) Profile 
can be used as a gate-keeper to the document sharing
community. [BPPC](https://profiles.ihe.net/ITI/TF/Volume1/ch-19.html) 
does not define the policies but does allow for a
community that has defined its set of policies to capture that a patient
has chosen one or more of those policies.

For example: Let’s say that the above set of sample policy fragments was
available to a patient sharing in a community. The patient could agree
to Opt-In, and also agree to a specific research project. This set of
acknowledgments would be captured as one or 
more [BPPC](https://profiles.ihe.net/ITI/TF/Volume1/ch-19.html) documents. These
documents would indicate the policy that is being acknowledged, the date
it is being acknowledged, an expiration date if applicable, etc. Then
the systems involved in the document sharing can know that the patient
has acknowledged these policies and thus the patient’s choices can be
enforced. A system that is doing research can see that this patient has
acknowledged participation in the research project, while other patients
have not.

Let’s further examine what happens when the patient changes their
decision. For example, the patient is moving to a totally different
region that is not served by this community. The patient can acknowledge
the Opt-Out policy. This policy would then be registered as a
replacement for the previous Opt-In policies including the research
policy. Thus, now if that research application tries to access the
patient’s data, it will be blocked as the patient does not have a
current acknowledgement of the research policy.

#### 1:50.5.3.4 Security and Privacy in a Patient Safety Environment 

The IHE security and privacy model supports both centralized and
distributed control. The entities that are allowed to participate in
community-based document sharing need to be evaluated to assure that
they have the capability to enforce the policies they are expected to
enforce. This may mean that access control is enforced at the edge
systems, at the center, or more likely in both places.

In healthcare, beyond the basic security principles, we must
additionally be sensitive to patient care and safety. The applications
closest to the patient are best informed for determining the context of
the current situation. It is primarily at this level that emergency mode
can be handled in a robust way (often called break-glass).

The IHE security and privacy model is very careful to include security
while allowing for flexible and safe provision of healthcare by
individual participants.

### 1:50.5.4 IHE Security and Privacy Controls

The following is a breakdown of the security and privacy controls and in
what way the IHE profiles can help. The following table shows the set of
identified Controls (identified in above) as columns and the supportive
IHE Profiles as rows. In this table a ‘√’ indicates a direct
relationship. A direct relationship means that the Profile addresses the
security and/or privacy principle. An ‘.” indicates an indirect
relationship, meaning that the Profile assists with the principle.
Further details on the ‘√’ direct and ‘.’ Indirect relationships can be
found in the profile text or through other webinars.

**Table 1:50.5.4-1: Profiles relationship to Controls**

| Function vs Profile                  | Audit Log | Identification and Authentication | Data Access Control (Authorization) | Secrecy | Data Integrity | Non-Repudiation | Patient Privacy |
| ------------------------------------ | --------- | --------------------------------- | ----------------------------------- | ------- | -------------- | --------------- | --------------- |
| Audit Trails and Node Authentication | √         | √                                 | √                                   | √       | √              | √               | √               |
| Consistent Time                      | √         | ∙                                 |                                     |         |                | √               |                 |
| Internet User Authorization          |           | √                                 | √                                   |         |                | ∙               | ∙               |
| Cross-Enterprise User Assertion      |           | √                                 | ∙                                   |         |                | ∙               | ∙               |
| Basic Patient Privacy Consents       |           |                                   | ∙                                   |         |                |                 | √               |
| Mobile Care Services Discovery       |           | √                                 | ∙                                   |         |                | ∙               |                 |
| Document Digital Signature           |           | √                                 |                                     |         | √              | √               |                 |
| Document Encryption                  |           |                                   | √                                   | √       | ∙              |                 |                 |

## 1:50.6 MHDS Cross Profile Considerations

This section includes interactions between systems, with details at the
actor and transaction level:

1.  Overall Perspective from publication of documents to consumption of documents
2. Typical system that publishes documents
3. Typical system that consumes documents
4. Typical system that consumes data elements extracted from documents
5. Central Infrastructure supporting services

### 1:50.6.1 Interaction Diagram for the MHDS environment.

**Figure 1:50.6.1-1 shows a simplified view, where the following simplified components are defined:**

- “Publisher” – represents “System that publishes Documents”
- “Consumer” – represents “System that consumes Documents”
- “Patient” – represents actions the patient themselves might do, such  as seeking care
- “PatientDir” – represents the [PMIR Patient Identity Manager](https://profiles.ihe.net/ITI/TF/Volume1/ch-49.html) that is managing identity for the community
- “ConsentMgr” – represents the Consent Manager function within the [Document Registry](#150111-document-registry) when the Consent Manager Option is used
- “Registry” – represents the [MHDS Document Registry](#150111-document-registry) defined in this profile

The diagram has “Opt” groupings with actions of a

1. Patient Identity ([PMIR](https://profiles.ihe.net/ITI/TF/Volume1/ch-49.html) feed): representing new knowledge about the Patient at the source. Deeper details on this interaction can be found in the [PMIR](https://profiles.ihe.net/ITI/TF/Volume1/ch-49.html) Profile
  - This diagram does not show the [PMIR](https://profiles.ihe.net/ITI/TF/Volume1/ch-49.html) feed out to all the community participants, but this is enabled by [PMIR](https://profiles.ihe.net/ITI/TF/Volume1/ch-49.html), where all the community participants can subscribe to the [PMIR](https://profiles.ihe.net/ITI/TF/Volume1/ch-49.html) manager for feed.
2. Publication of new Documents to represent a case where new data need to be published.
  - The PDQm is used to get the golden patient identifier for use in the [Document Registry](#150111-document-registry).
3. The Provide transaction includes a List, DocumentReference, and the Binary resource containing the document. Get consent to disclose documents
  - There is no standard protocol, this functionality would be provided by the Consent Manager. It might by a User Interface or some undefined transaction. The consent must be legally obtained according to local regulations and user experience expectations.
4. Discover Patient Master Identity and data (MHD)
  - This portion starts with the patient visiting the Consumer. Thus there is a potential for a [PMIR](https://profiles.ihe.net/ITI/TF/Volume1/ch-49.html) feed updating the [PMIR](https://profiles.ihe.net/ITI/TF/Volume1/ch-49.html) manager. Not all visits will result in a feed.
  - Given that the Consumer wants to discover documents, it will first use PDQm to get the proper identity for the community. As indicated above other methods are available other than PDQm.
  - The Consumer must get a security token from the Consent Manager that is part of the [Document Registry](#150111-document-registry) using the Consent Manager Option
  - The Recipient queries the Registry to find appropriate entries, and selects the one of interest
  - The Recipient will GET the document given the DocumentReference.content.attachment.url

![](.//media/image12.png)

**Figure 1:50.6.1-1: FHIR MHDS Controlled Exchange (100% FHIR)**

[Source for WebSequence diagram above](.//media/MHDS_controlled_exchange.plantuml)


### 1:50.6.2 Typical Client System Designs

This section shows a typical client system design. This is informative
to help explain how these various actors interact.

The actors and transactions are not fully explained here, please see the
formal profiles referenced for details on the actual actor and
transaction functionality, responsibility, and interoperability.

Following the sections outline sample IHE Integration Statements for
systems of various functionality. For more details on the full use and
format of an IHE Integration Statement ([see Appendix F](https://profiles.ihe.net/GeneralIntro/ch-F.html)).

#### 1:50.6.2.1 System that publishes documents System Design

This system can publish documents using the [MHD Document Source](https://profiles.ihe.net/ITI/MHD/1331_actors_and_transactions.html#133111-document-source). The
other actors shown are there to support this primary function.

System that publishes documents - Integration Statement

<table>
<colgroup>
<col style="width: 18%" />
<col style="width: 37%" />
<col style="width: 44%" />
</colgroup>
<thead>
<tr class="header">
<th>Profiles Implemented</th>
<th>Actors Implemented</th>
<th>Options Implemented</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td>MHD</td>
<td>Document Source</td>
<td></td>
</tr>
<tr class="even">
<td>CT</td>
<td>Time Client</td>
<td></td>
</tr>
<tr class="odd">
<td>PMIR</td>
<td>Patient Identity Source</td>
<td></td>
</tr>
<tr class="even">
<td>PIXm</td>
<td>Patient Identity Consumer</td>
<td></td>
</tr>
<tr class="odd">
<td>PDQm</td>
<td>Patient Demographics Consumer</td>
<td></td>
</tr>
<tr class="even">
<td>SVCM</td>
<td>Terminology Consumer</td>
<td></td>
</tr>
<tr class="odd">
<td rowspan="2">ATNA</td>
<td rowspan="2">Secure Node</td>
<td>STX: TLS 1.2 Floor using BCP195 Option</td>
</tr>
<tr class="even">
<td>ATX: FHIR Feed Option</td>
</tr>
<tr class="odd">
<td>IUA</td>
<td>Authorization Client</td>
<td></td>
</tr>
<tr class="even">
<td>mCSD</td>
<td>Care Service Selective Consumer</td>
<td></td>
</tr>
<tr class="odd">
<td>NPFS</td>
<td>File Consumer</td>
<td></td>
</tr>
</tbody>
</table>


#### 1:50.6.2.2 System that consumes documents System Design

This system can consume documents using the [MHD](https://profiles.ihe.net/ITI/MHD/index.html) [Document Consumer](https://profiles.ihe.net/ITI/MHD/1331_actors_and_transactions.html#133112-document-consumer). The
other actors shown are there to support this primary function.

System that consumes documents - Integration Statement

<table>
<colgroup>
<col style="width: 18%" />
<col style="width: 48%" />
<col style="width: 33%" />
</colgroup>
<thead>
<tr class="header">
<th>Profiles Implemented</th>
<th>Actors Implemented</th>
<th>Options Implemented</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td>MHD</td>
<td>Document Consumer</td>
<td></td>
</tr>
<tr class="even">
<td>CT</td>
<td>Time Client</td>
<td></td>
</tr>
<tr class="odd">
<td rowspan="3">PMIR</td>
<td>Patient Identity Source</td>
<td></td>
</tr>
<tr class="even">
<td>Patient Identity Cross-Reference Consumer</td>
<td></td>
</tr>
<tr class="odd">
<td>Patient Demographics Consumer</td>
<td></td>
</tr>
<tr class="even">
<td>SVCM</td>
<td>Terminology Consumer</td>
<td></td>
</tr>
<tr class="odd">
<td rowspan="2">ATNA</td>
<td rowspan="2">Secure Node</td>
<td>STX: TLS 1.2 Floor using BCP195 Option</td>
</tr>
<tr class="even">
<td>ATX: FHIR Feed Option</td>
</tr>
<tr class="odd">
<td>IUA</td>
<td>Authorization Client</td>
<td></td>
</tr>
<tr class="even">
<td>mCSD</td>
<td>Care Service Selective Consumer</td>
<td></td>
</tr>
<tr class="odd">
<td>NPFS</td>
<td>File Consumer</td>
<td></td>
</tr>
</tbody>
</table>


#### 1:50.6.2.3 System that consumes clinical data elements Systems Design

This system can consume data elements using the [QEDm](https://www.ihe.net/uploadedFiles/Documents/PCC/IHE_PCC_Suppl_QEDm.pdf) Profile that have
been extracted from the documents published in the MHDS by way of the
[mXDE](https://profiles.ihe.net/ITI/TF/Volume1/ch-45.html) Profile. The other actors shown are there to support this primary
function. Further details can be found in the referenced profiles.

System that consumes clinical data elements - Integration Statement

<table>
<colgroup>
<col style="width: 17%" />
<col style="width: 37%" />
<col style="width: 45%" />
</colgroup>
<thead>
<tr class="header">
<th>Profiles Implemented</th>
<th>Actors Implemented</th>
<th>Options Implemented</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td>QEDm</td>
<td>Clinical Data Consumer</td>
<td></td>
</tr>
<tr class="even">
<td>MHD</td>
<td>Document Consumer</td>
<td></td>
</tr>
<tr class="odd">
<td>CT</td>
<td>Time Client</td>
<td></td>
</tr>
<tr class="even">
<td rowspan="3">PMIR</td>
<td>Patient Identity Source</td>
<td></td>
</tr>
<tr class="odd">
<td>Patient Identity Cross-Reference Consumer</td>
<td></td>
</tr>
<tr class="even">
<td>Patient Demographics Consumer</td>
<td></td>
</tr>
<tr class="odd">
<td>SVCM</td>
<td>Consumer</td>
<td></td>
</tr>
<tr class="even">
<td rowspan="2">ATNA</td>
<td rowspan="2">Secure Node</td>
<td>STX: TLS 1.2 Floor using BCP195 Option</td>
</tr>
<tr class="odd">
<td>ATX: FHIR Feed Option</td>
</tr>
<tr class="even">
<td>IUA</td>
<td>Authorization Client</td>
<td></td>
</tr>
<tr class="odd">
<td>mCSD</td>
<td>Care Service Selective Consumer</td>
<td></td>
</tr>
<tr class="even">
<td>NPFS</td>
<td>File Consumer</td>
<td></td>
</tr>
</tbody>
</table>

#### 1:50.6.2.4 Central Infrastructure as a single system

This is a system that contains all of the Central Infrastructure defined
in MHDS as supporting services. These actors do not need to be combined
into one system. This combined system is provided for informational
purposes.

Central Infrastructure Integration Statement


<table>
<colgroup>
<col style="width: 17%" />
<col style="width: 33%" />
<col style="width: 49%" />
</colgroup>
<thead>
<tr class="header">
<th>Profiles Implemented</th>
<th>Actors Implemented</th>
<th>Options Implemented</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td rowspan="4">MHDS</td>
<td rowspan="4">Document Registry</td>
<td>Authorization Option</td>
</tr>
<tr class="even">
<td>Consent Manager Option</td>
</tr>
<tr class="odd">
<td>UnContained Option</td>
</tr>
<tr class="even">
<td>SVCM Validation Option</td>
</tr>
<tr class="odd">
<td>MHD</td>
<td>Document Responder</td>
<td></td>
</tr>
<tr class="even">
<td>MHD</td>
<td>Document Recipient</td>
<td></td>
</tr>
<tr class="odd">
<td>PMIR</td>
<td>Patient Identity Consumer</td>
<td></td>
</tr>
<tr class="even">
<td>CT</td>
<td>Time Client</td>
<td></td>
</tr>
<tr class="odd">
<td rowspan="2">SVCM</td>
<td>Terminology Consumer</td>
<td></td>
</tr>
<tr class="even">
<td>Terminology Repository</td>
<td></td>
</tr>
<tr class="odd">
<td rowspan="2">IUA</td>
<td>Resource Server</td>
<td></td>
</tr>
<tr class="even">
<td>Authorization Server</td>
<td></td>
</tr>
<tr class="odd">
<td rowspan="4">ATNA</td>
<td rowspan="4">Secure Node</td>
<td>STX: TLS 1.0 Floor with AES Option</td>
</tr>
<tr class="even">
<td>STX: TLS 1.0 Floor using BCP195 Option</td>
</tr>
<tr class="odd">
<td>STX: TLS 1.2 Floor using BCP195 Option</td>
</tr>
<tr class="even">
<td>ATX: FHIR Feed Option</td>
</tr>
<tr class="odd">
<td>BPPC</td>
<td>Content Consumer</td>
<td></td>
</tr>
<tr class="even">
<td>CT</td>
<td>Time Server</td>
<td></td>
</tr>
<tr class="odd">
<td>PMIR</td>
<td>Patient Identity Manager</td>
<td></td>
</tr>
<tr class="even">
<td rowspan="4">ATNA</td>
<td rowspan="4">Audit Record Repository</td>
<td>STX: TLS 1.0 Floor with AES Option</td>
</tr>
<tr class="odd">
<td>STX: TLS 1.0 Floor using BCP195 Option</td>
</tr>
<tr class="even">
<td>STX: TLS 1.2 Floor using BCP195 Option</td>
</tr>
<tr class="odd">
<td>ATX: FHIR Feed Option</td>
</tr>
<tr class="even">
<td rowspan="2">IUA</td>
<td>Authorization Server</td>
<td></td>
</tr>
<tr class="odd">
<td>Resource Server</td>
<td></td>
</tr>
<tr class="even">
<td>mCSD</td>
<td>Care Service Selective Supplier</td>
<td></td>
</tr>
<tr class="odd">
<td>NPFS</td>
<td>File Server</td>
<td></td>
</tr>
<tr class="even">
<td>mXDE</td>
<td>Data Element Extractor</td>
<td></td>
</tr>
<tr class="odd">
<td>QEDm</td>
<td>Clinical Data Source</td>
<td></td>
</tr>
</tbody>
</table>
