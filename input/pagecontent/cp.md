Balloted Changes for IHE ITI TF [CP-ITI-1321-02](https://docs.google.com/document/d/1_akpDRB5dXZands28SUM7suXdTGaCBwQ/edit?tab=t.0#heading=h.5t0km02n25aj), see also [PR](https://github.com/IHE/publications/pull/575/commits/5af691e7f8c7c91e51ceb2971e88da85f1783314)


*Update Section 18.2.3 Grouping Rules by the following:*

**18.2.3 Grouping Rules**

Grouping with a Document Consumer is used in situations where an Initiating Gateway and/or Responding Gateway are supporting an XDS Affinity Domain.

When an Initiating Gateway is supporting an XDS Affinity Domain, it can choose to query and retrieve from local actors in addition to remote communities. This is accomplished by grouping the Initiating Gateway with a Document Consumer Actor. This grouping allows Document Consumers such as EHR/PHR/etc. systems to query the Initiating Gateway to retrieve document information and content from both the local XDS Affinity Domain as well as remote communities. For details see Section 18.2.3.1. An Initiating Gateway that is not grouped with a Document Consumer is only able to return results from remote communities, so local EHR/PHR/etc. systems (Document Consumer Actors) must direct separate query and document retrieve transactions internally and externally.

When a Responding Gateway is supporting an XDS Affinity Domain, it may resolve Cross Gateway Query and Cross Gateway Retrieve Transactions by grouping with a Document Consumer and using the Registry Stored Query and Retrieve Document Set transactions. For details see Section 18.2.3.2

**Grouping with a MHD Document Consumer is used in situations where a Responding Gateway belongs to a community with an MHD Document Responder.**

**When a Responding Gateway belongs to an MHDS community, it may resolve Cross Gateway Query and Cross Gateway Retrieve transactions by grouping with an MHD Document Consumer and using the Find Document Lists, Find Document References and Retrieve Document transactions. For details see Section 18.2.3.3**

**A Responding Gateway MAY use non-IHE interactions to collect local information in response to a Cross Gateway Query or Cross Gateway Retrieve. These proprietary interactions are not further described within any IHE profile.**

*Update  Section 18.2.3.2 Responding Gateway grouped with XDS Document Consumer with the following:*

**18.2.3.2 Responding Gateway grouped with XDS Document Consumer**

Responding Gateways that are grouped with a Document Consumer:

* shall initiate a Registry Stored Query \[ITI-18\] transaction to a local Document Registry to query local information in response to a received Cross Gateway Query \[ITI-38\]. The Document Registry response must be augmented with the homeCommunityId of the Responding Gateway’s community prior to returning in the response to the Cross Gateway Query.  
* shall initiate a Retrieve Document Set \[ITI-43\] transaction to a local Document Repository to retrieve local information in response to a Cross Gateway Retrieve \[ITI-39\].

**~~When a Responding Gateway is not grouped with a Document Consumer it is expected to be using non-IHE specified interactions to collect local information in response to a Cross Gateway Query or Cross Gateway Retrieve. These proprietary interactions are not further described within any IHE profile.~~**

*Add  Section 18.2.3.3 Responding Gateway grouped with MHD Document Consumer with the following:*

**18.2.3.3 Responding Gateway grouped with MHD Document Consumer**

**Responding Gateways that are grouped with an MHD Document Consumer:**

* **shall initiate a [Find Document Lists \[ITI-66\]](https://profiles.ihe.net/ITI/MHD/ITI-66.html#2-3-66-find-document-lists-iti-66) or [Find Document References \[ITI-67\]](https://profiles.ihe.net/ITI/MHD/ITI-67.html#2-3-67-find-document-references-iti-67) transaction to a local MHD Document Responder to query local information in response to a received Cross Gateway Query \[ITI-38\] according to Table 18.2.3.3-1**  
* **shall initiate a [Retrieve Document \[ITI-68\]](https://profiles.ihe.net/ITI/MHD/ITI-68.html#2-3-68-retrieve-document-iti-68) transaction to a local MHD Document Responder to retrieve local information in response to a Cross Gateway Retrieve \[ITI-39\]**   
* **in some cases, it will be necessary to invoke the MHD Document Consumer multiple times and combine multiple response messages to form the response**

**Table 18.2.3.3-1: XDS query mapping to MHD transactions**

| XDS Query | MHD Transaction |
| ----- | ----- |
| **FindDocuments** | **Find Document References** |
| **FindSubmissionSets** | **Find Document Lists** |
| **FindFolders** | **Find Document Lists** |
| **GetAll** | **Find Document References Find Document Lists** |
| **GetDocuments** | **Find Document References** |
| **GetFolders** | **Find Document Lists** |
| **GetAssociations** | **Find Document References Find Document Lists** |
| **GetDocumentsAndAssociations** | **Find Document References** |
| **GetSubmissionSets** | **Find Document Lists** |
| **GetSubmissionSetAndContents** | **Find Document References Find Document Lists** |
| **GetFolderAndContents** | **Find Document References Find Document Lists** |
| **GetFoldersForDocument** | **Find Document Lists** |
| **GetRelatedDocuments** | **Find Document References** |
| **FindDocumentsByReferenceId** | **Find Document References** |

<div id="f18.2.3.3-1">
<img src="Figure_18.2.3.3-1.png" alt="" />
<p class="figureTitle">Figure 18.2.3.3-1: Responding Gateway grouped with MHD Document Consumer</p>
</div>    

*Update Section 27.2 XCPD Actor Options with the following:*

**27.2 XCPD Actor Options**  
Options that may be selected for this Integration Profile are listed in Table 27.2-1 along with the actors to which they apply. Dependencies between options when applicable are specified in notes.

Table 27.2-1: XCPD \- Actors and Options

| Actor | Options | Vol. & Section |
| ----- | ----- | ----- |
| Initiating Gateway | Asynchronous Web Services Exchange | ITI TF-1: 27.2.1 |
|  | Deferred Response | ITI TF-1: 27.2.2 |
| Responding Gateway | Deferred Response | ITI TF-1: 27.2.2 |
|  | **MHDS Federation Option** | **ITI TF-1: 27.2.3** |

*Add  Section 27.2.3 MHDS Federation Option with the following:*

### **27.2.3 MHDS Federation Option**

**Grouping with a Patient Demographics Consumer is used in situations where a Responding Gateway belongs to a MHDS community which defines document sharing using the MHD Profile.**

**When a Responding Gateway belongs to an MHDS community, it may resolve Cross Gateway Patient Discovery transactions by grouping with a Patient Demographics Consumer implementing either the [Match Operation Option](https://profiles.ihe.net/ITI/PDQm/volume-1.html#13822-match-operation-option) and using the [Patient Demographics Match \[ITI-119\]](https://profiles.ihe.net/ITI/PDQm/ITI-119.html#2-3-119-patient-demographics-match-iti-119) transaction or implementing the [Patient Search Option](https://profiles.ihe.net/ITI/PDQm/volume-1.html#13821-patient-search-option) and using the [Mobile Patient Demographics Query \[ITI-78\]](https://profiles.ihe.net/ITI/PDQm/ITI-78.html#2-3-78-mobile-patient-demographics-query-iti-78) transaction.**

**When a Responding Gateway is not grouped with a Patient Demographics Consumer it is expected to be using non-IHE specified interactions to collect local information in response to a Cross Gateway Patient Discovery. These proprietary interactions are not further described within any IHE profile.**  

<div id="f27.2.3-1">
<img src="Figure_27.2.3-1.png" alt="" />
<p class="figureTitle">Figure 27.2.3-1: Responding Gateway grouped with Patient Demographics Consumer</p>
</div>    