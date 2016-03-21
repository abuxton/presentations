autoscale: true 
footer: @digitaladept [http://abuxton.github.io]
slidenumbers: true

---
#Chicken or The Eggs!
![cote fit original](_images/cote-orson-jimdavis.png)


---
# Introductions first! 

A need to support my coffee addiction has taken me around the world working with and supporting all manner of development teams. The same addiction has supported me through long days and nights of platform integrations, fire fighting and launch management for various development teams in startups, gaming, finance and most fields of enterprise.

Feel free to buy me a coffee and ask my opinion on anything technology, devops, or system architecture and  configuration management.

![right fit](../_shared/_images/me_fire_cmoss_e42014.jpg)


---
# Chicken and Eggs in tech! #
## Getting started with configuration management##

* Where do you start?
* What comes first?
* What is the best approach to adoption? 
* What if I tell you there is no single answer?

---
#Where do you start?

---
# Problems #
## Do we always have them? ##

* What problems does configuration management solve?
* What tools does it configuration management give you to help?
* What if you don't have any problems right now?

^Problems
* Auditing - Facter for infrastructure, PuppetDB for auditing estate,  report handlers for code application
* Reporting - Report handlers
* monitoring - console, and report features

^Tools
* Tools deployment - Facter, puppet lib, 
* Tooling - Puppet resource
* Facter
* command & control - MCollective

---
# Solutions #
## What are some solutions or things we all need! ##

Puppet has its own "Chicken and Eggs"! But what do we normally want, what are our eggs . 

* Tooling - Tools to make life easier.
* Auditing - We all need to know things about our infrastructure.
* Reporting and logging - We should all have visibility of whats happening.
* Inventory discovery - We all carry tool kits that let us see information about our estate.
* Management - Its not much of a configuration management talk otherwise!

---
# Puppets Tool Set #

Puppet comes with solutions for some of the things! I'm going to talk about them in the order you normally encounter them.

* Facter - infrastructure auditing, expandable tooling.
* Puppet - Puppet or the Puppet Labs Domain Specific Language (DSL) and Resource Abstraction Layer (RAL), Tools for inventory and management at the command line and in code.
* MCollective - Management, orchestration or command and control. Ability to provide simple reporting and exposure for auditing from Facter.
* Console Service & ENC - Exposes the data you do have, shows you reports and log information.
* PuppetAPI' - The Puppet API or PuppetDB directly allows you to see all the data exposed.
* Hiera. Data abstraction and data lookup tooling.

---
# Adoption, use all the things!

---

![whatif.xkcd original fit](_images/whatif-logo-xkcd.png)

^What if I told you a configuration management tool does not have to be used for management? or even configuration.

---
# Installation #
## Well it is the obvious place to start! ##

Lets be honest this is the easiest thing to over come, no one in the software space is making it had to install their software anymore!

---
# Puppet Open Source Solution #

Well  'Free' as in you  don't pay to use it, but like everything there is still an investment.
* Recent changes to all-in-one installer. 
* POSS now uses same file structure as PE.
* You loose some of the tools, but not all of them.
* Community modules and work make up for a lot of the gaps. 

---

# Master less #
## OK I'm stealing all your questions! ##

It's O.K, you just lose some of the tools, but not all of them.  

---
# Domain Specific Language (DSL) #
## One 'syntax' to rule them all! ##

* No I do not mean only the Puppet DSL.
* No I'm not about to say go use Ruby. But I am going to mention Ruby. 
* I am going to tell you its good to make a choice.

---
# Facter #
## Fact(er), not Fact(or)! Yeah we've all done that! ##

If you just installed Facter with or without Puppet what would you gain?
* Unified deployment for scripts!
* Unified inventory mechanism!
* Dependable execution path!

With Puppet You even get a deployment mechanism! 

---
# Puppet RAL #
## Resource abstraction for fun and profit! ##

What is the Puppet RAL worth to you?  Even if you don't configure with Puppet!
* Command line tool with execution.
* Inventory and simplified work flow?
* Platform abstraction for scripting!
* Extensible, contains logging, reporting and supports remote execution?

---
# Puppets Database and APIS #
## Let's not talk SQL! ##

The presence of the Puppet deployment of PostgreSQL and the PuppetDB, Combined with the Puppet API gives you unrivaled integration.
* Central point for querying Facter, and resources should you choose.
* Central point to be able to expose this data to custom tools.
Now we even have the [Puppet Query Language*](https://docs.puppetlabs.com/puppetdb/master/api/query/v4/pql.html)

---
# MCollective #
## Pulling strings with Puppet! ##

MCollective, Puppet enterprise takes the hard work out of deploying MCollective and with coming releases we will expose more of the GUI for driving Orchestration from the console.
---
#Reporting

Puppet reports everything, you decide where to and how.

---
#Auditing
##Puppet can Audit, but it's often abused and misused. 

* Audit distinct resources, 
* Understand it audits every time it runs.
* Understand the different over heads for the different audit mechanisms.

---
# There is no Spoon! #
## See, I said it. ##
Puppet Enterprise is a toolbox. Use it as you would any other tool. **The way that works best for you**.
* Read the manual, [docs.puppetlabs.com](http://docs.puppetlabs.com) .
* Watch the user created videos.
* Try use what some one else did before you. [forge.puppetlabs.com](http://forge.puppetlabs.com)
* See how far you get using it the way we recommend.
* Don't be afraid to try doing it another way.

---
#Q&A
##Thats all folk, Thank you!

Its either time for some one else to bore you to sleep, or time to go to the bar!



---
#Credits


#### Images

* whatif.xkcd.com
* http://garfield.com/jim-davis
* https://octodex.github.com/images/hubot.jpg
* [http://charlottemoss.co.uk](http://charlottemoss.co.uk)

####Referance

 [https://github.com/philsturgeon/dbad/blob/master/LICENSE-en.md](target="_blank">https://github.com/philsturgeon/dbad/blob/master    /LICENSE-en.md)
