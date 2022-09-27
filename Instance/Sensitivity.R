# install.packages("haven")
# install.packages("dplyr")
# install.packages("ggalt")
# install.packages("gridExtra")
# install.packages("tidyverse")
library(haven)
library(ggplot2)
library(dplyr)
library(tidyverse)
library(gridExtra)

data <- read.csv(r'(C:\Users\1000257489\Documents\2022\Angelina\Study\Beautiful_Visualization_with_Python\Code_Angelina\Instance\summary_df.csv)')
# View(head(data))

# plot two graphs in one chart
ggplot(data, aes(OWP_BIN, y=TSE2_FR, colour=RMK))+
  geom_col(aes(x = OWP_BIN, y=Qty*0.0025/110000, fill=NULL), 
           alpha=0, position = position_identity(), 
           linetype='dashed', width=0.5)+
  geom_line(size=0.7)+
  scale_y_continuous(limits=c(0, 0.0025), 
                     labels=scales::percent, 
                     oob = scales::squish_infinite,
                     name = 'TSE2 FR',
                     sec.axis = sec_axis(trans =  ~ . *(110000/0.0025), 
                                         name = 'Qty'))+
  # scale_x_continuous(limits = c(22, 36))+
  ggtitle('PCM TSE2 FR vs. OWP Sensitivity')+
  # theme_light()+
  theme(aspect.ratio = 0.7, 
        legend.position = c(0.75, 0.8), 
        legend.background = element_blank(),
        legend.text = element_text(size=10),
        axis.text = element_text(size = 12),
        plot.title = element_text(hjust = 0.5))
ggsave(r'(C:\Users\1000257489\Documents\2022\Angelina\R\Started\Sensitivity.png)', 
       width = 8, height = 6, units = "in", dpi=100)


# plot two graphs on one page
p1 <- ggplot(data, aes(OWP_BIN, y=TSE2_FR, colour=RMK))+
  geom_line(size=0.5)+
  scale_y_continuous(limits=c(0, 0.0025), 
                     labels=scales::percent, 
                     oob = scales::squish_infinite,
                     name = 'TSE2 FR')+
  theme(aspect.ratio = 0.7, 
        legend.position = c(0.8, 0.8), 
        legend.background = element_blank(),
        legend.text = element_text(size=7),
        axis.text = element_text(size = 10))

p2 <- ggplot(data, aes(OWP_BIN, y=Qty, colour=RMK, fill = NULL))+
  geom_col(alpha=0, position = position_identity(), 
           linetype='dashed', width=0.5)+
  scale_y_log10(breaks = scales::trans_breaks("log10", function(x) 10^x),
                labels = scales::trans_format("log10", scales::math_format(10^.x)))+
  theme(aspect.ratio = 0.7, 
        legend.position = c(0.8, 0.8), 
        legend.background = element_blank(),
        legend.text = element_text(size=7),
        axis.text = element_text(size = 10))
print(p2)

pdf(r"(C:\Users\1000257489\Documents\2022\Angelina\R\Started\Sensitivity_v1.pdf)")
grid.arrange(p1, p2, ncol=1)
dev.off()
