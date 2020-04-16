# Coding in Class, Using Data Hub and R Studio

Throughout the semester, we're going to insert breaks in the lecture action to get you involved in programming. There are two types of activity we will ask you do to: (1) Coding Yoga; and, (2) Coding Workouts.

1. **Yoga** is going to be *mellow*, highly guided sessions where we will be showing you things, in code, that we have just been talking about in the async lectures. We want to get you thinking about the code structures that we're using, and this is the most effective way. 
2. **Hikes** are less structured than *yoga*. In a *hike*  your work is going to be self-guided. We will be providing data & context, some boilerplate, and a target to shoot for, but just how you get there will be up to you.

(I mean, you signed up for some Berkeley, right?) 

Not all weeks will have a code *hike* in them, but when we do, there will be only one per week, and it will be the last activity for the week. We will always let you know which you're working on, so you can set your expectations for time (and coffee) appropriately.

# The Berkeley DataHub 
The first time that you start a datahub server, the server pulling is going to pull materials from a GitHub repository and do a little housecleaning. After the first time, it will only pull differences. This means that the server should start, in general, in 30 seconds or less.

For *in async* code demonstrations, we're going to use the UC Berkeley datahub. This is a lightweight compute system with a jupyter server and Rstudio server. You've got general access to this compute using your @berkeley.edu credentials. Don't get distracted by the link right now: but, this jupyter hub is housed at [datahub.berkeley.edu](https://datahub.berkeley.edu). If you're interested, you can read more about this compute system [here](https://jupyterhub.readthedocs.io/en/stable/).

## Two Methods of Setting this Up 

There are two different ways that you can set up the datahub. I think that _at present_, I would suggest that you follow the second of these. However, throughout the semester, you will always have the option of using either. 

1. Pull from the master repo every time that you launch the datahub. This will issue a git pull with every link, and will ensure that you always have the most up to date content from the master branch. However, this comes with the drawback that getting your work _off_ of the datahub is a little bit more cumbersome. These links will use the `nbgitpuller` tool to pull every time, and the links will read like:  `http://datahub.berkeley.edu/hub/user-redirect/git-pull?repo=https://github.com/UCB-MIDS/w241&branch=master&urlpath=rstudio`

2. (Preferred) Set your upstream to be a fork of the core content for the course. This way, you will always have access to content that you have created on your own fork. If you do good work, issue a PR and I'll merge it onto the master for the class! 

To accomplish this: 

- Navigate to the course GitHub: https://github.prod.oc.2u.com/UCB-MIDS/w241 and Fork the repository onto your own namespace. Note that this exists inside the MIDS GitHub enterprise, so this is *not* the general open GitHub
- Go to https://datahub.berkeley.edu/user/USERNAME/rstudio/
- In the datahub Rstudio environment, navigate to the shell: `Tools > Shell` 
- Issue a call to clone the repository from your fork: 

```
git clone https://github.prod.oc.2u.com/USERNAME/w241
``` 

- Where `USERNAME` is replaced with your actual username. This should prompt you for a user + password set of credentials. Note that these credentials are for the MIDS enterprise account, **not** for the public GitHub. This is a point of confusion for students every semester -- although they use the same technology (GitHub) they are *totally* separate and use unique credentials. 
- You should now be able to push and pull from your fork of the repo to the datahub. 

# Do Some Short Yoga! 

Head to the datahub to work on an exercise. 

- If you want to pull all new changes from the master repo into the datahub, follow this [link](http://datahub.berkeley.edu/hub/user-redirect/git-pull?repo=https://github.com/UCB-MIDS/w241&branch=master&urlpath=rstudio)
- If you have set up your datahub to work off a fork that you are managing, instead follow this [link](https://datahub.berkeley.edu/user/USERNAME/rstudio/). 


Once you are on the datahub,  navigate to `week_01>reintroduction_to_r.Rmd` to work on an exercise.
