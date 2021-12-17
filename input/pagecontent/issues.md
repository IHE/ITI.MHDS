### Changes since 2.1

The version 2.2.0 is intended to be changes to the publication mechanism from WORD/PDF to an Implementation Guide published using the IG-Publisher. However some other changes have been necessary due to the passing of time.
- Mentions of DocumentManifest are now List.source due to the change in MHD.
- Mentions of the PMIR Patient Identity Manager are changed to Patient Identity Registry due to change in PMIR.


#### Open Issues

- now that IUA has defined OAuth scopes differently than SMART, MHDS needs to adjust. Should it switch to IUA, or show both? Not clear to me that the PurposeOfUse mechanism discussed here is consistent with SMART v2.0 published spec.


#### Closed Issues

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
    Patient Identity Registry. This is defined in the “UnContained
    Reference Option”. The necessary change to MHD has not been done yet
    in order to get feedback from Public Comment. CP-ITI-1200 has
    updated. MHD to add an UnContained Reference Option for this support

7.  Removed section 50.7 as the current HIE-Whitepaper contains MHD now.
