## ----setup, include=FALSE-----------------------------
knitr::opts_chunk$set(dpi = 200, out.height = 600, out.width = 600, R.options = list(max.print = 100))


## ----load-tidyverse-package, message=FALSE------------
library(ggplot2)


## ----load-ratdat-package,message=FALSE----------------
library(ratdat)


## ----data-help----------------------------------------
?complete_old


## ----view-data, eval=FALSE----------------------------
# View(complete_old)


## ----str----------------------------------------------
str(complete_old)


## ----bare-plot----------------------------------------
ggplot(data = complete_old)


## ----plot-with-axes-----------------------------------
# adding a mapping to x and y axes
ggplot(data = complete_old, mapping = aes(x = weight, y = hindfoot_length))


## ----scatter-plot-------------------------------------
ggplot(data = complete_old, mapping = aes(x = weight, y = hindfoot_length)) +
  geom_point()


## ----geom-error---------------------------------------
ggplot(data = complete_old, mapping = aes(x = weight, y = hindfoot_length)) +
  geom_poit()


## ----change-alpha, warning=FALSE----------------------
ggplot(data = complete_old, mapping = aes(x = weight, y = hindfoot_length)) +
  geom_point(alpha = 0.2)


## ----change-color, warning=FALSE----------------------
ggplot(data = complete_old, mapping = aes(x = weight, y = hindfoot_length)) +
  geom_point(alpha = 0.2, color = "blue")


## ----no-closing-bracket, eval=FALSE, warning=FALSE----
# ggplot(data = complete_old, mapping = aes(x = weight, y = hindfoot_length)) +
#   geom_point(color = "blue", alpha = 0.2


## ----no-closing-quote, eval=FALSE, warning=FALSE------
# ggplot(data = complete_old, mapping = aes(x = weight, y = hindfoot_length)) +
#   geom_point(color = "blue, alpha = 0.2)


## ----extra-bracket, eval=FALSE, warning=FALSE---------
# ggplot(data = complete_old, mapping = aes(x = weight, y = hindfoot_length)) +
#   geom_point(color = "blue", alpha = 0.2))


## ----color-plot-type, warning=FALSE-------------------
ggplot(data = complete_old, mapping = aes(x = weight, y = hindfoot_length, color = plot_type)) +
  geom_point(alpha = 0.2)


## ----modify-points-challenge-answer, warning=FALSE----
ggplot(data = complete_old, 
       mapping = aes(x = weight, y = hindfoot_length, shape = sex)) +
  geom_point(alpha = 0.2)


## ----modify-color-challenge-answer, warning=FALSE-----
ggplot(data = complete_old, 
       mapping = aes(x = weight, y = hindfoot_length, color = year)) +
  geom_point(alpha = 0.2)


## ----scale-viridis, warning=FALSE---------------------
ggplot(data = complete_old, mapping = aes(x = weight, y = hindfoot_length, color = plot_type)) +
  geom_point(alpha = 0.2) +
  scale_color_viridis_d()


## ----scale-log, warning=FALSE-------------------------
ggplot(data = complete_old, mapping = aes(x = weight, y = hindfoot_length, color = plot_type)) +
  geom_point(alpha = 0.2) +
  scale_x_log10()


## ----blank-boxplot------------------------------------
ggplot(data = complete_old, mapping = aes(x = plot_type, y = hindfoot_length))


## ----boxplot------------------------------------------
ggplot(data = complete_old, mapping = aes(x = plot_type, y = hindfoot_length)) +
  geom_boxplot()


## ----boxplot-color, warning=FALSE---------------------
ggplot(data = complete_old, mapping = aes(x = plot_type, y = hindfoot_length, color = plot_type)) +
  geom_boxplot()


## ----boxplot-fill, warning=FALSE----------------------
ggplot(data = complete_old, mapping = aes(x = plot_type, y = hindfoot_length, fill = plot_type)) +
  geom_boxplot()


## ----boxplot-label-wrap, warning=FALSE----------------
ggplot(data = complete_old, mapping = aes(x = plot_type, y = hindfoot_length, fill = plot_type)) +
  geom_boxplot() +
  scale_x_discrete(labels = label_wrap_gen(width = 10))


## ----boxplot-points, warning=FALSE--------------------
ggplot(data = complete_old, mapping = aes(x = plot_type, y = hindfoot_length)) +
  geom_boxplot() +
  geom_point(alpha = 0.2)


## ----boxplot-jitter, warning=FALSE--------------------
ggplot(data = complete_old, mapping = aes(x = plot_type, y = hindfoot_length)) +
  geom_boxplot() +
  geom_jitter(alpha = 0.2)


