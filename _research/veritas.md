---
layout: detailed-page
title: VERITAS Astrophysics Research
description: "Highlights of my work with Dr. Jodi Christiansen at Cal Poly"
slug: veritas
tags: [physics, linux, c++, cal-poly]
time: "Fall 2023 - Present"
order: 1
---

<div class="wrapper">
  <div class="image-background" id="gravity-simulator-background">
    <img class="project-img" src="https://veritas.sao.arizona.edu/images/stories/veritas_and_building.jpg" alt="The 4-telescope array of VERITAS">
    <div class="caption">
        <p>The 4-telescope array of VERITAS in Tuscan, AZ. <a href="https://veritas.sao.arizona.edu/">Source</a></p>
    </div>
  </div>
</div>

I started working in Dr. Jodi Christiansen's lab at the beginning of my third year at Cal Poly. I am really interested in a physics-based career path, so this was an amazing opportunity to get involved with undergraduate research work. 

Our group is a part of the research collaboration that analyzes data from the [VERITAS Telescope](https://veritas.sao.arizona.edu/), specifically the spectra of blazars and other high energy extragalactic sources.

When I first started most of my time was spent getting comfortable with the linux terminal and learning the physics behind gamma-ray astronomy. My main task during the year was to use our computing system to analyze 3 potential blazars. There are multiple stages of the computational analysis that need to be performed, which required a very organized directory system and documentation method in order to not mess up. Each analysis gave a spectrum and a sky map that allowed us to determine the significance of each source. As more data was collected and our analysis parameters were optimized, we could see the improvements both visually and quantitatively. In May 2024, the 5 other students in our group and I presented our findings in a poster at the [Bailey College Student Research Conference](https://cosam.calpoly.edu/conference).

Towards the end of the year, I started on a new project to improve the fit seeding algorithm. We use Markov-Chain Monte-Carlo to fit our experimental telescope data to simulated results. Since this method uses walkers to find the optimal solution, a bad starting guess could cause the algorithm to get stuck in a local minimum. Currently we use Hillas parameters to generate the starting parameters, but this this doesn't work very well when the pool of light doesn't completely intersect the camera. The goal of my project is to test if we can generate starting parameters based on their likelihood to measure light at the brightest camera pixels.

I've learned lot just in the past year, both from the physics side and the research side. We use concepts including synchrotron self-Compton, Cherenkov radition, doppler effect, and other optical and astronomical phenomena to interpret our results. On the research side, I've used a linux terminal, performed fits on my spectra in MATLAB, and created a research poster, among other things.

