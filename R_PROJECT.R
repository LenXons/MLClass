## Describe the Dataset
# Install & Load library
library(dplyr) # dplyr is used to calculate the mean and standard deviation 

# Load the dataset
df <- read.csv(
  "C:/Users/showe/Downloads/Data Science Reference Tools/cheese_data.csv"
  )

# View structure
str(df)

# Summary statistics
summary(df)

#------------------------------------------------------------------------------#

## Statistical Analysis

#Total number of each ManufacturingType in BC
total_manu_number_bc <- subset(df, ManufacturerProvCode == "BC")
table(total_manu_number_bc$ManufacturingTypeEn)

# Total number of cheese by province
table(df$ManufacturerProvCode)

## Produce statistics on the MoisturePercent
#The cheese category type which has the greatest moisture percent
max_moisture_percent <- df[which.max(df$MoisturePercent),
                            c("CategoryTypeEn", "MoisturePercent")]

# The deviation by category of the moisture percent
mean_moisture_percent <- mean(df$MoisturePercent, na.rm = TRUE) # ignore Null values
sd_moisture_percent <- sd(df$MoisturePercent, na.rm = TRUE)  # ignore Null values

deviation <- df %>%
  group_by(CategoryTypeEn) %>%
  summarize(
    mean_moisture_percent,
    sd_moisture_percent
  )

#------------------------------------------------------------------------------#

## Create a dataframe of Cheese in ON only and with these columns only CheeseID,
## ManufacurerProvince,ManufacturingType,FlavourEn,MoisturePercent, Organic
on_df <- df %>%
  filter(
    ManufacturerProvCode == "ON"
    ) %>%
  select(
    CheeseId, 
    ManufacturerProvCode, 
    ManufacturingTypeEn, 
    FlavourEn, 
    MoisturePercent, 
    Organic
    )

#------------------------------------------------------------------------------#

## Remove all the entries with FlavourEn being NA in this dataset
sum_null <- sum(is.na(df$FlavourEn)) # sum Null from column FlavourEn
sum_null
# The result is 0 which means there are empty string instead of Null values

empty_str <- table(df$FlavourEn == "") # Check if empty strings exist
empty_str
# Confirmed that there are 241 empty strings

#Remove all the empty entries from FlavourEn in this dataset
null_remove <- df %>%
  filter(FlavourEn != "")

#------------------------------------------------------------------------------#

## Find the number of organic and non-organic types from this dataframe
organic_count <- table(df$Organic)
organic_count
# 99 organic and 943 non-organic

#------------------------------------------------------------------------------#
## Create another dataframe with MoisturePercent which is 2SD(2 times) within
## the mean of ON
# Calculate mean and standard deviation for MoisturePercent from ON dataset
on_moisture_mean <- mean(on_df$MoisturePercent, na.rm = TRUE)
on_moisture_sd <- sd(on_df$MoisturePercent, na.rm = TRUE)

# Filter data for MoisturePercent within 2 SD
on_moisture_2sd <- on_df %>%
  filter(MoisturePercent >= (on_moisture_mean - 2 * on_moisture_sd) &
           MoisturePercent <= (on_moisture_mean + 2 * on_moisture_sd))

on_moisture_2sd