## ----boxplot-outliers, warning = F--------------------
ggplot(data = complete_old, mapping = aes(x = plot_type, y = hindfoot_length)) +
  geom_boxplot(outlier.shape = NA) +
  geom_jitter(alpha = 0.2)


## ----global-color, warning=FALSE----------------------
ggplot(data = complete_old, mapping = aes(x = plot_type, y = hindfoot_length, color = plot_type)) +
  geom_boxplot(outlier.shape = NA) +
  geom_jitter(alpha = 0.2)


## ----geom-color, warning=FALSE------------------------
ggplot(data = complete_old, mapping = aes(x = plot_type, y = hindfoot_length)) +
  geom_boxplot(outlier.shape = NA) +
  geom_jitter(aes(color = plot_type), alpha = 0.2)


## ----reverse-layers, warning=FALSE--------------------
ggplot(data = complete_old, mapping = aes(x = plot_type, y = hindfoot_length)) +
  geom_jitter(aes(color = plot_type), alpha = 0.2) +
  geom_boxplot(outlier.shape = NA)


## ----fill-na, warning=FALSE---------------------------
ggplot(data = complete_old, mapping = aes(x = plot_type, y = hindfoot_length)) +
  geom_jitter(aes(color = plot_type), alpha = 0.2) +
  geom_boxplot(outlier.shape = NA, fill = NA)


## ----violin-challenge-answer, warning=FALSE-----------
ggplot(data = complete_old, 
       mapping = aes(x = plot_type, 
                     y = hindfoot_length,
                     color = plot_type)) +
  geom_jitter(alpha = 0.2) +
  geom_violin(fill = "white")


## ----violin-challenge-answer-2, warning=FALSE---------
ggplot(data = complete_old, 
       mapping = aes(x = plot_type, 
                     y = hindfoot_length,
                     color = plot_type)) +
  geom_jitter(alpha = 0.2) +
  geom_violin(fill = "white")


## -----------------------------------------------------
myplot <- ggplot(data = complete_old, mapping = aes(x = plot_type, y = hindfoot_length)) +
  geom_jitter(aes(color = plot_type), alpha = 0.2) +
  geom_boxplot(outlier.shape = NA, fill = NA)

myplot


## ----theme-bw, warning=FALSE--------------------------
myplot + theme_bw()


## ----text-size, warning=FALSE-------------------------
myplot +
  theme_bw() +
  theme(axis.title = element_text(size = 14))


## ----element-blank, warning=FALSE---------------------
myplot +
  theme_bw() +
  theme(axis.title = element_text(size = 14), 
        panel.grid.major.x = element_blank())


## ----legend-remove, warning=FALSE---------------------
myplot +
  theme_bw() +
  theme(axis.title = element_text(size = 14), 
        panel.grid.major.x = element_blank(), 
        legend.position = "none")



## ----labels, warning=FALSE----------------------------
myplot +
  theme_bw() +
  theme(axis.title = element_text(size = 14), 
        legend.position = "none") +
  labs(title = "Rodent size by plot type",
       x = "Plot type",
       y = "Hindfoot length (mm)")


## ----customizing-challenge-answer, warning=FALSE------
myplot +
  theme_bw() +
  theme(axis.title = element_text(size = 14), legend.position = "none",
        plot.title = element_text(face = "bold", size = 20)) +
  labs(title = "Rodent size by plot type",
       subtitle = "Long-term dataset from Portal, AZ",
       x = "Plot type",
       y = "Hindfoot length (mm)")


## ----facet-wrap, warning=FALSE------------------------
myplot +
  theme_bw() +
  theme(axis.title = element_text(size = 14), 
        legend.position = "none", 
        panel.grid.major.x = element_blank()) +
  labs(title = "Rodent size by plot type",
       x = "Plot type",
       y = "Hindfoot length (mm)",
       color = "Plot type") +
  facet_wrap(vars(sex), ncol = 1)


## ----assign-finalplot---------------------------------
finalplot <- myplot +
  theme_bw() +
  theme(axis.title = element_text(size = 14), 
        legend.position = "none", 
        panel.grid.major.x = element_blank()) +
  labs(title = "Rodent size by plot type",
       x = "Plot type",
       y = "Hindfoot length (mm)",
       color = "Plot type") +
  facet_wrap(vars(sex), ncol = 1)


## ----save-plot, eval=FALSE----------------------------
# ggsave(filename = "images/rodent_size_plots.jpg", plot = finalplot,
#        height = 6, width = 8)

