library(WebPower)
#### Plot functions ####
# Static plot
plot_results <- function(sample_steps, eff_size, anal_label){
  plot(sample_steps, eff_size[1,], type = "p",col = "red",
       main = anal_label, 
       xlab = "Total sample size",
       ylab = "Effect size", xaxt='n')
  axis(1, at =seq(10, 210, 10))
  lines(sample_steps, eff_size[2,], type = "p", col="blue")
  lines(sample_steps, eff_size[3,], type = "p", col="green")
  legend(max(sample_steps)*.8,max(eff_size)*.8, c("power = .8", "power = .85", "power = .9"), pch = "ooo", col = c("red", "blue", "green"))
}

# Interactive plot
inter_plot_results <- function(sample_steps, eff_size, anal_label){
  df <- data.frame(sample_size = rep(sample_steps,3), 
                   eff_size = c(eff_size[1,],eff_size[2,],eff_size[3,]),
                   power = c(rep(80,length(sample_steps)), rep(85,length(sample_steps)), rep(90,length(sample_steps))))
  df$power <- as.factor(df$power)
  
  # Create a plot in ggplot
  static_plot <- ggplot(data = df, 
                        aes(x = sample_size, y = eff_size, group = power, color = power)) +
    geom_line() + geom_point() +
    labs(x = "Total sample size", y = "Effect size", title = anal_label) +
    theme_bw() + theme(panel.grid.major = element_blank()) +
    theme(
      title = element_text(size = 8),
      axis.title = element_text(size = 10))
    
  
  # Make it interactive
  inter_plot <- ggplotly(static_plot)
  
  # Export the html
  output_folder = "/Users/javierortiz/Documents/Projects/to-future-me/sample_size_plots/"
  htmlwidgets::saveWidget(as_widget(inter_plot), 
                          paste(output_folder, anal_label, ".html", sep=""))
  
}

#### One-tailed t test (matched samples) #### 
# Predict effect size given samples
anal_label <- "One-tailed t test (matched samples) - alpha = .05; ES = d"
sample_steps <- seq(10,100,5)
power_steps <- seq(.8,.90,.05)
eff_size <- matrix(NA, nrow = 4, ncol = 19)
d = 1
for(c_power in power_steps){
  c = 1
  for(step in sample_steps){
    temp <- wp.t(n1=step, n2=step, power=c_power, type="paired", alternative="greater")
    eff_size[d,c] <- temp$d
    c = c+1
  }
  d = d+1
}
inter_plot_results(sample_steps, eff_size, anal_label)

#### Two-tailed t test (matched samples) #### 
# Predict effect size given samples
anal_label <- "Two-tailed t test (matched samples) - alpha = .05; ES = d"
sample_steps <- seq(10,100,5)
power_steps <- seq(.8,.90,.05)
eff_size <- matrix(NA, nrow = 4, ncol = 19)
d = 1
for(c_power in power_steps){
  c = 1
  for(step in sample_steps){
    temp <- wp.t(n1=step, n2=step, power=c_power, type="paired", alternative="two.sided")
    eff_size[d,c] <- temp$d
    c = c+1
  }
  d = d+1
}
inter_plot_results(sample_steps, eff_size, anal_label)

#### One-way repeated measures ANOVA (3 levels) #### 
# Predict effect size given samples
anal_label <- "One-way ANOVA (3 levels) - alpha = .05; ES = f"
sample_steps <- seq(10,100,5)
power_steps <- seq(.8,.90,.05)
eff_size <- matrix(NA, length(power_steps), ncol = length(sample_steps))
d = 1
for(c_power in power_steps){
  c = 1
  for(step in sample_steps){
    temp <- wp.rmanova(n = step, ng = 1, nm= 3, f=NULL, alpha = .05, type = 1, nscor = 1, power=c_power)
    eff_size[d,c] <- temp$f
    c = c+1
  }
  d = d+1
}
inter_plot_results(sample_steps, eff_size, anal_label)

#### Mixed design: 3 (within) by 3 (between) ####
# Predict effect size given samples
anal_label <- "Mixed design: 3 (within) by 3 (between). alpha = .05. Eff. Size = f"
sample_steps <- seq(10,200,5)
power_steps <- seq(.8,.90,.05)
eff_size <- matrix(NA, nrow = length(power_steps), ncol = length(sample_steps))
d = 1
for(c_power in power_steps){
  c = 1
  for(step in sample_steps){
    temp <- wp.rmanova(n = step, ng = 3, nm= 3, f=NULL, alpha = .05, type = 2, nscor = 1, power=c_power)
    #temp <- wp.t(n1=step, n2=step, power=c_power, type="paired", alternative="greater")
    eff_size[d,c] <- temp$f
    c = c+1
  }
  d = d+1
}
inter_plot_results(sample_steps, eff_size, anal_label)


wp.rmanova(n = NULL, ng = 3, nm= 3, f=.25, alpha = .05, type = 2, nscor = 1, power=.8) # ~193
wp.rmanova(n = 192, ng = 3, nm= 3, f=.25, alpha = .05, type = 2, nscor = 1, power=NULL)
