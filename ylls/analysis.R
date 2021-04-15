# A brief look at self harm data, downloaded from http://ihmeuw.org/3zn8
# Make sure to *clearly label* all charts and files you create

# Set up
# Set working directory using the Session menu
library(dplyr)
library(ggplot2)
library(tidyr)


# Load data
self_harm_data <- read.csv("data/prepped/self-harm.csv")
View(self_harm_data)

# Deal with string age-groups
self_harm_data <- self_harm_data %>%
  filter(Value > 0) %>%
  mutate(age_group = substr(Age, 1, 2))

###########################################################################
### Create a plot of the death rate (deaths per 100K) in each age-group ###
###########################################################################

# Filter the data (to only the death rate rows)
death_rate_self_harm_data <- self_harm_data %>%
  select(Location, Year, Age, Sex, Cause.of.death.or.injury, Measure, Value) %>%
  filter(self_harm_data$Measure == "Deaths per 100,000")
  
# Create the chart (age on X axis, death rate on Y axis)
death_rate_plot <- ggplot(death_rate_self_harm_data) +
  geom_col(mapping = aes(x = Age, y = Value)) +
  labs(title = "Self Harm Death Rate per 100,000",
       x = "Age",
       y = "Death Rate (deaths per 100,000)",
       color = "Default"
       )

# Save you chart to the `charts/` folder for grading
# Exported as image into charts folder

#######################################################################
### Create a plot of the yll rate (ylls per 100K) in each age-group ###
#######################################################################

# Filter the data (to only the ylls rate rows)
ylls_rate_self_harm_data <- self_harm_data %>%
  select(Location, Year, Age, Sex, Cause.of.death.or.injury, Measure, Value) %>%
  filter(self_harm_data$Measure == "YLLs per 100,000")

# Create the chart (age on X axis, death rate on Y axis)
ylls_rate_plot <- ggplot(ylls_rate_self_harm_data) +
  geom_col(mapping = aes(x = Age, y = Value)) +
  labs(title = "Self Harm YLLs Rate per 100,000",
       x = "Age",
       y = "YLLs Rate (deaths per 100,000)",
       color = "Default"
  )

# Save you chart to the `charts/` folder for grading
# Exported as image into charts folder

###########################################################################
### Create a plot of comparing the YLL rate to the Death Rate (scatter) ###
###########################################################################

# Reshape (e.g., `spread()`) your data to have separate column for each metric
reshape_data <- self_harm_data %>%
  select(Location, Year, Age, Sex, Cause.of.death.or.injury, Measure, Value) %>%
  spread(Measure, Value, fill = NA, convert = FALSE)

# Create a scatter plot of the YLL rate v.s. the death rate
# Label the age of each point
scatter_plot <- ggplot(reshape_data) +
  geom_point(mapping = aes(x = `YLLs per 100,000`, y = `Deaths per 100,000`)) +
  labs(title = "YLL rate v.s. the Death rate",
        x = "YLLs per 100,000",
        y = "Deaths per 100,000)",
        color = "Default"
    )

# Save you chart to the `charts/` folder for grading
# Exported as image into charts folder