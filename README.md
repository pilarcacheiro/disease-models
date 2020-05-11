### Models for human disease from the International Mouse Phenotyping Consortium
Shiny app displaying the IMPC disease models correspondig to the latest data release [[DR11.0, Februray 2020]](https://www.mousephenotype.org/data/release). The description of the pipeline and data sources can be found in our recent review pubished in *Mammalian Genome* [[Cacheiro et al., 2019]](https://link.springer.com/article/10.1007/s00335-019-09804-5), which includes models from a previous data release [[DR10.0, March 2019]](https://www.mousephenotype.org/data/previous-releases/10.0).

### How to launch the app
Run the app locally:

```
if (!require('shiny')) install.packages("shiny")
library(shiny)
shiny::runGitHub("disease-models", "pilarcacheiro")
```

Or clone or download this repository and run:
```
shiny::runApp("disease-models")
```

The following addtional packages are required:
```
if (!require('DT')) install.packages('DT')
if (!require('networkD3')) install.packages('networkD3')
if (!require('tidyverse')) install.packages('tidyverse')
```
### Mouse models disease table
These tables contain information on all the IMPC mouse models for a given gene, the human orthologues and the associated disorders along with the phenotypic similarity between each mouse model and the disease as computed by the PhenoDigm algorithm . PhenoDigm relies on the availability of mouse phenotypes encoded as Mammalian Phenotype Ontology (MP) terms and human disease phenotypes encoded as Human Phenotype Ontology (HPO) terms.
A PhenoDigm score = 0 means that there are no phenotypes in common between the mouse model and the disease.
Methods and data sources available in [[Cacheiro et al., 2019]](https://link.springer.com/article/10.1007/s00335-019-09804-5)

### Gene summary table
These tables contain summary information at the gene level: disease associated genes for which an IMPC mouse models exists and whether the mouse models is able to mimic the disease phenotypes of any of the human orthologues.
An additional 116  mouse genes with IMPC mouse models showing significant phenotypes and asociated to Mendelian disorders as in OMIM and ORPHANET not included in the previous set of tables are shown here. For these genes, the associated disease phentoypes are not yet encoded as HPO phenotypes so PhenoDigm similarity scores cannot be computed.





