library(dplyr)
library(ggplot2)
library(ggtext)

# LOAD DATA
df <- read.csv("./data/harrys_house_audio_features.csv")

# DATA PROCESSING
df <- df %>%
  mutate(loudness = (loudness - min(loudness))/(max(loudness) - min(loudness))) %>%
  select(song_name, acousticness, danceability,
         energy, loudness, valence, speechiness) %>%
  tidyr::pivot_longer(cols = 2:7, names_to = "audio_features", values_to = "values") 

# Data Visualization
df %>%
  ggplot(aes(x=1,y=1, label = round(values,3), color = audio_features, size = values)) +
  geom_jitter(position = position_jitter(width = 0.03, height = 0.2)) + 
  geom_text(size=2, position=position_jitter(width = 0.01, height = 0.1), fontface='bold') + 
  scale_size_area(max_size = 15) +
  scale_color_manual(values = c("#C8B486", "#87342F", "#DFC34A", "#315C03", "#8A6542", "#255071")) + 
  coord_cartesian(clip = "off") +
  theme_light() +
  facet_wrap(~song_name) +
  theme(
    axis.text = element_blank(),
    axis.title = element_blank(),
    panel.grid = element_blank(),
    #strip.text = element_text(color='black', size=5),
    strip.text = element_textbox_simple(size=8, color='black', height = 0.03),
  )

