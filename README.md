# tls-oldversions-deprecate

A draft to deprecate tlsv1.0 and tlsv1.1 initiated by Kathleen Moriarty,
assisted by sftcd, now adopted by the TLS WG.

The latest WG draft is [here](https://tools.ietf.org/html/draft-ietf-tls-oldversions-deprecate).

Please submit any PRs on the 
[XML file](https://github.com/tlswg/oldversions-deprecate/blob/master/draft-ietf-tls-oldversions-deprecate.xml)
- we're still using xml2rfc for this with the XML file as the source.

The last pre-WG version was
[draft-moriarty-tls-oldversions-diediedie-01.txt](https://tools.ietf.org/html/draft-moriarty-tls-oldversions-diediedie-01)
and was in [this repo](https://github.com/sftcd/tls-oldversions-diediedie).

Additionally:

- A presentation on this from [IETF-103](https://datatracker.ietf.org/meeting/103/materials/slides-103-tls-sessa-ietf-103-deprecate-old-tls-versions-00)
- A [script](./nonobsnorms.sh) to retrieve the set of RFCs that normatively refer
  to TLS1.0 or TLS1.1 (93 exist) and that are not obsoleted (76 exist). The
  output of that is [here](./nonobsnorms.out).

# IETF Note Well

This repository relates to activities in the Internet Engineering Task
Force(IETF). All material in this repository is considered Contributions to the
IETF Standards Process, as defined in the intellectual property policies of
IETF currently designated as BCP 78 (https://www.rfc-editor.org/info/bcp78),
BCP 79 (https://www.rfc-editor.org/info/bcp79) and the IETF Trust Legal
Provisions (TLP) Relating to IETF Documents
(http://trustee.ietf.org/trust-legal-provisions.html).

Any edit, commit, pull request, issue, comment or other change made to this
repository constitutes Contributions to the IETF Standards Process
(https://www.ietf.org/).

You agree to comply with all applicable IETF policies and procedures,
including, BCP 78, 79, the TLP, and the TLP rules regarding code components
(e.g. being subject to a Simplified BSD License) in Contributions.
