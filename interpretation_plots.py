#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Thu Nov  4 23:21:37 2021

@author: javierortiz
"""

# importing the modules
from bokeh.plotting import figure, output_file, show
  
# file to save the model
output_file("interpretation_plot.html")
      
# instantiating the figure object
graph = figure(title = "Papers with 'p value/effect sizes interpretation' in the title or abstract.")
  
# y-coordinates to be plotted
y = [2000, 2001, 2002,2003,2004,2005, 2006,2007,2008,2009,2010,2011,2012,2013,2014,2015,2016,2017,2018,2019,2020,2021]
y_lab = [str(i) for i in y]

# x-coordinates of the right edges
right = [10,12,10,10,25,20,33,30,42,41,56,68,65,101,97,102,102,115,126,142,177,193]  

# width / thickness of the bars 
width = 0.5
  
# plotting the graph
for index, value in enumerate(right):
    graph.vbar(y[index],
         top = value,
           width = width,alpha = .4,
           legend_label = y_lab[index],
           muted_alpha = .9)
graph.add_layout(graph.legend[0], 'right')


# enable hiding of the glyphs
graph.legend.click_policy = "mute"

# displaying the model
show(graph)