### Description of the code

This is a very simple shiny app created to accompany a manuscript, consisting mainly of several tables that can be downloaded using different filtering criteria (See README file for more info).

### Code review objectives

#### General:

Please check that you can run the shiny app with the instructions provided in the README file and that you are able to visualize and download the tables and figures

#### Specific: 

* Is this the best shiny approach to render tables and create filters? Is there a better / simpler way to do this? 
* There are frequent data releases (2-3 per  year) so the input files (that depend on another piece of code but entirely on files that can be found in a public  FTP repository) will change accordingly. Any suggestions on how to automate this process are more than welcome. Should this be done inside the shiny app code?
* I reckon the manual input data for the figure may not the best option - particulary if the objective is to create an app that can be used for every data release. This summary data could be easily be computed from some of the input files. Feedback on how best to address this would be highly appreciated.

