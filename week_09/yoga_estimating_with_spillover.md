# Do Some Short Yoga! 

Head over to this [EGAP](https://egap.shinyapps.io/spillover-app/) hosted demonstration of the reading that we do in the book about geographic spillovers. This is a small tool that will let you reason about how spillover between units affect what you estimate from a model. :sweat_smile:

The code to build and run this server is also stored in the datahub, in the `week_9` folder. Specifically, these files are stored in the subdirectory called `./week_09/estimating_with_spillover`. To run this either on the datahub or locally, open `server.R` in Rstudio and click the button to "Run App" in the upper right of the code editor. 

Note a few things about this demo: 

1. The data is created under the working idea that units within 5km *actually* get spilled over.
2. You get to set the size of the *direct* effect and the *indirect* effect. 
3. Then, the estimator is going to produce an estimate based *only* on the treatment status that is *assumed* by your substantive model. For example, if you set the toggle for the "spillover radius" to be 5km, your model is going to set whether you score a particular observation in one of the groups that is: {control, no spillover; control, spillover; treatment, no spillover; treatment, spillover}.

Set the following parameters to begin with: Set the *direct effect* to be 5, the *indirect effect* to be 0 and the *spillover radius* to be 5. 

For each of the following scenarios, consider the **True** and **Estimated** treatment effects. Why or why not, was the estimate biased? 

1. At the baseline settings, what do you estimate? Is this estimate biased or accurate? Why or why not? 
2. Now, set the `Spillover Radious` to be 3. This means, that although the spillover *actually* occuring up to 5 km, your model is making the substantive assumption that it only extends for 3km. What do you estimate? Why? 
3. Before you change anything: what do you think would happen if you were to set the indirect effect to be 2 while keeping other options constant. Write this down, or say it aloud. Then, actually change the setting and observe if your prediction was correct. 
4. If you expand the radius from 3 to 7, what will happen to your estimates, all else kept equal. Say it aloud! Then, make the change and see if what you learned was borne out. 
