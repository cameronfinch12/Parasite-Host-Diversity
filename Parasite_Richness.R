getwd()

library(tidyverse)

# Remove unused columns
DRE_Cleaned_1 <- DRE_Diversity_DF_25_March_2020 %>% 
  select(-any_of(c(
    "S2", "S3", "S4", "S", "mpd.obs.z",
    "dummy_1", "dummy_2", "dummy_3", "dummy_4", "dummy_5",
    "resources", "diversity", "month"
  )))

# Remove 2013 data
DRE_Filtered <- DRE_Cleaned_1 %>%
  filter(Year != 2013)

# Remove Year, Plot, PlotID, and S5m, then rename uniqueid to Plot
DRE_PreFinal <- DRE_Filtered %>%
  select(-any_of(c("Year", "Plot", "PlotID", "S5m"))) %>%
  rename(Plot = uniqueid)

# Create 0/1 species columns
DRE_PreFinal <- DRE_PreFinal %>%
  mutate(
    ANVI = if_else(Div == 0, as.integer(spp == "ANVI"), as.integer(spp != "ANVI")),
    SEPA = if_else(Div == 0, as.integer(spp == "SEPA"), as.integer(spp != "SEPA")),
    TRFL = if_else(Div == 0, as.integer(spp == "TRFL"), as.integer(spp != "TRFL")),
    PAAN = if_else(Div == 0, as.integer(spp == "PAAN"), as.integer(spp != "PAAN")),
    SCIN = if_else(Div == 0, as.integer(spp == "SCIN"), as.integer(spp != "SCIN")),
    SOPI = if_else(Div == 0, as.integer(spp == "SOPI"), as.integer(spp != "SOPI"))
  )

