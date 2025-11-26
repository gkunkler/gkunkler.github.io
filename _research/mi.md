---
layout: detailed-page
title: KTH Medical Imaging
description: "Description of my work with Dr. Mats Persson at KTH"
slug: mi
tags: [physics, linux, C++, kth]
time: "Fall 2024 - Spring 2025"
order: 2
---

Shortly after I arrived in Stockholm, Sweden for my exchange year at KTH, I started working with Dr. Mats Persson. The [research group](https://www.mi.physics.kth.se/web/home.htm), led by Dr. Mats Danielson, works on developing x-ray detectors for CT scanners. My project began as an exploratory study with a wide scope until I narrowed down and focused on the development of a module for the [Allpix Squared](https://allpix-squared.docs.cern.ch/) simulation framework. The other aspects became Bachelor's theses for some other students, with whom I collaborated extensively.

My goal was to integrate Coulomb repulsion into the Monte-Carlo simulations in Allpix. This bridges the gap between the fast independent charge carrier simulations and the intensive TCAD electric field simulations that can take many days to run. I needed to do a complete overhaul of the existing propagation module to allow for synchronous charge positions. Once I completed this milestone, I was able to add a component to the electric field corresponding to the mirror charge solution to the electric field in a capacitor.

In order to prepare my code for integration into the open-source project, I needed to be a lot more rigourous with my git usage and documentation. Currently, the project exists as a pull request on the Github repository. It has also been used by grad students in our group for their simulations. In April 2024, I got the chance to fly out to Amsterdam for the annual Allpix Squared workshop. Alongside Rickard Brunskog, a PhD student who has become the main user of my module, I presented my work to many collaborators, developers, and users of the Allpix framework ([link to our slides](https://indico.cern.ch/event/1489052/contributions/6483379/)). It was an amazing opportunity to talk with other working in high energy detector design and the friendly community has played a part in convincing me that graduate school is where I want to be after I finish my Bachelor's from Cal Poly.

